<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>You Quit the Game</title>
<style>
    body { font-family: Arial, sans-serif; background-color: #0c0c2c; color: white; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; text-align: center; }
    .container { background-color: #1a1a4a; padding: 50px; border-radius: 15px; box-shadow: 0 0 20px rgba(255, 255, 255, 0.2); }
    h1 { font-size: 3em; color: #ffcc00; }
    p { font-size: 1.2em; }
    .prize-money { font-size: 2em; color: #4dff4d; font-weight: bold; margin: 20px 0; }
    .back-to-home-button { display: inline-block; margin-top: 20px; padding: 15px 30px; font-size: 1.2em; font-weight: bold; color: #0c0c2c; background-color: #ffcc00; border: none; border-radius: 10px; text-decoration: none; transition: background-color 0.3s; }
    .back-to-home-button:hover { background-color: #ffd633; }
</style>
</head>
<body>
    <div class="container">
        <h1>You Have Quit the Game</h1>
        <p>You are walking away with:</p>
        <p class="prize-money"><%= request.getAttribute("prizeMoney") %></p>
        <a href="index.jsp" class="back-to-home-button">Back to Home</a>
    </div>
</body>
</html>
