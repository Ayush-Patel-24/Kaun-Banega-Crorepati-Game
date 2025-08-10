package com.kbcgame.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter init if needed
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        String loginURI = req.getContextPath() + "/login.jsp";
        String signUpURI = req.getContextPath() + "/signUp.jsp";
        String loginServletURI = req.getContextPath() + "/login"; 
        String signUpServletURI = req.getContextPath() + "/signup"; 

        boolean loggedIn = (session != null && session.getAttribute("userName") != null);
        boolean loginRequest = req.getRequestURI().equals(loginURI);
        boolean signUpRequest = req.getRequestURI().equals(signUpURI);
        boolean loginServletRequest = req.getRequestURI().equals(loginServletURI);
        boolean signUpServletRequest = req.getRequestURI().equals(signUpServletURI);

        if (loggedIn || loginRequest || signUpRequest || loginServletRequest || signUpServletRequest) {

            chain.doFilter(request, response); // continue request
        } else {
            // Not logged in, redirect to login page
            res.sendRedirect(loginURI);
        }
    }

    public void destroy() {
        // Cleanup code if needed
    }
}
