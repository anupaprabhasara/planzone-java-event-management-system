package com.planzone.service;

import com.planzone.model.Event;
import com.planzone.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventService {

    // Create Event (uses events table)
    public boolean createEvent(Event event) {
        String query = "INSERT INTO events (title, description, start_time, end_time, venue_id, category_id, organizer_id, created_at) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, event.getTitle());
            stmt.setString(2, event.getDescription());
            stmt.setString(3, event.getStartTime());
            stmt.setString(4, event.getEndTime());
            stmt.setInt(5, event.getVenueId());
            stmt.setInt(6, event.getCategoryId());
            stmt.setInt(7, event.getOrganizerId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Event by ID (uses events_view)
    public Event getEventById(int id) {
        String query = "SELECT * FROM events_view WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToEvent(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Events (uses events_view)
    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String query = "SELECT * FROM events_view ORDER BY start_time";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    
    // Get top 3 upcoming featured events
    public List<Event> getTopUpcomingFeaturedEvents() {
        List<Event> events = new ArrayList<>();
        String query = "SELECT * FROM events_view WHERE start_time >= NOW() ORDER BY start_time ASC LIMIT 3";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    // Update Event (uses events table)
    public boolean updateEvent(Event event) {
        String query = "UPDATE events SET title = ?, description = ?, start_time = ?, end_time = ?, " +
                       "venue_id = ?, category_id = ?, organizer_id = ? WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, event.getTitle());
            stmt.setString(2, event.getDescription());
            stmt.setString(3, event.getStartTime());
            stmt.setString(4, event.getEndTime());
            stmt.setInt(5, event.getVenueId());
            stmt.setInt(6, event.getCategoryId());
            stmt.setInt(7, event.getOrganizerId());
            stmt.setInt(8, event.getEventId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Event (uses events table)
    public boolean deleteEvent(int id) {
        String query = "DELETE FROM events WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper: Map ResultSet from events_view to Event model
    private Event mapResultSetToEvent(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setEventId(rs.getInt("event_id"));
        event.setTitle(rs.getString("title"));
        event.setDescription(rs.getString("description"));
        event.setStartTime(rs.getString("start_time"));
        event.setEndTime(rs.getString("end_time"));
        event.setCreatedAt(rs.getString("created_at"));
        event.setVenueName(rs.getString("venue_name"));
        event.setVenueAddress(rs.getString("venue_address"));
        event.setCategoryName(rs.getString("category_name"));
        event.setOrganizerName(rs.getString("organizer_name"));
        // Optional: you can also set venueId, categoryId, organizerId if you include them in the view
        return event;
    }
}