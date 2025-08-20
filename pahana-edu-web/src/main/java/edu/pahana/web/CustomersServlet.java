package edu.pahana.web;

import com.google.gson.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name="CustomersServlet", urlPatterns={"/customers"})
public class CustomersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String json = RestClient.get("customers");
        req.setAttribute("json", json);
        req.getRequestDispatcher("/customers.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        String accountNumber = req.getParameter("accountNumber");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String error = null, success = null;

        if ("create".equals(action)) {
            if (accountNumber == null || name == null || address == null || phone == null ||
                accountNumber.trim().isEmpty() || name.trim().isEmpty() || address.trim().isEmpty() || phone.trim().isEmpty()) {
                error = "All fields are required.";
            } else {
                // Check if account exists
                String customersJson = RestClient.get("customers");
                boolean exists = false;
                String customerId = null;

                try {
                    JsonArray arr = JsonParser.parseString(customersJson).getAsJsonArray();
                    for (JsonElement el : arr) {
                        JsonObject obj = el.getAsJsonObject();
                        if (accountNumber.equals(obj.get("accountNumber").getAsString())) {
                            exists = true;
                            customerId = obj.has("id") ? obj.get("id").getAsString() : null; // If there's an internal id
                            break;
                        }
                    }
                } catch (Exception e) { error = "Error checking existing customers."; }

                JsonObject obj = new JsonObject();
                obj.addProperty("accountNumber", accountNumber);
                obj.addProperty("name", name);
                obj.addProperty("address", address);
                obj.addProperty("phone", phone);

                if (exists && customerId != null) {
                    // Update existing customer via PUT, assuming RestClient.put(endpoint, id, json)
                    RestClient.put("customers", customerId, obj.toString());
                    success = "Customer updated!";
                } else if (exists) {
                    // If no customerId, fallback to update by accountNumber if supported
                    RestClient.put("customers/byAccountNumber/" + accountNumber, obj.toString());
                    success = "Customer updated!";
                } else {
                    // Create new customer
                    RestClient.post("customers", obj.toString());
                    success = "Customer added!";
                }
            }
        }

        // reload list and show feedback
        req.setAttribute("error", error);
        req.setAttribute("success", success);
        req.setAttribute("json", RestClient.get("customers"));
        req.getRequestDispatcher("customers.jsp").forward(req, resp);
    }
}