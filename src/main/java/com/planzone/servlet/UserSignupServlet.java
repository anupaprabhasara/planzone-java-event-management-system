package com.planzone.servlet;

import com.planzone.model.User;
import com.planzone.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/signup")
public class UserSignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Server-side password validation
        if (password.length() < 8 || !password.matches(".*[A-Z].*") ||
                !password.matches(".*[a-z].*") || !password.matches(".*\\d.*")) {
            request.setAttribute("error", "Password must be at least 8 characters long, contain an uppercase letter, lowercase letter, and a number.");
            request.getRequestDispatcher("/clientside/signup.jsp").forward(request, response);
            return;
        }

        // Create new user
        User user = new User();
        user.setFull_name(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("User");

        boolean success = userService.createUser(user);

        if (success) {
            request.setAttribute("success", "Registration successful! Redirecting to login...");
            request.setAttribute("redirect", true);
        } else {
            request.setAttribute("error", "Something went wrong. Please try again.");
        }

        request.getRequestDispatcher("/clientside/signup.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            String lastPage = request.getHeader("Referer");
            if (lastPage == null || lastPage.contains("/signup")) {
                lastPage = request.getContextPath() + "/";
            }
            response.sendRedirect(lastPage);
        } else {
            request.getRequestDispatcher("/clientside/signup.jsp").forward(request, response);
        }
    }
}