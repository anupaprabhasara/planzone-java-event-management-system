package com.planzone.servlet;

import com.planzone.model.Notification;
import com.planzone.service.NotificationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/about")
public class AboutPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NotificationService notificationService;

    @Override
    public void init() throws ServletException {
        notificationService = new NotificationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Load all notifications
        List<Notification> notifications = notificationService.getAllNotifications();
        request.setAttribute("notifications", notifications);

        // 3. Check login status
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        request.setAttribute("isLoggedIn", isLoggedIn);

        // 5. Forward to home.jsp
        request.getRequestDispatcher("/clientside/about.jsp").forward(request, response);
    }
}