package com.planzone.servlet;

import com.planzone.model.User;
import com.planzone.model.Notification;
import com.planzone.service.UserService;
import com.planzone.service.NotificationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/profile")
public class UserProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;
    private NotificationService notificationService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
        notificationService = new NotificationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get user ID safely
        Object userIdObj = session.getAttribute("userId");
        int userId = (int) userIdObj;

        // Fetch updated user details
        User user = userService.getUser(userId);
        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found.");
            return;
        }

        // Fetch notifications
        List<Notification> notifications = notificationService.getAllNotifications();
        request.setAttribute("notifications", notifications);

        // Set request attributes
        request.setAttribute("user", user);
        request.setAttribute("isLoggedIn", true);

        // Forward to JSP
        request.getRequestDispatcher("/clientside/profile.jsp").forward(request, response);
    }
}