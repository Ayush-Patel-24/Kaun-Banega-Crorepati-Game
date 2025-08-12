<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up - KBC Game</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #0c0c2c;
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .signup-container {
            background-color: #1a1a4a;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            color: #ffcc00;
            font-size: 2.5em;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .message-success {
            color: #4dff4d;
            background-color: rgba(77, 255, 77, 0.1);
            border: 1px solid #4dff4d;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .message-error {
            color: #ff4d4d;
            background-color: rgba(255, 77, 77, 0.1);
            border: 1px solid #ff4d4d;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #cccccc;
            font-weight: 600;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #333366;
            background-color: #0c0c2c;
            border-radius: 8px;
            color: #ffffff;
            font-size: 1em;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #ffcc00;
        }

        button[type="submit"] {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 8px;
            background-color: #ffcc00;
            color: #0c0c2c;
            font-size: 1.2em;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background-color: #ffd633;
            transform: translateY(-2px);
        }

        .login-link {
            margin-top: 25px;
            color: #cccccc;
        }

        .login-link a {
            color: #ffcc00;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h2>Sign Up</h2>

        <% 
            String msg = (String) request.getAttribute("message");
            String color = (String) request.getAttribute("messageColor");
            if (msg != null) {
                // Use different CSS classes based on the message color for better styling
                String messageClass = "green".equalsIgnoreCase(color) ? "message-success" : "message-error";
        %>
            <p class="<%= messageClass %>"><%= msg %></p>
        <%
            }
        %>

        <form action="signup" method="post">
            <div class="input-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>

            <div class="input-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="input-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="input-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit">Create Account</button>
        </form>

        <p class="login-link">Already have an account? <a href="login.jsp">Login</a></p>
    </div>
</body>
</html>
