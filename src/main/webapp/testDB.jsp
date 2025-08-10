<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.kbcgame.util.DBConnection" %>

<html>
<head>
    <title>Database Connection Test</title>
</head>
<body>
<h2>Testing Database Connection...</h2>
<%
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
        if (conn != null) {
            out.println("<p style='color:green;'>✅ Connection Successful!</p>");
        } else {
            out.println("<p style='color:red;'>❌ Connection Failed!</p>");
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>❌ Error: " + e.getMessage() + "</p>");
    } finally {
        if (conn != null) conn.close();
    }
%>
</body>
</html>
