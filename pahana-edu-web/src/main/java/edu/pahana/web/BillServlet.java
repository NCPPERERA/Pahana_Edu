package edu.pahana.web;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="BillServlet", urlPatterns={"/bill"})
public class BillServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("bill.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String customerId = req.getParameter("customerId");
        String items = req.getParameter("items"); // JSON array

        JsonObject body = new JsonObject();
        try {
            body.addProperty("customerId", Integer.parseInt(customerId));
        } catch (NumberFormatException ex) {
            body.addProperty("customerId", 0);
        }

        try {
            JsonElement parsed = JsonParser.parseString(items);
            if (parsed.isJsonArray()) {
                body.add("items", parsed.getAsJsonArray());
            } else {
                body.add("items", new JsonArray());
            }
        } catch (Exception e) {
            body.add("items", new JsonArray());
        }

        String json = RestClient.post("orders", body.toString());
        req.setAttribute("json", json);
        req.getRequestDispatcher("bill.jsp").forward(req, resp);
    }
}
