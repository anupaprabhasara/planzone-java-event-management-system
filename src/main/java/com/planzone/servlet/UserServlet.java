package com.planzone.servlet;

import com.planzone.model.User;
import com.planzone.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/user")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
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
        
        // Role check
        if ("User".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('You do not have permission to access this page.');");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/dashboard';");
            response.getWriter().println("</script>");
            return;
        }

        // Access control
        if (action != null && ("create".equals(action) || "edit".equals(action) || "delete".equals(action))) {
            if ("Organizer".equals(role)) {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Access denied. Only Admins can perform this action.');");
                response.getWriter().println("window.location = '" + request.getContextPath() + "/admin/user';</script>");
                return;
            }
        }

        try {
            if (action == null) {
                request.setAttribute("users", userService.getAllUsers());
                request.getRequestDispatcher("/adminside/user/index.jsp").forward(request, response);

            } else if ("create".equals(action)) {
                request.getRequestDispatcher("/adminside/user/create.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                User user = userService.getUser(id);
                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/adminside/user/update.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found.");
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                userService.deleteUser(id);
                response.sendRedirect(request.getContextPath() + "/admin/user");

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
        if ("Organizer".equals(role)) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Access denied. Only Admins can perform this action.');");
            response.getWriter().println("window.location = '" + request.getContextPath() + "/admin/user';</script>");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                String fullName = request.getParameter("full_name");
                String r = request.getParameter("role");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                if (fullName == null || email == null || password == null || r == null) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing form fields.");
                    return;
                }

                User user = new User();
                user.setFull_name(fullName);
                user.setRole(r);
                user.setEmail(email);
                user.setPassword(password);

                if (userService.createUser(user)) {
                    response.sendRedirect(request.getContextPath() + "/admin/user");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create user.");
                }

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String fullName = request.getParameter("full_name");
                String r = request.getParameter("role");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                User user = new User();
                user.setUser_id(id);
                user.setFull_name(fullName);
                user.setRole(r);
                user.setEmail(email);
                user.setPassword(password);

                if (userService.updateUser(user)) {
                    response.sendRedirect(request.getContextPath() + "/admin/user");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update user.");
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