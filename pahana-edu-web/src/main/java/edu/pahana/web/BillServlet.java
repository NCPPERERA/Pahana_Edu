package edu.pahana.web;

import com.google.gson.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "BillServlet", urlPatterns = {"/bill"})
public class BillServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String customerId = req.getParameter("customerId");
        String items = req.getParameter("items");

        JsonObject body = new JsonObject();
        boolean valid = true;

        // Validate customerId
        try {
            body.addProperty("customerId", Integer.parseInt(customerId));
        } catch (NumberFormatException ex) {
            valid = false;
            req.setAttribute("error", "Invalid Customer ID");
        }

        // Validate items JSON
        try {
            JsonElement parsed = JsonParser.parseString(items);
            if (parsed.isJsonArray()) {
                body.add("items", parsed.getAsJsonArray());
            } else {
                valid = false;
                req.setAttribute("error", "Items must be a JSON array");
            }
        } catch (Exception e) {
            valid = false;
            req.setAttribute("error", "Invalid JSON format in items");
        }

        if (valid) {
            try {
                // Call backend API
                String responseJson = RestClient.post("orders", body.toString());
                System.out.println("Backend response: " + responseJson); // Log for debugging

                // Parse backend response
                JsonObject responseObj = JsonParser.parseString(responseJson).getAsJsonObject();

                // Create invoice JsonObject
                JsonObject invoice = new JsonObject();
                invoice.addProperty("customerId", responseObj.has("customer") && 
                    responseObj.get("customer").getAsJsonObject().has("id") ? 
                    responseObj.get("customer").getAsJsonObject().get("id").getAsInt() : 0);

                // Process items to ensure itemName and price are included
                JsonArray itemsArr = responseObj.has("items") ? 
                    responseObj.get("items").getAsJsonArray() : new JsonArray();
                JsonArray modifiedItems = new JsonArray();
                for (JsonElement item : itemsArr) {
                    JsonObject itemObj = item.getAsJsonObject();
                    JsonObject modifiedItem = new JsonObject();
                    modifiedItem.addProperty("itemId", itemObj.has("itemId") && !itemObj.get("itemId").isJsonNull() ? 
                        itemObj.get("itemId").getAsInt() : 0);
                    modifiedItem.addProperty("itemName", itemObj.has("itemName") && !itemObj.get("itemName").isJsonNull() ? 
                        itemObj.get("itemName").getAsString() : "Unknown Item");
                    modifiedItem.addProperty("price", itemObj.has("price") && !itemObj.get("price").isJsonNull() ? 
                        itemObj.get("price").getAsDouble() : 0.0);
                    modifiedItem.addProperty("quantity", itemObj.has("quantity") && !itemObj.get("quantity").isJsonNull() ? 
                        itemObj.get("quantity").getAsInt() : 0);
                    modifiedItems.add(modifiedItem);
                }
                invoice.add("items", modifiedItems);
                invoice.addProperty("total", responseObj.has("total") && !responseObj.get("total").isJsonNull() ? 
                    responseObj.get("total").getAsDouble() : 0.0);

                // Attach invoice to request
                req.setAttribute("invoice", invoice);

            } catch (Exception e) {
                req.setAttribute("error", "Failed to process bill: " + e.getMessage());
                e.printStackTrace(); // Log stack trace for debugging
            }
        }

        // Forward to JSP for rendering
        req.getRequestDispatcher("bill.jsp").forward(req, resp);
    }
}