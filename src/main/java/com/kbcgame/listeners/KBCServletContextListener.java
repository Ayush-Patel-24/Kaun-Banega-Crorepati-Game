package com.kbcgame.listeners;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

@WebListener
public class KBCServletContextListener implements ServletContextListener {

    /**
     * This method is called by the server when the application starts up.
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("KBC Game application starting up...");
        try {
            // Load the MySQL JDBC driver
            // This ensures it's ready before any servlet needs it.
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("FATAL: MySQL JDBC Driver not found in WEB-INF/lib!");
            e.printStackTrace();
        }
    }

    /**
     * This method is called by the server when the application shuts down or reloads.
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("KBC Game application shutting down...");
        try {
            // This is the magic line that stops the memory leak.
            // It tells the MySQL cleanup thread to shut down properly.
            AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("MySQL AbandonedConnectionCleanupThread shut down successfully.");
        } catch (Exception e) {
            System.err.println("Error shutting down MySQL cleanup thread.");
            e.printStackTrace();
        }

        // This part is extra cleanup to de-register the driver.
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            if (driver.getClass().getClassLoader() == getClass().getClassLoader()) {
                try {
                    DriverManager.deregisterDriver(driver);
                    System.out.println("Deregistering JDBC driver: " + driver);
                } catch (SQLException ex) {
                    System.err.println("Error deregistering JDBC driver: " + driver);
                    ex.printStackTrace();
                }
            }
        }
    }
}
