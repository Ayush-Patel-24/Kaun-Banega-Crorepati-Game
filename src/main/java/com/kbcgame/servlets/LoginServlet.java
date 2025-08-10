//package com.kbcgame.servlets;
//
//import com.kbcgame.util.DBConnection;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/login")
//public class LoginServlet extends HttpServlet {
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        try (Connection conn = DBConnection.getConnection()) {
//            String sql = "SELECT * FROM Users WHERE username = ? AND password_hash = ?";
//            PreparedStatement stmt = conn.prepareStatement(sql);
//            stmt.setString(1, username);
//            stmt.setString(2, password);
//
//            ResultSet rs = stmt.executeQuery();
//
//            if (rs.next()) {
//                // Login successful → Redirect to welcome page
//            	HttpSession session = request.getSession();
//            	session.setAttribute("username", username);
//                response.sendRedirect("index.jsp");
//            } else {
//                // Login failed → show error on login page
//                request.setAttribute("errorMessage", "Invalid username or password.");
//                request.getRequestDispatcher("/login.jsp").forward(request, response);
//            }
//        } catch (Exception e) {
//            throw new ServletException(e);
//        }
//    }
//}


package com.kbcgame.servlets;

import com.kbcgame.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // The driver is now loaded by the listener, so we don't need Class.forName() here.
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                request.setAttribute("errorMessage", "Database connection failed. Please contact an administrator.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            String sql = "SELECT * FROM Users WHERE username = ? AND password_hash = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Login successful
                HttpSession session = request.getSession();
                session.setAttribute("userName", username);
                response.sendRedirect("index.jsp");
            } else {
                // Login failed
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
