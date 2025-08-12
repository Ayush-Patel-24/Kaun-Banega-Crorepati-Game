<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>KBC Game - Login</title>
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

        .login-container {
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

        .error-message {
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
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #333366;
            background-color: #0c0c2c;
            border-radius: 8px;
            color: #ffffff;
            font-size: 1em;
            box-sizing: border-box; /* Important for padding and width */
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
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

        .signup-link {
            margin-top: 25px;
            color: #cccccc;
        }

        .signup-link a {
            color: #ffcc00;
            text-decoration: none;
            font-weight: 600;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>

        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p class="error-message"><%= errorMessage %></p>
        <% 
            } 
        %>

        <form action="login" method="post">
            <div class="input-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="input-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit">Login</button>
        </form>

        <p class="signup-link">Don't have an account? <a href="signUp.jsp">Sign Up</a></p>
    </div>
</body>
</html>
