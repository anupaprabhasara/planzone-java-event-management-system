package com.planzone.servlet;

import com.planzone.model.Event;
import com.planzone.model.Notification;
import com.planzone.service.EventService;
import com.planzone.service.NotificationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/events")
public class EventPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NotificationService notificationService;
    private EventService eventService;

    @Override
    public void init() throws ServletException {
        notificationService = new NotificationService();
        eventService = new EventService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Load all notifications
        List<Notification> notifications = notificationService.getAllNotifications();
        request.setAttribute("notifications", notifications);

        // 2. Load featured events
        List<Event> events = eventService.getAllEvents();
        request.setAttribute("events", events);

        // 3. Check login status
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        request.setAttribute("isLoggedIn", isLoggedIn);

        // 4. Check if there's a registration message (from registration servlet)
        if (session != null) {
            String message = (String) session.getAttribute("registrationMessage");
            if (message != null) {
                request.setAttribute("registrationMessage", message);
                session.removeAttribute("registrationMessage");
            }
        }

        // 5. Forward to home.jsp
        request.getRequestDispatcher("/clientside/event.jsp").forward(request, response);
    }
}