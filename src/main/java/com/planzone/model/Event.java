package com.planzone.model;

public class Event {
    // Fields from events table
    private int eventId;
    private String title;
    private String description;
    private String startTime;
    private String endTime;
    private int venueId;
    private int categoryId;
    private int organizerId;
    private String createdAt;

    // Extra fields from events_view
    private String venueName;
    private String venueAddress;
    private String categoryName;
    private String organizerName;
    
	public int getEventId() {
		return eventId;
	}
	public String getTitle() {
		return title;
	}
	public String getDescription() {
		return description;
	}
	public String getStartTime() {
		return startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public int getVenueId() {
		return venueId;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public int getOrganizerId() {
		return organizerId;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public String getVenueName() {
		return venueName;
	}
	public String getVenueAddress() {
		return venueAddress;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public String getOrganizerName() {
		return organizerName;
	}
	public void setEventId(int eventId) {
		this.eventId = eventId;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public void setVenueId(int venueId) {
		this.venueId = venueId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public void setOrganizerId(int organizerId) {
		this.organizerId = organizerId;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public void setVenueName(String venueName) {
		this.venueName = venueName;
	}
	public void setVenueAddress(String venueAddress) {
		this.venueAddress = venueAddress;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public void setOrganizerName(String organizerName) {
		this.organizerName = organizerName;
	}
}