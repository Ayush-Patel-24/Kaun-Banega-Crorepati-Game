<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- ✨ FIX: Added imports for Map and HashMap ✨ --%>
<%@ page import="com.kbcgame.model.Question, java.util.Map, java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KBC - Question Time</title>
<style>
    body { font-family: Arial, sans-serif; background-color: #0c0c2c; color: white; display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; box-sizing: border-box; margin: 0; }
    .game-container { background-color: #1a1a4a; padding: 30px; border-radius: 15px; width: 100%; max-width: 800px; box-shadow: 0 0 20px rgba(255, 255, 255, 0.2); }
    .control-panel { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid rgba(255, 204, 0, 0.2); padding-bottom: 20px; }
    .lifelines { display: flex; gap: 10px; }
    .lifeline-btn, .quit-btn { background-color: #333366; border: 2px solid #666699; color: white; padding: 10px 15px; border-radius: 8px; text-decoration: none; font-weight: bold; transition: background-color 0.3s, transform 0.2s; }
    .lifeline-btn:hover, .quit-btn:hover { background-color: #4d4d8f; transform: translateY(-2px); }
    .quit-btn { background-color: #992d2d; border-color: #ff4d4d; }
    .quit-btn:hover { background-color: #b33e3e; }
    .lifeline-btn.disabled {
        background-color: #2c2c57;
        color: #666;
        cursor: not-allowed;
        opacity: 0.5;
        background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="%23ff4d4d" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>');
        background-repeat: no-repeat;
        background-position: center;
    }
    .lifeline-btn.disabled:hover {
        transform: none;
    }
    .lifeline-result-box {
        background-color: #0c0c2c;
        border: 1px solid #ffcc00;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
        text-align: left;
    }
    .lifeline-result-box h4 {
        margin-top: 0;
        color: #ffcc00;
        font-size: 1.2em;
    }
    .poll-bar-container {
        background-color: #333366;
        border-radius: 5px;
        margin: 5px 0;
        display: flex;
        align-items: center;
    }
    .poll-bar-label {
        padding-left: 10px;
        width: 30px;
    }
    .poll-bar {
        background-color: #4dff4d;
        height: 20px;
        border-radius: 5px;
        color: black;
        font-weight: bold;
        line-height: 20px;
        padding-right: 5px;
        box-sizing: border-box;
        text-align: right;
    }
    .timer-box { font-size: 2em; font-weight: bold; color: #ff4d4d; text-align: center; margin-bottom: 20px; background-color: #000; padding: 10px; border-radius: 50%; width: 80px; height: 80px; line-height: 80px; margin-left: auto; margin-right: auto; border: 3px solid #ff4d4d; }
    .question-box { background-color: #0c0c2c; border: 2px solid #ffcc00; border-radius: 10px; padding: 20px; margin-bottom: 20px; font-size: 1.5em; text-align: center; }
    .options-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
    .option { background-color: #333366; border: 2px solid #666699; border-radius: 10px; padding: 15px; cursor: pointer; transition: background-color 0.3s, border-color 0.3s; font-size: 1.2em; }
    .option:hover { background-color: #4d4d8f; border-color: #ffcc00; }
    .option.selected { background-color: #ffcc00; border-color: #ffffff; color: #0c0c2c; font-weight: bold; }
    .option input[type="radio"] { display: none; }
    .option label { display: block; width: 100%; cursor: pointer; }
    .submit-btn { display: block; width: 100%; padding: 15px; margin-top: 20px; font-size: 1.5em; font-weight: bold; color: #0c0c2c; background-color: #ffcc00; border: none; border-radius: 10px; cursor: pointer; transition: background-color 0.3s; }
    .submit-btn:hover { background-color: #ffd633; }
</style>
</head>
<body>
    <% 
        Question q = (Question) request.getAttribute("currentQuestion"); 
        Map<String, Boolean> lifelines = (Map<String, Boolean>) session.getAttribute("lifelines");
        if (lifelines == null) {
            lifelines = new HashMap<>(); // Prevent null pointer if session expires
        }
    %>
    
    <% if (q != null) { %>
    <div class="game-container">
        
        <div class="control-panel">
            <div class="lifelines">
                <a href='<%= lifelines.getOrDefault("fiftyFifty", false) ? "kbc?action=lifeline&type=fiftyFifty" : "#" %>' 
                   class='lifeline-btn <%= !lifelines.getOrDefault("fiftyFifty", false) ? "disabled" : "" %>'>50:50</a>
                <a href='<%= lifelines.getOrDefault("audiencePoll", false) ? "kbc?action=lifeline&type=audiencePoll" : "#" %>' 
                   class='lifeline-btn <%= !lifelines.getOrDefault("audiencePoll", false) ? "disabled" : "" %>'>Poll</a>
                <a href='<%= lifelines.getOrDefault("expertAdvice", false) ? "kbc?action=lifeline&type=expertAdvice" : "#" %>' 
                   class='lifeline-btn <%= !lifelines.getOrDefault("expertAdvice", false) ? "disabled" : "" %>'>Expert</a>
                <a href='<%= lifelines.getOrDefault("flipQuestion", false) ? "kbc?action=lifeline&type=flipQuestion" : "#" %>' 
                   class='lifeline-btn <%= !lifelines.getOrDefault("flipQuestion", false) ? "disabled" : "" %>'>Flip</a>
            </div>
            <a href="kbc?action=quit" class="quit-btn">Quit Game</a>
        </div>

        <% 
            Map<String, Integer> pollResults = (Map<String, Integer>) request.getAttribute("pollResults");
            String expertAdvice = (String) request.getAttribute("expertAdvice");
        %>
        <% if (pollResults != null) { %>
            <div class="lifeline-result-box">
                <h4>Audience Poll Results:</h4>
                <% for (Map.Entry<String, Integer> entry : pollResults.entrySet()) { %>
                    <div class="poll-bar-container">
                        <span class="poll-bar-label"><%= entry.getKey() %>:</span>
                        <div class="poll-bar" style="width: <%= entry.getValue() %>%;"><%= entry.getValue() > 5 ? entry.getValue() + "%" : "" %></div>
                    </div>
                <% } %>
            </div>
        <% } %>
        <% if (expertAdvice != null) { %>
            <div class="lifeline-result-box">
                <h4>Expert's Advice:</h4>
                <p>"<%= expertAdvice %>"</p>
            </div>
        <% } %>

        <div class="timer-box"><span id="timer">--</span></div>
        <div class="question-box">Q <%= session.getAttribute("questionIndex") %>: <%= q.getQuestion() %></div>

        <form id="kbcForm" action="kbc" method="post">
            <input type="hidden" id="timeout" name="timeout" value="false">
            <div class="options-grid">
                <% if (q.getOptionA() != null) { %><div class="option"><label><input type="radio" name="option" value="<%= q.getOptionA() %>" required> A: <%= q.getOptionA() %></label></div><% } %>
                <% if (q.getOptionB() != null) { %><div class="option"><label><input type="radio" name="option" value="<%= q.getOptionB() %>"> B: <%= q.getOptionB() %></label></div><% } %>
                <% if (q.getOptionC() != null) { %><div class="option"><label><input type="radio" name="option" value="<%= q.getOptionC() %>"> C: <%= q.getOptionC() %></label></div><% } %>
                <% if (q.getOptionD() != null) { %><div class="option"><label><input type="radio" name="option" value="<%= q.getOptionD() %>"> D: <%= q.getOptionD() %></label></div><% } %>
            </div>
            <button type="submit" class="submit-btn">Lock Answer</button>
        </form>
    </div>
    <% } else { %>
        <div class="game-container"><h1>Error</h1><p>Could not load the question.</p></div>
    <% } %>

    <script>
        const timeLimit = <%= request.getAttribute("timeLimit") %>;
        const options = document.querySelectorAll('.option');
        options.forEach(option => {
            option.addEventListener('click', function() {
                options.forEach(opt => opt.classList.remove('selected'));
                this.classList.add('selected');
                this.querySelector('input[type="radio"]').checked = true;
            });
        });
        const timerElement = document.getElementById('timer');
        const kbcForm = document.getElementById('kbcForm');
        const timeoutInput = document.getElementById('timeout');
        if (timeLimit > 0) {
            let timeLeft = timeLimit;
            timerElement.textContent = timeLeft;
            const timerInterval = setInterval(() => {
                timeLeft--;
                timerElement.textContent = timeLeft;
                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    timeoutInput.value = 'true';
                    kbcForm.submit();
                }
            }, 1000);
        } else {
            timerElement.innerHTML = "&infin;";
            timerElement.style.color = "#4dff4d";
            timerElement.style.borderColor = "#4dff4d";
        }
    </script>
</body>
</html>
