<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Game Over</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Poppins', sans-serif; background-color: #2c0c0c; color: white; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; text-align: center; padding: 20px; box-sizing: border-box;}
    .container { background-color: #4a1a1a; padding: 40px; border-radius: 15px; box-shadow: 0 0 20px rgba(255, 100, 100, 0.5); width: 100%; max-width: 600px; }
    h1 { font-size: 3em; color: #ff4d4d; margin-top: 0; }
    p { font-size: 1.2em; }
    .info-box {
        background-color: rgba(0, 0, 0, 0.2);
        border-radius: 10px;
        padding: 20px;
        margin-top: 20px;
    }
    .correct-answer-label { font-size: 1em; color: #cccccc; }
    .correct-answer { font-size: 1.5em; color: #aaffaa; font-weight: bold; }
    .prize-money-label { font-size: 1em; color: #cccccc; margin-top: 20px; }
    .prize-money { font-size: 2em; color: #4dff4d; font-weight: bold; }
    
    /* ✨ Styles for the explanation box ✨ */
    .explanation-box {
        border-top: 1px solid rgba(255, 255, 255, 0.2);
        margin-top: 20px;
        padding-top: 20px;
        text-align: left;
        font-size: 1em;
        color: #dddddd;
    }
    .explanation-box strong {
        color: #ffcc00;
    }

    .play-again-button { display: inline-block; margin-top: 30px; padding: 15px 30px; font-size: 1.2em; font-weight: bold; color: #2c0c0c; background-color: #ff8c8c; border: none; border-radius: 10px; text-decoration: none; transition: background-color 0.3s; }
    .play-again-button:hover { background-color: #ffabab; }
</style>
</head>
<body>
    <div class="container">
        <h1>Game Over</h1>
        
        <% 
            String timeoutMessage = (String) request.getAttribute("timeoutMessage");
            if (timeoutMessage != null) {
        %>
            <p><%= timeoutMessage %></p>
        <% 
            } else {
        %>
            <p>Sorry, that was the wrong answer.</p>
        <%
            }
        %>

        <div class="info-box">
            <div>
                <p class="correct-answer-label">The correct answer was:</p>
                <p class="correct-answer"><%= request.getAttribute("correctAnswer") %></p>
            </div>
            
            <!-- ✨ Explanation is displayed here ✨ -->
            <% String explanation = (String) request.getAttribute("explanation"); %>
            <% if (explanation != null && !explanation.isEmpty()) { %>
                <div class="explanation-box">
                    <strong>Explanation:</strong> <%= explanation %>
                </div>
            <% } %>
        </div>

        <div class="info-box">
            <p class="prize-money-label">You are taking home:</p>
            <p class="prize-money"><%= request.getAttribute("prizeMoney") %></p>
        </div>

        <a href="index.jsp" class="play-again-button">Play Again</a>
    </div>
</body>
</html>
