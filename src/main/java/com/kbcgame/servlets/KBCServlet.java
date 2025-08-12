package com.kbcgame.servlets;

import com.kbcgame.util.DBConnection;
import com.kbcgame.model.Question;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@WebServlet("/kbc")
public class KBCServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int TOTAL_QUESTIONS = 15;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "start";
        }

        switch (action) {
            case "lifeline": handleLifeline(request, response); break;
            case "quit": handleQuit(request, response); break;
            case "nextQuestion": handleNextQuestion(request, response); break;
            case "start":
            default: startGame(request, response); break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("userName");
        Integer questionIndex = (Integer) session.getAttribute("questionIndex");
        Integer activeQuestionId = (Integer) session.getAttribute("activeQuestionId");

        if (questionIndex == null || activeQuestionId == null || username == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String timeout = request.getParameter("timeout");
        if ("true".equals(timeout)) {
            String prizeMoneyStr = getCheckpointPrizeMoney(questionIndex);
            updateUserStats(username, 0, parsePrizeMoney(prizeMoneyStr));

            request.setAttribute("correctAnswer", getCorrectAnswer(activeQuestionId));
            request.setAttribute("timeoutMessage", "You ran out of time!");
            request.setAttribute("prizeMoney", prizeMoneyStr);
            request.setAttribute("explanation", getExplanation(activeQuestionId));
            
            session.removeAttribute("questionIndex");
            session.removeAttribute("activeQuestionId");
            session.removeAttribute("lifelines");
            RequestDispatcher dispatcher = request.getRequestDispatcher("gameover.jsp");
            dispatcher.forward(request, response);
            return;
        }

        String userAnswer = request.getParameter("option");
        String correctAnswer = getCorrectAnswer(activeQuestionId);

        if (userAnswer != null && userAnswer.equals(correctAnswer)) {
            // Correct answer
            if (questionIndex >= TOTAL_QUESTIONS) {
                String prizeMoneyStr = getPrizeMoney(TOTAL_QUESTIONS);
                updateUserStats(username, 0, parsePrizeMoney(prizeMoneyStr));

                session.removeAttribute("questionIndex");
                session.removeAttribute("activeQuestionId");
                session.removeAttribute("lifelines");
                RequestDispatcher dispatcher = request.getRequestDispatcher("winner.jsp");
                dispatcher.forward(request, response);
                return;
            }
            String prizeMoney = getPrizeMoney(questionIndex);
            String explanation = getExplanation(activeQuestionId);
            request.setAttribute("prizeMoney", prizeMoney);
            request.setAttribute("explanation", explanation);
            RequestDispatcher dispatcher = request.getRequestDispatcher("correctAnswer.jsp");
            dispatcher.forward(request, response);

        } else {
            // Wrong answer
            String prizeMoneyStr = getCheckpointPrizeMoney(questionIndex);
            updateUserStats(username, 0, parsePrizeMoney(prizeMoneyStr));
            
            request.setAttribute("correctAnswer", correctAnswer);
            request.setAttribute("prizeMoney", prizeMoneyStr);
            request.setAttribute("explanation", getExplanation(activeQuestionId));
            session.removeAttribute("questionIndex");
            session.removeAttribute("activeQuestionId");
            session.removeAttribute("lifelines");
            RequestDispatcher dispatcher = request.getRequestDispatcher("gameover.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void startGame(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("userName");
        
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        updateUserStats(username, 1, 0);

        Map<String, Boolean> lifelines = new HashMap<>();
        lifelines.put("fiftyFifty", true);
        lifelines.put("audiencePoll", true);
        lifelines.put("expertAdvice", true);
        lifelines.put("flipQuestion", true);
        session.setAttribute("lifelines", lifelines);
        session.setAttribute("questionIndex", 1);
        session.setAttribute("activeQuestionId", 1); 
        loadQuestion(request, response, 1);
    }

    private void handleQuit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("userName");
        Integer questionIndex = (Integer) session.getAttribute("questionIndex");

        if (username == null || questionIndex == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int lastSafeLevel = (questionIndex > 1) ? questionIndex - 1 : 0;
        String prizeMoneyStr = getPrizeMoney(lastSafeLevel);

        updateUserStats(username, 0, parsePrizeMoney(prizeMoneyStr));
        
        request.setAttribute("prizeMoney", prizeMoneyStr);
        session.removeAttribute("questionIndex");
        session.removeAttribute("activeQuestionId");
        session.removeAttribute("lifelines");
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("quit.jsp");
        dispatcher.forward(request, response);
    }
    
    private void updateUserStats(String username, int gamesPlayedIncrement, long winningsToAdd) {
        String sql = "UPDATE Users SET games_played = games_played + ?, total_winnings = total_winnings + ? WHERE username = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            pstmt.setInt(1, gamesPlayedIncrement);
            pstmt.setLong(2, winningsToAdd);
            pstmt.setString(3, username);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * ✨ FIX: Rewritten method to accurately parse all prize money formats. ✨
     */
    private long parsePrizeMoney(String prizeStr) {
        if (prizeStr == null || prizeStr.equals("₹0")) {
            return 0;
        }
        
        // Remove currency symbol and commas for easier parsing
        String cleanStr = prizeStr.replace("₹", "").replace(",", "").trim();
        
        // Split the string into number and unit (like "Crore" or "Lakh")
        String[] parts = cleanStr.split(" ");
        
        long value = 0;
        
        if (parts.length > 0) {
            try {
                value = Long.parseLong(parts[0]);
                
                if (parts.length > 1) {
                    String unit = parts[1].toLowerCase();
                    if (unit.equals("crore")) {
                        value *= 10000000;
                    } else if (unit.equals("lakh")) {
                        value *= 100000;
                    }
                }
            } catch (NumberFormatException e) {
                System.err.println("Could not parse prize money string: " + prizeStr);
                return 0; // Return 0 if parsing fails
            }
        }
        return value;
    }

    // --- All other methods remain unchanged ---
    
    private void handleNextQuestion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer questionIndex = (Integer) session.getAttribute("questionIndex");
        if (questionIndex != null) {
            int nextQuestionIndex = questionIndex + 1;
            session.setAttribute("questionIndex", nextQuestionIndex);
            session.setAttribute("activeQuestionId", nextQuestionIndex);
            loadQuestion(request, response, nextQuestionIndex);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
    
    private String getExplanation(int questionId) {
        String explanation = "No explanation found.";
        String sql = "SELECT Explanation FROM Questions WHERE QuestionID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, questionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    explanation = rs.getString("Explanation");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return explanation;
    }

    private String getCheckpointPrizeMoney(int failedQuestionIndex) {
        if (failedQuestionIndex <= 5) {
            return "₹0";
        } else if (failedQuestionIndex <= 10) {
            return getPrizeMoney(5);
        } else {
            return getPrizeMoney(10);
        }
    }

    private void handleLifeline(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String type = request.getParameter("type");
        Integer activeQuestionId = (Integer) session.getAttribute("activeQuestionId");
        Map<String, Boolean> lifelines = (Map<String, Boolean>) session.getAttribute("lifelines");
        if (type != null && activeQuestionId != null && lifelines != null && lifelines.getOrDefault(type, false)) {
            lifelines.put(type, false);
            session.setAttribute("lifelines", lifelines);
            switch (type) {
                case "fiftyFifty": handleFiftyFifty(request, response, activeQuestionId); break;
                case "audiencePoll": handleAudiencePoll(request, response, activeQuestionId); break;
                case "expertAdvice": handleExpertAdvice(request, response, activeQuestionId); break;
                case "flipQuestion": handleFlipQuestion(request, response); break;
            }
        } else {
            loadQuestion(request, response, activeQuestionId);
        }
    }

    private void handleFlipQuestion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer questionIndex = (Integer) session.getAttribute("questionIndex");
        int newQuestionId = questionIndex + 15;
        session.setAttribute("activeQuestionId", newQuestionId);
        loadQuestion(request, response, newQuestionId);
    }
    
    private void handleFiftyFifty(HttpServletRequest request, HttpServletResponse response, int questionId) throws ServletException, IOException {
        Question q = getQuestionFromDB(questionId);
        String correctAnswer = getCorrectAnswer(questionId);
        List<String> incorrectOptions = new ArrayList<>();
        if (!q.getOptionA().equals(correctAnswer)) incorrectOptions.add("A");
        if (!q.getOptionB().equals(correctAnswer)) incorrectOptions.add("B");
        if (!q.getOptionC().equals(correctAnswer)) incorrectOptions.add("C");
        if (!q.getOptionD().equals(correctAnswer)) incorrectOptions.add("D");
        Collections.shuffle(incorrectOptions);
        if (incorrectOptions.size() > 1) {
            if ("A".equals(incorrectOptions.get(0)) || "A".equals(incorrectOptions.get(1))) q.setOptionA(null);
            if ("B".equals(incorrectOptions.get(0)) || "B".equals(incorrectOptions.get(1))) q.setOptionB(null);
            if ("C".equals(incorrectOptions.get(0)) || "C".equals(incorrectOptions.get(1))) q.setOptionC(null);
            if ("D".equals(incorrectOptions.get(0)) || "D".equals(incorrectOptions.get(1))) q.setOptionD(null);
        }
        request.setAttribute("currentQuestion", q);
        request.setAttribute("timeLimit", getTimeLimitForQuestion(questionId));
        RequestDispatcher dispatcher = request.getRequestDispatcher("kbc.jsp");
        dispatcher.forward(request, response);
    }

    private void handleAudiencePoll(HttpServletRequest request, HttpServletResponse response, int questionId) throws ServletException, IOException {
        String correctAnswerLetter = getCorrectAnswerLetter(questionId);
        Map<String, Integer> pollResults = new HashMap<>();
        Random rand = new Random();
        int correctPercent = 40 + rand.nextInt(31);
        int remainingPercent = 100 - correctPercent;
        pollResults.put("A", 0); pollResults.put("B", 0); pollResults.put("C", 0); pollResults.put("D", 0);
        pollResults.put(correctAnswerLetter, correctPercent);
        List<String> options = new ArrayList<>(List.of("A", "B", "C", "D"));
        options.remove(correctAnswerLetter);
        int p1 = rand.nextInt(remainingPercent + 1);
        int p2 = rand.nextInt(remainingPercent - p1 + 1);
        int p3 = remainingPercent - p1 - p2;
        pollResults.put(options.get(0), p1);
        pollResults.put(options.get(1), p2);
        pollResults.put(options.get(2), p3);
        request.setAttribute("pollResults", pollResults);
        loadQuestion(request, response, questionId);
    }

    private void handleExpertAdvice(HttpServletRequest request, HttpServletResponse response, int questionId) throws ServletException, IOException {
        String correctAnswerLetter = getCorrectAnswerLetter(questionId);
        Random rand = new Random();
        String advice;
        if (rand.nextInt(100) < 85) {
            advice = "Our expert is confident the answer is " + correctAnswerLetter + ".";
        } else {
            List<String> options = new ArrayList<>(List.of("A", "B", "C", "D"));
            options.remove(correctAnswerLetter);
            advice = "Our expert thinks the answer might be " + options.get(rand.nextInt(options.size())) + ".";
        }
        request.setAttribute("expertAdvice", advice);
        loadQuestion(request, response, questionId);
    }

    private void loadQuestion(HttpServletRequest request, HttpServletResponse response, int questionId) throws ServletException, IOException {
        Question question = getQuestionFromDB(questionId);
        if (question != null) {
            request.setAttribute("timeLimit", getTimeLimitForQuestion(question.getQuestionId()));
            request.setAttribute("currentQuestion", question);
            RequestDispatcher dispatcher = request.getRequestDispatcher("kbc.jsp");
            dispatcher.forward(request, response);
        } else {
            response.getWriter().println("<h1>Error</h1><p>Could not find question with ID " + questionId + ".</p>");
        }
    }

    private Question getQuestionFromDB(int questionId) {
        Question question = null;
        String sql = "SELECT * FROM Questions WHERE QuestionID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, questionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    question = new Question();
                    question.setQuestionId(rs.getInt("QuestionID"));
                    question.setQuestion(rs.getString("Question"));
                    question.setOptionA(rs.getString("OptionA"));
                    question.setOptionB(rs.getString("OptionB"));
                    question.setOptionC(rs.getString("OptionC"));
                    question.setOptionD(rs.getString("OptionD"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return question;
    }

    private String getCorrectAnswer(int questionId) {
        String correctAnswer = null;
        String sql = "SELECT CorrectAns FROM Questions WHERE QuestionID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, questionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    correctAnswer = rs.getString("CorrectAns");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return correctAnswer;
    }

    private String getCorrectAnswerLetter(int questionId) {
        Question q = getQuestionFromDB(questionId);
        String correctAnswer = getCorrectAnswer(questionId);
        if (q != null && correctAnswer != null) {
            if (correctAnswer.equals(q.getOptionA())) return "A";
            if (correctAnswer.equals(q.getOptionB())) return "B";
            if (correctAnswer.equals(q.getOptionC())) return "C";
            if (correctAnswer.equals(q.getOptionD())) return "D";
        }
        return "";
    }

    private int getTimeLimitForQuestion(int questionId) {
        int level = (questionId > 15) ? questionId - 15 : questionId;
        if (level >= 1 && level <= 5) return 30;
        if (level >= 6 && level <= 10) return 45;
        return -1;
    }

    private String getPrizeMoney(int level) {
        switch (level) {
            case 1: return "₹5,000";
            case 2: return "₹10,000";
            case 3: return "₹20,000";
            case 4: return "₹40,000";
            case 5: return "₹80,000";
            case 6: return "₹1,60,000";
            case 7: return "₹3,20,000";
            case 8: return "₹6,40,000";
            case 9: return "₹12,50,000";
            case 10: return "₹25,00,000";
            case 11: return "₹50,00,000";
            case 12: return "₹1 Crore";
            case 13: return "₹3 Crore";
            case 14: return "₹5 Crore";
            case 15: return "₹7 Crore";
            default: return "₹0";
        }
    }
}
