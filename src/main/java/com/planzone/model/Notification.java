package com.planzone.model;

public class Notification {
	private int notificationId;
    private String message;
    private String createdAt;
    
	public int getNotificationId() {
		return notificationId;
	}
	public String getMessage() {
		return message;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setNotificationId(int notificationId) {
		this.notificationId = notificationId;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
}