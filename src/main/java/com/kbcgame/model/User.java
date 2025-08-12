package com.kbcgame.model;

import java.text.NumberFormat;
import java.util.Locale;

public class User {
    private int id;
    private String fullName;
    private String username;
    private String email;
    private int gamesPlayed;
    private long totalWinnings;

    // Getters and Setters for all fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getGamesPlayed() { return gamesPlayed; }
    public void setGamesPlayed(int gamesPlayed) { this.gamesPlayed = gamesPlayed; }

    public long getTotalWinnings() { return totalWinnings; }
    public void setTotalWinnings(long totalWinnings) { this.totalWinnings = totalWinnings; }

    // Helper method to format winnings with commas
    public String getFormattedWinnings() {
        NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
        formatter.setMaximumFractionDigits(0);
        return formatter.format(this.totalWinnings);
    }
}
