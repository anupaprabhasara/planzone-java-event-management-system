package com.planzone.servlet;

import com.planzone.model.User;
import com.planzone.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check if session already exists
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        // Authenticate user
        User user = authenticateUser(email, password);

        if (user != null) {
            // Only allow login if role is "User"
            String role = user.getRole();
            if ("User".equals(role)) {
                // Create new session
                session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUser_id());
                session.setAttribute("name", user.getFull_name());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("role", user.getRole());
                session.setMaxInactiveInterval(30 * 60); // 30 min

                // Redirect to user dashboard
                response.sendRedirect(request.getContextPath() + "/");
            } else {
                // Other roles not allowed
                request.setAttribute("error", "Access denied. Only Users can log in here.");
                request.getRequestDispatcher("/clientside/login.jsp").forward(request, response);
            }
        } else {
            // Invalid credentials
            request.setAttribute("error", "Incorrect email or password!");
            request.getRequestDispatcher("/clientside/login.jsp").forward(request, response);
        }
    }

    private User authenticateUser(String email, String password) {
        for (User user : userService.getAllUsers()) {
            if (user.getEmail().equalsIgnoreCase(email) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if session exists
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            request.getRequestDispatcher("/clientside/login.jsp").forward(request, response);
        }
    }
}