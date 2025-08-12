<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kbcgame.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your KBC Profile</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #0c0c2c; color: white; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .profile-container { background-color: #1a1a4a; padding: 40px; border-radius: 20px; box-shadow: 0 0 30px rgba(255, 204, 0, 0.3); width: 100%; max-width: 600px; text-align: center; }
        h1 { font-size: 2.5em; color: #ffcc00; margin-top: 0; margin-bottom: 30px; }
        .profile-details { list-style: none; padding: 0; margin: 0; text-align: left; }
        .profile-details li { display: flex; justify-content: space-between; padding: 15px 0; border-bottom: 1px solid rgba(255, 255, 255, 0.1); font-size: 1.2em; }
        .profile-details li:last-child { border-bottom: none; }
        .profile-details .label { font-weight: 600; color: #cccccc; }
        .profile-details .value { font-weight: 400; color: #ffffff; }
        .back-btn { display: inline-block; background: #333366; color: white; padding: 12px 30px; font-size: 1.1em; border-radius: 50px; text-decoration: none; font-weight: 600; border: 2px solid #666699; transition: background-color 0.3s; margin-top: 40px; }
        .back-btn:hover { background-color: #4d4d8f; }
    </style>
</head>
<body>
    <% User user = (User) request.getAttribute("userProfile"); %>
    <% if (user != null) { %>
    <div class="profile-container">
        <h1>Player Profile</h1>
        <ul class="profile-details">
            <li><span class="label">Full Name:</span> <span class="value"><%= user.getFullName() %></span></li>
            <li><span class="label">Username:</span> <span class="value"><%= user.getUsername() %></span></li>
            <li><span class="label">Email:</span> <span class="value"><%= user.getEmail() %></span></li>
            <li><span class="label">Games Played:</span> <span class="value"><%= user.getGamesPlayed() %></span></li>
            <li><span class="label">Total Winnings:</span> <span class="value"><%= user.getFormattedWinnings() %></span></li>
        </ul>
        <a href="index.jsp" class="back-btn">Back to Home</a>
    </div>
    <% } else { %>
        <p>Could not load user profile.</p>
    <% } %>
</body>
</html>
