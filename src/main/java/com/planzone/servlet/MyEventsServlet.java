package com.planzone.servlet;

import com.planzone.model.Registration;
import com.planzone.model.Notification;
import com.planzone.service.RegistrationService;
import com.planzone.service.NotificationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/myevents")
public class MyEventsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RegistrationService registrationService;
    private NotificationService notificationService;

    @Override
    public void init() throws ServletException {
        registrationService = new RegistrationService();
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

        List<Registration> registrations = registrationService.getRegistrationsByUserId(userId);
        List<Notification> notifications = notificationService.getAllNotifications();

        request.setAttribute("registrations", registrations);
        request.setAttribute("notifications", notifications);
        request.setAttribute("isLoggedIn", true);
        request.getRequestDispatcher("/clientside/myevents.jsp").forward(request, response);
    }

    // Handle Unenroll
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String regIdStr = request.getParameter("registrationId");
        if (regIdStr != null) {
            int regId = Integer.parseInt(regIdStr);
            registrationService.deleteRegistration(regId);
        }

        response.sendRedirect(request.getContextPath() + "/myevents");
    }
}