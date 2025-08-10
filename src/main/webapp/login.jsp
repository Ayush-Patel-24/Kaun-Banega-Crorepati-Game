<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>KBC Game - Login</title>
</head>
<body>
<h2>Login to KBC Game</h2>

<% 
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
%>
    <p style="color:red;"><%= errorMessage %></p>
<% 
    } 
%>

<form action="login" method="post">
    <label for="username">Username:</label>
    <input type="text" name="username" required><br><br>

    <label for="password">Password:</label>
    <input type="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<p>Don't have an account? <a href="signUp.jsp">Sign Up</a></p>
</body>
</html>
