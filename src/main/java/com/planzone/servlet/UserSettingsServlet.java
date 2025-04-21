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

@WebServlet("/settings")
public class UserSettingsServlet extends HttpServlet {
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

        if (session == null || session.getAttribute("user") == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        User user = userService.getUser(userId);
        List<Notification> notifications = notificationService.getAllNotifications();

        request.setAttribute("user", user);
        request.setAttribute("notifications", notifications);
        request.setAttribute("isLoggedIn", true);
        request.getRequestDispatcher("/clientside/settings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        User user = userService.getUser(userId);

        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String newPassword = request.getParameter("new_password");
        String currentPassword = request.getParameter("current_password");

        List<Notification> notifications = notificationService.getAllNotifications();
        request.setAttribute("notifications", notifications);
        request.setAttribute("isLoggedIn", true);

        if (!user.getPassword().equals(currentPassword)) {
            request.setAttribute("user", user);
            request.setAttribute("error", "Incorrect current password.");
            request.getRequestDispatcher("/clientside/settings.jsp").forward(request, response);
            return;
        }

        user.setFull_name(fullName);
        user.setEmail(email);

        if (newPassword != null && !newPassword.trim().isEmpty()) {
            user.setPassword(newPassword);
        }

        boolean updated = userService.updateUser(user);
        if (updated) {
            session.setAttribute("name", user.getFull_name());
            request.setAttribute("user", user);
            request.setAttribute("success", "Profile updated successfully.");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }

        request.getRequestDispatcher("/clientside/settings.jsp").forward(request, response);
    }
}