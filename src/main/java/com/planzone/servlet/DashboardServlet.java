package com.planzone.servlet;

import com.planzone.service.DashboardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DashboardService dashboardService;

    @Override
    public void init() throws ServletException {
        dashboardService = new DashboardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        String role = (String) session.getAttribute("role");
        
        // Block normal Users from accessing any event pages
        if ("User".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('You do not have permission to access this page.');");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/dashboard';</script>");
            return;
        }

        try {
            // Set counts for dashboard
            request.setAttribute("totalEvents", dashboardService.getTotalEvents());
            request.setAttribute("totalRegistrations", dashboardService.getTotalRegistrations());
            request.setAttribute("totalVenues", dashboardService.getTotalVenues());
            request.setAttribute("totalUsers", dashboardService.getTotalUsers());

            // Forward to dashboard JSP
            request.getRequestDispatcher("/adminside/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard.");
        }
    }
}