package com.planzone.servlet;

import com.planzone.model.Registration;
import com.planzone.service.RegistrationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/registration")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RegistrationService registrationService;

    @Override
    public void init() throws ServletException {
        registrationService = new RegistrationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        String action = request.getParameter("action");

        // Block normal Users from accessing registration management
        if ("User".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('You do not have permission to access this page.');");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/dashboard';</script>");
            return;
        }

        try {
            if (action == null) {
                List<Registration> registrations = registrationService.getAllRegistrations();
                request.setAttribute("registrations", registrations);
                request.getRequestDispatcher("/adminside/registration/index.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                if (!"Organizer".equals(role)) {
                    response.setContentType("text/html");
                    response.getWriter().println("<script>alert('Access denied. Only Organizers can delete registrations.');");
                    response.getWriter().println("window.location = '" + request.getContextPath() + "/admin/registration';</script>");
                    return;
                }

                int id = Integer.parseInt(request.getParameter("id"));
                registrationService.deleteRegistration(id);
                response.sendRedirect(request.getContextPath() + "/admin/registration");

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }
}