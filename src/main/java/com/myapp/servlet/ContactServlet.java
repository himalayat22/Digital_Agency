package com.myapp.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * ContactServlet - handles contact form submissions
 */
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name    = sanitize(request.getParameter("name"));
        String email   = sanitize(request.getParameter("email"));
        String message = sanitize(request.getParameter("message"));

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if (name == null || name.isEmpty() ||
            email == null || email.isEmpty() ||
            message == null || message.isEmpty()) {

            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"message\": \"All fields are required.\"}");
        } else {
            // In a real app: save to DB, send email, etc.
            System.out.println("Contact form submission from: " + name + " <" + email + ">");
            out.print("{\"success\": true, \"message\": \"Thank you, " + name + "! We'll be in touch.\"}");
        }
        out.flush();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp#contact");
    }

    private String sanitize(String input) {
        if (input == null) return null;
        return input.trim()
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;");
    }
}
