package com.planzone.servlet;

import com.planzone.model.Event;
import com.planzone.model.Venue;
import com.planzone.model.Category;
import com.planzone.model.User;
import com.planzone.service.EventService;
import com.planzone.service.VenueService;
import com.planzone.service.CategoryService;
import com.planzone.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@SuppressWarnings("unused")
@WebServlet("/admin/event")
public class EventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EventService eventService;
    private VenueService venueService;
    private CategoryService categoryService;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        eventService = new EventService();
        venueService = new VenueService();
        categoryService = new CategoryService();
        userService = new UserService();
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

        // Block normal Users from accessing any event pages
        if ("User".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('You do not have permission to access this page.');");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/dashboard';</script>");
            return;
        }

        // Restrict create, edit, delete to Organizers only
        if (action != null && ("create".equals(action) || "edit".equals(action) || "delete".equals(action))) {
            if (!"Organizer".equals(role)) {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Access denied. Only Organizers can perform this action.');");
                response.getWriter().println("window.location = '" + request.getContextPath() + "/admin/event';</script>");
                return;
            }
        }

        try {
            if (action == null) {
                request.setAttribute("events", eventService.getAllEvents());
                request.getRequestDispatcher("/adminside/event/index.jsp").forward(request, response);

            } else if ("create".equals(action)) {
                request.setAttribute("venues", venueService.getAllVenues());
                request.setAttribute("categories", categoryService.getAllCategories());
                request.setAttribute("organizers", userService.getAllUsers()); // filter in JSP if needed
                request.getRequestDispatcher("/adminside/event/create.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Event event = eventService.getEventById(id);
                if (event != null) {
                    request.setAttribute("event", event);
                    request.setAttribute("venues", venueService.getAllVenues());
                    request.setAttribute("categories", categoryService.getAllCategories());
                    request.setAttribute("organizers", userService.getAllUsers());
                    request.getRequestDispatcher("/adminside/event/update.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found.");
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                eventService.deleteEvent(id);
                response.sendRedirect(request.getContextPath() + "/admin/event");

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

        String role = (String) session.getAttribute("role");
        if (!"Organizer".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Access denied. Only Organizers can perform this action.');");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/admin/event';</script>");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                Event event = new Event();
                event.setTitle(request.getParameter("title"));
                event.setDescription(request.getParameter("description"));
                event.setStartTime(request.getParameter("start_time"));
                event.setEndTime(request.getParameter("end_time"));
                event.setVenueId(Integer.parseInt(request.getParameter("venue_id")));
                event.setCategoryId(Integer.parseInt(request.getParameter("category_id")));
                event.setOrganizerId(Integer.parseInt(request.getParameter("organizer_id")));

                if (eventService.createEvent(event)) {
                    response.sendRedirect(request.getContextPath() + "/admin/event");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create event.");
                }

            } else if ("update".equals(action)) {
                Event event = new Event();
                event.setEventId(Integer.parseInt(request.getParameter("id")));
                event.setTitle(request.getParameter("title"));
                event.setDescription(request.getParameter("description"));
                event.setStartTime(request.getParameter("start_time"));
                event.setEndTime(request.getParameter("end_time"));
                event.setVenueId(Integer.parseInt(request.getParameter("venue_id")));
                event.setCategoryId(Integer.parseInt(request.getParameter("category_id")));
                event.setOrganizerId(Integer.parseInt(request.getParameter("organizer_id")));

                if (eventService.updateEvent(event)) {
                    response.sendRedirect(request.getContextPath() + "/admin/event");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update event.");
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