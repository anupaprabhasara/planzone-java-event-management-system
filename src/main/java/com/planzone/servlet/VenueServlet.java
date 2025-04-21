package com.planzone.servlet;

import com.planzone.model.Venue;
import com.planzone.service.VenueService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/venue")
public class VenueServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VenueService venueService;

    @Override
    public void init() throws ServletException {
        venueService = new VenueService();
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

        // Role check (User not allowed)
        if ("User".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('You do not have permission to access this page.');");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/dashboard';");
            response.getWriter().println("</script>");
            return;
        }

        try {
            if (action == null) {
                request.setAttribute("venues", venueService.getAllVenues());
                request.getRequestDispatcher("/adminside/venue/index.jsp").forward(request, response);

            } else if ("create".equals(action)) {
                request.getRequestDispatcher("/adminside/venue/create.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Venue venue = venueService.getVenue(id);
                if (venue != null) {
                    request.setAttribute("venue", venue);
                    request.getRequestDispatcher("/adminside/venue/update.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Venue not found.");
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                venueService.deleteVenue(id);
                response.sendRedirect(request.getContextPath() + "/admin/venue");

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                int capacity = Integer.parseInt(request.getParameter("capacity"));

                Venue venue = new Venue();
                venue.setName(name);
                venue.setAddress(address);
                venue.setCapacity(capacity);

                if (venueService.createVenue(venue)) {
                    response.sendRedirect(request.getContextPath() + "/admin/venue");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create venue.");
                }

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                int capacity = Integer.parseInt(request.getParameter("capacity"));

                Venue venue = new Venue();
                venue.setVenueId(id);
                venue.setName(name);
                venue.setAddress(address);
                venue.setCapacity(capacity);

                if (venueService.updateVenue(venue)) {
                    response.sendRedirect(request.getContextPath() + "/admin/venue");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update venue.");
                }

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }
}