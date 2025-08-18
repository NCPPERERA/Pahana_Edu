package edu.pahana.web;

import com.google.gson.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name="ItemsServlet", urlPatterns={"/items"})
public class ItemsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String json = RestClient.get("items");
        req.setAttribute("json", json);
        req.getRequestDispatcher("items.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        String error = null, success = null;

        if ("create".equals(action)) {
            String sku = req.getParameter("sku");
            String name = req.getParameter("name");
            String unitPriceStr = req.getParameter("unitPrice");
            double unitPrice = 0.0;
            try {
                unitPrice = Double.parseDouble(unitPriceStr);
                if (unitPrice < 0) throw new NumberFormatException();
            } catch (NumberFormatException ex) {
                error = "Please enter a valid unit price.";
            }
            if (sku == null || sku.trim().isEmpty() ||
                name == null || name.trim().isEmpty() ||
                error != null) {
                if (error == null) error = "All fields are required.";
                req.setAttribute("error", error);
                req.setAttribute("json", RestClient.get("items"));
                req.getRequestDispatcher("items.jsp").forward(req, resp);
                return;
            }
            JsonObject obj = new JsonObject();
            obj.addProperty("sku", sku);
            obj.addProperty("name", name);
            obj.addProperty("unitPrice", unitPrice);
            RestClient.post("items", obj.toString());
            success = "Item added!";
        }
        req.setAttribute("success", success);
        req.setAttribute("json", RestClient.get("items"));
        req.getRequestDispatcher("items.jsp").forward(req, resp);
    }
}