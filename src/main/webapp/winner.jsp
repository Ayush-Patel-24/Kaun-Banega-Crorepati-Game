<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Congratulations!</title>
<style>
    body { font-family: Arial, sans-serif; background-color: #0c0c2c; color: white; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; text-align: center; }
    .container { background-color: #1a1a4a; padding: 50px; border-radius: 15px; box-shadow: 0 0 30px #ffcc00; }
    h1 { font-size: 3em; color: #ffcc00; }
    p { font-size: 1.5em; }
    .play-again-button { display: inline-block; margin-top: 20px; padding: 15px 30px; font-size: 1.2em; font-weight: bold; color: #0c0c2c; background-color: #ffcc00; border: none; border-radius: 10px; text-decoration: none; transition: background-color 0.3s; }
    .play-again-button:hover { background-color: #ffd633; }
</style>
</head>
<body>
    <div class="container">
        <h1>Congratulations!</h1>
        <p>You have answered all 15 questions correctly. You are a KBC Winner!</p>
        <a href="index.jsp" class="play-again-button">Play Again</a>
    </div>
</body>
</html>