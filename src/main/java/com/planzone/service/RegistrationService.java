package com.planzone.service;

import com.planzone.model.Registration;
import com.planzone.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RegistrationService {

    // Get All Registrations (uses registrations_view)
    public List<Registration> getAllRegistrations() {
        List<Registration> registrations = new ArrayList<>();
        String query = "SELECT * FROM registrations_view ORDER BY registered_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Registration reg = new Registration();
                reg.setRegistrationId(rs.getInt("registration_id"));
                reg.setUserName(rs.getString("user_name"));
                reg.setEventTitle(rs.getString("event_title"));
                reg.setRegisteredAt(rs.getString("registered_at"));
                registrations.add(reg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return registrations;
    }
    
    // Get Registrations by User ID
    public List<Registration> getRegistrationsByUserId(int userId) {
        List<Registration> registrations = new ArrayList<>();
        String query = "SELECT * FROM registrations_view WHERE user_id = ? ORDER BY registered_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Registration reg = new Registration();
                reg.setRegistrationId(rs.getInt("registration_id"));
                reg.setEventTitle(rs.getString("event_title"));
                reg.setUserName(rs.getString("user_name")); // optional
                reg.setRegisteredAt(rs.getString("registered_at"));
                registrations.add(reg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return registrations;
    }

    // Create Registration (uses registrations table)
    public boolean createRegistration(Registration registration) {
        String query = "INSERT INTO registrations (user_id, event_id, registered_at) VALUES (?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, registration.getUserId());
            stmt.setInt(2, registration.getEventId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Registration (uses registrations table)
    public boolean deleteRegistration(int id) {
        String query = "DELETE FROM registrations WHERE registration_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}