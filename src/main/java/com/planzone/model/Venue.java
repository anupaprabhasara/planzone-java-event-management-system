package com.planzone.model;

public class Venue {
    private int venueId;
    private String name;
    private String address;
    private int capacity;
    
	public int getVenueId() {
		return venueId;
	}
	public String getName() {
		return name;
	}
	public String getAddress() {
		return address;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setVenueId(int venueId) {
		this.venueId = venueId;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
}