package com.kbcgame.servlets;

import com.kbcgame.model.User;
import com.kbcgame.util.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * This servlet fetches the logged-in user's profile data from the database.
 * It is mapped to the "/profile" URL pattern.
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("userName") : null;

        if (username == null) {
            // If user is not logged in, redirect to login page
            response.sendRedirect("login.jsp");
            return;
        }

        User userProfile = null;
        String sql = "SELECT id, fullName, username, email, games_played, total_winnings FROM Users WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    userProfile = new User();
                    userProfile.setId(rs.getInt("id"));
                    userProfile.setFullName(rs.getString("fullName"));
                    userProfile.setUsername(rs.getString("username"));
                    userProfile.setEmail(rs.getString("email"));
                    userProfile.setGamesPlayed(rs.getInt("games_played"));
                    userProfile.setTotalWinnings(rs.getLong("total_winnings"));
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database error while fetching user profile.", e);
        }

        if (userProfile != null) {
            request.setAttribute("userProfile", userProfile);
            RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
            dispatcher.forward(request, response);
        } else {
            // Handle case where user is in session but not in DB (should not happen)
            response.sendRedirect("index.jsp");
        }
    }
}
