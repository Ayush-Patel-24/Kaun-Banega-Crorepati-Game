KBC (Kaun Banega Crorepati) - Web Game
Note: You can replace the above image link with a screenshot of your actual game.

Project Overview
This project is a fully functional, interactive web-based quiz game that simulates the popular TV show "Kaun Banega Crorepati". Developed using core Java web technologies, this application provides an engaging, single-player experience where users can test their general knowledge against a series of questions with increasing difficulty, lifelines, and a ticking clock.

The application is built on the Model-View-Controller (MVC) architectural pattern, ensuring a clean separation of concerns between the database logic (Model), the dynamic web pages (View), and the core game logic (Controller).

Features
This KBC game comes packed with a rich set of features to create an authentic and exciting experience:

User Authentication: Secure user registration and login system. The game is protected by an authentication filter, ensuring only logged-in users can play.

Dynamic Question System: Questions are fetched dynamically from a MySQL database, allowing for an easily expandable question bank.

Progressive Difficulty & Prize Money: A 15-question ladder with a prize money tree, where the winnings increase with each correct answer.

Checkpoint System: Implements the classic KBC "safe havens" at questions 5 and 10. If a player answers incorrectly, their winnings drop to the last crossed checkpoint.

Time Limits: To add a layer of challenge, questions have time boundaries:

Questions 1-5: 30 seconds

Questions 6-10: 45 seconds

Questions 11-15: No time limit

Four Functional Lifelines:

50:50: Removes two incorrect options.

Audience Poll: Simulates a poll to show the audience's choice.

Expert's Advice: Provides a hint from a virtual expert.

Flip the Question: Replaces the current question with an alternate one of the same difficulty.

Interactive Gameplay:

Quit Option: Players can choose to quit the game at any point and take home the prize money from the last question they answered correctly.

Explanation Page: After each correct answer, a detailed explanation is shown, making the game a learning experience.

User Profiles & Statistics:

Players can view their profile, which displays their full name, email, and username.

The application tracks and displays the total number of games played and the cumulative prize money won over time.

Session Management: Robust HttpSession management to track game state, lifelines used, and user login status across multiple requests.

Technology Stack
Backend: Java, Servlets, JDBC

Frontend: JSP (JavaServer Pages), HTML, CSS, JavaScript

Database: MySQL

Server: Apache Tomcat (v10.1 or higher recommended)

Build Tool: Apache Maven (or managed via IDE)

IDE: Eclipse / IntelliJ IDEA

Database Schema
The application uses two main tables in the database:

1. Users Table

CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullName VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    games_played INT NOT NULL DEFAULT 0,
    total_winnings BIGINT NOT NULL DEFAULT 0
);

2. Questions Table

CREATE TABLE Questions (
    QuestionID INT PRIMARY KEY AUTO_INCREMENT,
    Question VARCHAR(500),
    OptionA VARCHAR(100),
    OptionB VARCHAR(100),
    OptionC VARCHAR(100),
    OptionD VARCHAR(100),
    CorrectAns VARCHAR(100),
    Explanation VARCHAR(1000)
);

Setup and Installation
To run this project locally, follow these steps:

Database Setup:

Make sure you have a MySQL server running.

Create a new database (e.g., kbc_game).

Run the SQL scripts for the Users and Questions tables provided above.

Populate the Questions table with at least 30 questions (15 main, 15 for the "Flip" lifeline).

Update the database credentials (URL, username, password) in the DBConnection.java file.

Project Setup (Eclipse/IntelliJ):

Clone or download the project.

Import it into your IDE as a "Dynamic Web Project" or "Maven Project".

Crucially, ensure your project's build path includes the Apache Tomcat server runtime library.

In Eclipse: Properties > Java Build Path > Libraries > Add Library... > Server Runtime.

Ensure the Tomcat server runtime is also added to the Deployment Assembly.

In Eclipse: Properties > Deployment Assembly > Add... > Java Build Path Entries.

Add the MySQL Connector/J JAR file to your project's WEB-INF/lib folder.

Run the Application:

Deploy the project to your configured Apache Tomcat server.

Open your web browser and navigate to the application's root URL (e.g., http://localhost:8080/KBCGame/).

You will be directed to the sign-up or login page. Create an account and start playing!

How to Play
Sign Up / Login: Create a new account or log in with existing credentials.

Start Game: From the main landing page, click the "Let's Play!" button to begin.

Answer Questions: For each question, select an option and click "Lock Answer". Be mindful of the timer!

Use Lifelines: If you're stuck, use one of the four lifelines. Each can only be used once per game.

Win or Lose: Continue answering correctly to climb the prize money ladder. If you answer incorrectly or run out of time, the game ends, and your winnings are calculated based on the last checkpoint you passed.

Quit: You can quit at any time to safely walk away with the prize money from your last correctly answered question.

Enjoy the game!
