package com.planzone.model;

public class Registration {
    private int registrationId;
    private int userId;
    private int eventId;
    private String registeredAt;

    // These fields are available in the registrations_view only
    private String userName;
    private String eventTitle;
    
	public int getRegistrationId() {
		return registrationId;
	}
	public int getUserId() {
		return userId;
	}
	public int getEventId() {
		return eventId;
	}
	public String getRegisteredAt() {
		return registeredAt;
	}
	public String getUserName() {
		return userName;
	}
	public String getEventTitle() {
		return eventTitle;
	}
	public void setRegistrationId(int registrationId) {
		this.registrationId = registrationId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public void setEventId(int eventId) {
		this.eventId = eventId;
	}
	public void setRegisteredAt(String registeredAt) {
		this.registeredAt = registeredAt;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}
}