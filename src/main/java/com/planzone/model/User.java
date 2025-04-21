package com.planzone.model;

public class User {
    private int user_id;
    private String full_name;
    private String email;
    private String password;
    private String role;
    private String created_at;
    
	public int getUser_id() {
		return user_id;
	}
	public String getFull_name() {
		return full_name;
	}
	public String getEmail() {
		return email;
	}
	public String getPassword() {
		return password;
	}
	public String getRole() {
		return role;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
}