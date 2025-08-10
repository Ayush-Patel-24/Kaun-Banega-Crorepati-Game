<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Game Over</title>
<style>
    body { font-family: Arial, sans-serif; background-color: #2c0c0c; color: white; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; text-align: center; }
    .container { background-color: #4a1a1a; padding: 50px; border-radius: 15px; box-shadow: 0 0 20px rgba(255, 100, 100, 0.5); }
    h1 { font-size: 3em; color: #ff4d4d; }
    p { font-size: 1.2em; }
    .correct-answer { font-size: 1.5em; color: #aaffaa; font-weight: bold; margin-top: 15px; }
    .play-again-button { display: inline-block; margin-top: 20px; padding: 15px 30px; font-size: 1.2em; font-weight: bold; color: #2c0c0c; background-color: #ff8c8c; border: none; border-radius: 10px; text-decoration: none; transition: background-color 0.3s; }
    .play-again-button:hover { background-color: #ffabab; }
</style>
</head>
<body>
    <div class="container">
        <h1>Game Over</h1>
        <p>Sorry, that was the wrong answer.</p>
        <p class="correct-answer">The correct answer was: <%= request.getAttribute("correctAnswer") %></p>
        <a href="index.jsp" class="play-again-button">Play Again</a>
    </div>
</body>
</html>
