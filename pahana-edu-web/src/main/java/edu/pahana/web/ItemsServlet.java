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
        try {
            String json = RestClient.get("items");
            req.setAttribute("json", json);
        } catch (Exception e) {
            req.setAttribute("error", "Failed to load items: " + e.getMessage());
        }
        req.getRequestDispatcher("items.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        String error = null, success = null;

        try {
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
                    error = error != null ? error : "All fields are required.";
                } else {
                    JsonObject obj = new JsonObject();
                    obj.addProperty("sku", sku);
                    obj.addProperty("name", name);
                    obj.addProperty("unitPrice", unitPrice);
                    RestClient.post("items", obj.toString());
                    success = "Item added!";
                }
            } else if ("update".equals(action)) {
                String originalSku = req.getParameter("originalSku");
                String name = req.getParameter("name");
                String unitPriceStr = req.getParameter("unitPrice");
                double unitPrice = 0.0;
                try {
                    unitPrice = Double.parseDouble(unitPriceStr);
                    if (unitPrice < 0) throw new NumberFormatException();
                } catch (NumberFormatException ex) {
                    error = "Please enter a valid unit price.";
                }
                if (originalSku == null || originalSku.trim().isEmpty() ||
                    name == null || name.trim().isEmpty() ||
                    error != null) {
                    error = error != null ? error : "All fields are required.";
                } else {
                    JsonObject obj = new JsonObject();
                    obj.addProperty("name", name);
                    obj.addProperty("unitPrice", unitPrice);
                    RestClient.put("items/" + originalSku, obj.toString());
                    success = "Item updated!";
                }
            } else if ("delete".equals(action)) {
                String originalSku = req.getParameter("originalSku");
                if (originalSku == null || originalSku.trim().isEmpty()) {
                    error = "Item ID is required.";
                } else {
                    RestClient.delete("items/" + originalSku);
                    success = "Item deleted!";
                }
            } else {
                error = "Invalid action.";
            }
        } catch (Exception e) {
            error = "Operation failed: " + e.getMessage();
        }

        if (error != null) {
            req.setAttribute("error", error);
        } else if (success != null) {
            req.setAttribute("success", success);
        }
        req.setAttribute("json", RestClient.get("items"));
        req.getRequestDispatcher("items.jsp").forward(req, resp);
    }
}