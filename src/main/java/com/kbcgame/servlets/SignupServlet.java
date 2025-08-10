package com.kbcgame.servlets;

import com.kbcgame.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // plain text for now

        String message;
        String messageColor;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO Users (fullName, username, email, password_hash) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, username);
            stmt.setString(3, email);
            stmt.setString(4, password);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                message = "✅ Signup Successful! You can now login.";
                messageColor = "green";
            } else {
                message = "❌ Signup failed. Try again.";
                messageColor = "red";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "❌ Error: " + e.getMessage();
            messageColor = "red";
        }

        // Set message as request attribute
        request.setAttribute("message", message);
        request.setAttribute("messageColor", messageColor);

        // Forward back to signup.jsp
        request.getRequestDispatcher("/signUp.jsp").forward(request, response);
    }
}
