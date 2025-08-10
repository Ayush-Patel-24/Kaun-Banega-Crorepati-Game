<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>KBC Game</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(#1e3c72, #2a5298);
            color: white;
            text-align: center;
            padding-top: 100px;
        }
        h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }
        p {
            font-size: 20px;
            margin-bottom: 40px;
        }
        .start-btn {
            background-color: gold;
            color: black;
            padding: 15px 30px;
            font-size: 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
        }
        .start-btn:hover {
            background-color: orange;
        }
    </style>
</head>
<body>
    <h1>Welcome to Kaun Banega Crorepati</h1>
    <p>Test your knowledge and win virtual crores!</p>
    <form action="kbc" method="get">
        <button type="submit" class="start-btn">Start Game</button>
    </form>
</body>
</html>
