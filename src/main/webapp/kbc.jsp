<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kbcgame.model.Question" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KBC - Question Time</title>
<style>
    body { font-family: Arial, sans-serif; background-color: #0c0c2c; color: white; display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; box-sizing: border-box; margin: 0; }
    .game-container { background-color: #1a1a4a; padding: 30px; border-radius: 15px; width: 100%; max-width: 800px; box-shadow: 0 0 20px rgba(255, 255, 255, 0.2); }
    .welcome-header { text-align: center; font-size: 1.2em; color: #ffcc00; margin-bottom: 20px; }
    .question-box { background-color: #0c0c2c; border: 2px solid #ffcc00; border-radius: 10px; padding: 20px; margin-bottom: 20px; font-size: 1.5em; text-align: center; }
    .options-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
    .option { background-color: #333366; border: 2px solid #666699; border-radius: 10px; padding: 15px; cursor: pointer; transition: background-color 0.3s, border-color 0.3s; font-size: 1.2em; }
    .option:hover { background-color: #4d4d8f; border-color: #ffcc00; }
    .option input[type="radio"] { display: none; }
    .option label { display: block; width: 100%; cursor: pointer; }
    .submit-btn { display: block; width: 100%; padding: 15px; margin-top: 20px; font-size: 1.5em; font-weight: bold; color: #0c0c2c; background-color: #ffcc00; border: none; border-radius: 10px; cursor: pointer; transition: background-color 0.3s; }
    .submit-btn:hover { background-color: #ffd633; }

    /* ✨ NEW: Style for the selected option ✨ */
    .option.selected {
        background-color: #ffcc00;
        border-color: #ffffff;
        color: #0c0c2c;
        font-weight: bold;
    }
</style>
</head>
<body>
    <% Question q = (Question) request.getAttribute("currentQuestion"); %>
    
    <% if (q != null) { %>
    <div class="game-container">
        
        <div class="welcome-header">
            All the best, ${sessionScope.userName}!
        </div>

        <div class="question-box">
            Q <%= q.getQuestionId() %>: <%= q.getQuestion() %>
        </div>

        <form action="kbc" method="post">
            <div class="options-grid">
                <div class="option">
                    <label><input type="radio" name="option" value="<%= q.getOptionA() %>" required> A: <%= q.getOptionA() %></label>
                </div>
                <div class="option">
                    <label><input type="radio" name="option" value="<%= q.getOptionB() %>"> B: <%= q.getOptionB() %></label>
                </div>
                <div class="option">
                    <label><input type="radio" name="option" value="<%= q.getOptionC() %>"> C: <%= q.getOptionC() %></label>
                </div>
                <div class="option">
                    <label><input type="radio" name="option" value="<%= q.getOptionD() %>"> D: <%= q.getOptionD() %></label>
                </div>
            </div>
            <button type="submit" class="submit-btn">Lock Answer</button>
        </form>
    </div>
    <% } else { %>
        <div class="game-container">
            <h1>Error</h1>
            <p>Could not load the question. The 'currentQuestion' object was not found in the request.</p>
        </div>
    <% } %>

    <!-- ✨ NEW: JavaScript to handle the selection logic ✨ -->
    <script>
        // Get all the elements with the class 'option'
        const options = document.querySelectorAll('.option');

        // Loop through each option element
        options.forEach(option => {
            // Add a click event listener to it
            option.addEventListener('click', function() {
                // First, remove the 'selected' class from all other options
                options.forEach(opt => opt.classList.remove('selected'));

                // Then, add the 'selected' class to the one that was just clicked
                this.classList.add('selected');

                // Finally, find the hidden radio button inside the clicked div and check it
                this.querySelector('input[type="radio"]').checked = true;
            });
        });
    </script>
</body>
</html>
