package com.myapp.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;

/**
 * HealthServlet - returns app health status (used by Jenkins/monitoring)
 * GET /health → {"status":"UP","timestamp":"...","app":"mywebapp"}
 */
public class HealthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_OK);

        PrintWriter out = response.getWriter();
        out.print("{");
        out.print("\"status\": \"UP\",");
        out.print("\"app\": \"mywebapp\",");
        out.print("\"version\": \"1.0.0\",");
        out.print("\"timestamp\": \"" + Instant.now().toString() + "\"");
        out.print("}");
        out.flush();
    }
}
