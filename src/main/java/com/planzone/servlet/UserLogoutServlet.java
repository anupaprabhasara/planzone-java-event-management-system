package com.planzone.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class UserLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // get existing session, do not create new one
        if (session != null) {
            session.invalidate(); // destroy session
        }
        response.sendRedirect(request.getContextPath() + "/"); // redirect to login page
    }
}