package com.planzone.service;

import com.planzone.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardService {

    public int getTotalEvents() {
        return getCount("events");
    }

    public int getTotalRegistrations() {
        return getCount("registrations");
    }

    public int getTotalVenues() {
        return getCount("venues");
    }

    public int getTotalUsers() {
        return getCount("users");
    }

    private int getCount(String tableName) {
        String query = "SELECT COUNT(*) FROM " + tableName;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // For development; consider logging for production
        }
        return 0;
    }
}