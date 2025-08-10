<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Sign Up - KBC Game</title>
</head>
<body>
<h2>Create an Account</h2>

<!-- Show message if present -->
<% 
    String msg = (String) request.getAttribute("message");
    String color = (String) request.getAttribute("messageColor");
    if (msg != null) {
%>
    <p style="color:<%= color %>;"><%= msg %></p>
<%
    }
%>

<form action="signup" method="post">
    <label>Full Name:</label>
    <input type="text" name="fullName" required><br><br>

    <label>Username:</label>
    <input type="text" name="username" required><br><br>

    <label>Email:</label>
    <input type="email" name="email" required><br><br>

    <label>Password:</label>
    <input type="password" name="password" required><br><br>

    <input type="submit" value="Sign Up">
</form>

<br>
<p>If you already have an account, <a href="login.jsp">login</a>.</p>
</body>
</html>
