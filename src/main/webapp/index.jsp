<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to KBC Game</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background-color: #0c0c2c;
            background-image: 
                radial-gradient(circle at top right, rgba(20, 50, 150, 0.4), transparent 50%),
                radial-gradient(circle at bottom left, rgba(20, 50, 150, 0.4), transparent 50%);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 40px 20px;
            box-sizing: border-box;
        }

        .main-container {
            position: relative; /* ✨ NEW: Needed for positioning the buttons inside */
            width: 100%;
            max-width: 1200px;
            background-color: rgba(26, 26, 74, 0.8);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 204, 0, 0.2);
            text-align: center;
        }

        /* ✨ UPDATED: Positioning is now relative to the main container ✨ */
        .top-right-controls {
            position: absolute;
            top: 40px;
            right: 40px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .welcome-user {
            font-size: 1.2em;
            color: #cccccc;
            margin-bottom: 20px;
        }
        .welcome-user strong {
            color: #ffcc00;
        }

        h1 {
            font-size: 3em;
            font-weight: 700;
            color: #ffcc00;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-top: 0;
            margin-bottom: 30px;
            text-shadow: 0 0 15px rgba(255, 204, 0, 0.5);
        }

        .content-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
            text-align: left;
            margin-bottom: 40px;
        }

        .rules-section, .prize-section {
            flex: 1;
            min-width: 300px;
        }

        h2 {
            font-size: 1.8em;
            color: #ffcc00;
            border-bottom: 2px solid #ffcc00;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .rules-section ul { list-style-type: none; padding-left: 0; }
        .rules-section li { margin-bottom: 15px; font-size: 1.1em; color: #cccccc; }
        .rules-section li strong { color: #ffffff; font-weight: 600; }
        .prize-table { width: 100%; border-collapse: collapse; }
        .prize-table td { padding: 12px 15px; font-size: 1.1em; border-bottom: 1px solid rgba(255, 255, 255, 0.1); }
        .prize-table .question-number { color: #cccccc; text-align: right; width: 30%; }
        .prize-table .prize-money { color: #ffcc00; font-weight: 700; text-align: left; }
        .prize-table .safe-level .prize-money { color: #ffffff; background-color: rgba(255, 204, 0, 0.2); border-radius: 5px; padding-left: 20px; }
        .action-buttons { display: flex; justify-content: center; align-items: center; gap: 20px; margin-top: 20px; }
        .start-btn { background: linear-gradient(45deg, #ffd700, #fcae1e); color: #1a1a4a; padding: 18px 40px; font-size: 1.5em; border: none; border-radius: 50px; cursor: pointer; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; transition: transform 0.3s ease, box-shadow 0.3s ease; box-shadow: 0 5px 15px rgba(255, 204, 0, 0.3); }
        .start-btn:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(255, 204, 0, 0.5); }
        
        .profile-btn {
            background: #333366;
            color: white;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            text-decoration: none;
            font-weight: 600;
            border: 2px solid #666699;
            transition: background-color 0.3s, transform 0.2s;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .profile-btn:hover {
            background-color: #4d4d8f;
            transform: translateY(-2px);
        }
        .logout-btn { background: #992d2d; color: white; padding: 12px 25px; font-size: 1em; border-radius: 50px; text-decoration: none; font-weight: 600; border: 2px solid #ff4d4d; transition: background-color 0.3s, transform 0.2s; }
        .logout-btn:hover { background-color: #b33e3e; transform: translateY(-2px); }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- ✨ UPDATED: Buttons moved inside the main container ✨ -->
        <div class="top-right-controls">
            <a href="${pageContext.request.contextPath}/profile" class="profile-btn" title="View Profile">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>

        <div class="welcome-user">
            Welcome, <strong>${sessionScope.userName}</strong>!
        </div>

        <h1>Kaun Banega Crorepati</h1>
        
        <div class="content-grid">
            <div class="rules-section">
                <h2>Game Rules & Lifelines</h2>
                <ul>
                    <li><strong>Objective:</strong> Answer 15 multiple-choice questions correctly to win the grand prize.</li>
                    <li><strong>Time Limits:</strong> You must answer within the specified time:
                        <ul>
                            <li><strong>Questions 1-5:</strong> 30 Seconds</li>
                            <li><strong>Questions 6-10:</strong> 45 Seconds</li>
                            <li><strong>Questions 11-15:</strong> No Time Limit</li>
                        </ul>
                    </li>
                    <li><strong>Game Over:</strong> An incorrect answer or running out of time will end the game.</li>
                    <li><strong>Lifelines:</strong> You have four powerful lifelines, but each can only be used once.
                        <ul>
                            <li><strong>50:50:</strong> Two random incorrect options are removed.</li>
                            <li><strong>Audience Poll:</strong> Shows a poll of what the virtual audience thinks is the correct answer.</li>
                            <li><strong>Expert's Advice:</strong> Provides a hint from a virtual expert.</li>
                            <li><strong>Flip the Question:</strong> The current question is replaced with a new one.</li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="prize-section">
                <h2>Prize Money</h2>
                <table class="prize-table">
                    <tbody>
                        <tr><td class="question-number">15</td><td class="prize-money">₹7 Crore</td></tr>
                        <tr><td class="question-number">14</td><td class="prize-money">₹5 Crore</td></tr>
                        <tr><td class="question-number">13</td><td class="prize-money">₹3 Crore</td></tr>
                        <tr><td class="question-number">12</td><td class="prize-money">₹1 Crore</td></tr>
                        <tr><td class="question-number">11</td><td class="prize-money">₹50,00,000</td></tr>
                        <tr class="safe-level"><td class="question-number">10</td><td class="prize-money">₹25,00,000</td></tr>
                        <tr><td class="question-number">9</td><td class="prize-money">₹12,50,000</td></tr>
                        <tr><td class="question-number">8</td><td class="prize-money">₹6,40,000</td></tr>
                        <tr><td class="question-number">7</td><td class="prize-money">₹3,20,000</td></tr>
                        <tr><td class="question-number">6</td><td class="prize-money">₹1,60,000</td></tr>
                        <tr class="safe-level"><td class="question-number">5</td><td class="prize-money">₹80,000</td></tr>
                        <tr><td class="question-number">4</td><td class="prize-money">₹40,000</td></tr>
                        <tr><td class="question-number">3</td><td class="prize-money">₹20,000</td></tr>
                        <tr><td class="question-number">2</td><td class="prize-money">₹10,000</td></tr>
                        <tr><td class="question-number">1</td><td class="prize-money">₹5,000</td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="action-buttons">
            <form action="kbc" method="get" style="margin: 0;">
                <button type="submit" class="start-btn">Let's Play!</button>
            </form>
        </div>

    </div>
</body>
</html>
