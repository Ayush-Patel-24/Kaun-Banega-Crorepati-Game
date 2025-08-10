package com.kbcgame.servlets; // Ensure this package name is correct for your project

import com.kbcgame.util.DBConnection; // Ensure this package name is correct
import com.kbcgame.model.Question; // Ensure this package name is correct

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

@WebServlet("/kbc")
public class KBCServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // The total number of questions in your database table.
    private static final int TOTAL_QUESTIONS = 15;

    /**
     * This method is called when the game starts (e.g., from a link in index.jsp).
     * It sets up the game by loading the very first question.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Set the starting question index to 1
        session.setAttribute("questionIndex", 1);
        
        // Load the first question
        loadQuestion(request, response, 1);
    }

    /**
     * This method is called when the user submits an answer from the kbc.jsp form.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get the current question number from the session
        Integer questionIndex = (Integer) session.getAttribute("questionIndex");

        // If for some reason the session is invalid, restart the game
        if (questionIndex == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Get the user's selected answer and the correct answer from the DB
        String userAnswer = request.getParameter("option");
        String correctAnswer = getCorrectAnswer(questionIndex);

        // Check if the user's answer is correct
        if (userAnswer != null && userAnswer.equals(correctAnswer)) {
            // --- CORRECT ANSWER ---
            int nextQuestionIndex = questionIndex + 1;

            if (nextQuestionIndex > TOTAL_QUESTIONS) {
                // User has answered all questions correctly and wins the game
                session.removeAttribute("questionIndex"); // Clean up session
                RequestDispatcher dispatcher = request.getRequestDispatcher("winner.jsp");
                dispatcher.forward(request, response);
            } else {
                // Load the next question
                session.setAttribute("questionIndex", nextQuestionIndex);
                loadQuestion(request, response, nextQuestionIndex);
            }
        } else {
            // --- WRONG ANSWER ---
            // Game over. Forward the correct answer to the game over page.
            request.setAttribute("correctAnswer", correctAnswer);
            session.removeAttribute("questionIndex"); // Clean up session
            RequestDispatcher dispatcher = request.getRequestDispatcher("gameover.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Helper method to fetch a question from the DB and forward it to the JSP.
     */
    private void loadQuestion(HttpServletRequest request, HttpServletResponse response, int questionIndex) throws ServletException, IOException {
        Question question = getQuestionFromDB(questionIndex);
        if (question != null) {
            // If question is found, attach it to the request and forward to the JSP
            request.setAttribute("currentQuestion", question);
            RequestDispatcher dispatcher = request.getRequestDispatcher("kbc.jsp");
            dispatcher.forward(request, response);
        } else {
            // This can happen if the questionId is not in the database
            response.getWriter().println("<h1>Error</h1><p>Could not find question with ID " + questionIndex + " in the database.</p>");
        }
    }

    /**
     * Retrieves a full question object from the database using its ID.
     */
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
                    // We also get the correct answer, but we don't need to set it in the object
                    // as we have a separate method to check it.
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the full error to the server console
        }
        return question;
    }

    /**
     * Retrieves only the correct answer string for a given question ID.
     */
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
            e.printStackTrace(); // Log the full error to the server console
        }
        return correctAnswer;
    }
}
