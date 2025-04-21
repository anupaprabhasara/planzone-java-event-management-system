package com.planzone.servlet;

import com.planzone.model.User;
import com.planzone.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check if session already exists
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // Authenticate user
        User user = authenticateUser(email, password);

        if (user != null) {
            // Check if user is Admin or Organizer
            String role = user.getRole();
            if ("Admin".equals(role) || "Organizer".equals(role)) {
                // Create new session
                session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUser_id());
                session.setAttribute("name", user.getFull_name());
                session.setAttribute("role", user.getRole());
                session.setMaxInactiveInterval(30 * 60); // 30 min

                // Redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                // Role is 'User', not allowed to log in
                request.setAttribute("error", "Access denied. Only Admin or Organizer can log in.");
                request.getRequestDispatcher("/adminside/login.jsp").forward(request, response);
            }
        } else {
            // Invalid credentials
            request.setAttribute("error", "Incorrect email or password!");
            request.getRequestDispatcher("/adminside/login.jsp").forward(request, response);
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
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            request.getRequestDispatcher("/adminside/login.jsp").forward(request, response);
        }
    }
}