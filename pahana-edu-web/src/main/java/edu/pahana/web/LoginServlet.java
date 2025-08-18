package edu.pahana.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name="LoginServlet", urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String u = req.getParameter("username");
        String p = req.getParameter("password");
        if ("admin".equals(u) && "123".equals(p)) {
            req.getSession(true).setAttribute("user", u);
            resp.sendRedirect("dashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid credentials");
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }
    }
}
