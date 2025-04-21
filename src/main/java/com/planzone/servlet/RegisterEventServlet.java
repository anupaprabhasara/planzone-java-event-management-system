package com.planzone.servlet;

import com.planzone.model.Registration;
import com.planzone.model.User;
import com.planzone.service.RegistrationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private RegistrationService registrationService;

    @Override
    public void init() throws ServletException {
        registrationService = new RegistrationService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // No user logged in — redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String eventIdParam = request.getParameter("eventId");

        if (eventIdParam == null || eventIdParam.isEmpty()) {
            session.setAttribute("registrationMessage", "Invalid event ID.");
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : request.getContextPath() + "/");
            return;
        }

        int eventId = Integer.parseInt(eventIdParam);

        Registration registration = new Registration();
        registration.setUserId(user.getUser_id());
        registration.setEventId(eventId);

        boolean success = registrationService.createRegistration(registration);
        if (success) {
            session.setAttribute("registrationMessage", "You have successfully registered for the event.");
        } else {
            session.setAttribute("registrationMessage", "You may have already registered or an error occurred.");
        }

        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/");
    }
}