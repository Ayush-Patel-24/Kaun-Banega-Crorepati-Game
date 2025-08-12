<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Correct Answer!</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Poppins', sans-serif; background-color: #0c0c2c; color: white; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; text-align: center; }
    .container { background-color: #1a1a4a; padding: 50px; border-radius: 15px; box-shadow: 0 0 30px #4dff4d; width: 100%; max-width: 700px; }
    h1 { font-size: 3em; color: #4dff4d; margin-top: 0; }
    .prize-info {
        font-size: 1.2em;
        color: #cccccc;
    }
    .prize-money {
        font-size: 2.5em;
        color: #ffcc00;
        font-weight: bold;
        margin: 10px 0 30px 0;
    }
    .explanation-box {
        background-color: rgba(0, 0, 0, 0.2);
        border-left: 5px solid #ffcc00;
        padding: 20px;
        text-align: left;
        font-size: 1.1em;
        margin-bottom: 30px;
        border-radius: 0 10px 10px 0;
    }
    .continue-btn {
        background: linear-gradient(45deg, #ffd700, #fcae1e);
        color: #1a1a4a;
        padding: 15px 35px;
        font-size: 1.3em;
        border: none;
        border-radius: 50px;
        cursor: pointer;
        font-weight: 700;
        text-decoration: none;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .continue-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(255, 204, 0, 0.4);
    }
</style>
</head>
<body>
    <div class="container">
        <h1>Correct Answer!</h1>
        <p class="prize-info">You have won:</p>
        <p class="prize-money"><%= request.getAttribute("prizeMoney") %></p>
        
        <div class="explanation-box">
            <strong>Explanation:</strong> <%= request.getAttribute("explanation") %>
        </div>

        <a href="kbc?action=nextQuestion" class="continue-btn">Continue</a>
    </div>
</body>
</html>
