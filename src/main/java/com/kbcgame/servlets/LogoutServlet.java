package com.kbcgame.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * This servlet handles the user logout process.
 * It is mapped to the "/logout" URL pattern.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session, but don't create a new one if it doesn't exist.
        HttpSession session = request.getSession(false); 
        
        if (session != null) {
            // Invalidate the session. This removes all attributes (including userName)
            // and effectively logs the user out.
            session.invalidate();
        }
        
        // After logging out, redirect the user back to the login page.
        response.sendRedirect("login.jsp");
    }
}
