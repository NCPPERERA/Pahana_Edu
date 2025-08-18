<%@ page import="com.google.gson.*, java.util.*" %>
<%
  String json = (String) request.getAttribute("json");
  String type = request.getParameter("type");
  if (json == null || json.trim().isEmpty()) {
%>
    <span style="color:#999; font-size:1.2em;">No report data available.</span>
<%
  } else {
    try {
      JsonElement je = JsonParser.parseString(json);
      if ("sales-today".equals(type) && je.isJsonArray()) {
        JsonArray arr = je.getAsJsonArray();
%>
  <table style="width:100%; border-collapse:collapse;">
    <tr style="background:#e9e9fa;">
      <th style="padding:8px; border:1px solid #ccc;">Invoice No</th>
      <th style="padding:8px; border:1px solid #ccc;">Customer</th>
      <th style="padding:8px; border:1px solid #ccc;">Total (Rs.)</th>
      <th style="padding:8px; border:1px solid #ccc;">Date</th>
    </tr>
    <%
      for (JsonElement elem : arr) {
        JsonObject orders = elem.getAsJsonObject();
    %>
    <tr>
      <td style="padding:8px; border:1px solid #eee;"><%= orders.get("id").getAsString() %></td>
      <td style="padding:8px; border:1px solid #eee;"><%= orders.get("name").getAsString() %></td>
      <td style="padding:8px; border:1px solid #eee; text-align:right;">
        <%= String.format("%.2f", orders.get("line_total").getAsDouble()) %>
      </td>
      <td style="padding:8px; border:1px solid #eee;">
        <%= orders.has("date") ? orders.get("date").getAsString() : "" %>
      </td>
    </tr>
    <%
      }
    %>
  </table>
<%
      } else if ("top-items".equals(type) && je.isJsonArray()) {
        JsonArray arr = je.getAsJsonArray();
%>
  <table style="width:100%; border-collapse:collapse;">
    <tr style="background:#e9e9fa;">
      <th style="padding:8px; border:1px solid #ccc;">Item Name</th>
      <th style="padding:8px; border:1px solid #ccc;">Quantity Sold</th>
      <th style="padding:8px; border:1px solid #ccc;">Sales Amount (Rs.)</th>
    </tr>
    <%
      for (JsonElement elem : arr) {
        JsonObject item = elem.getAsJsonObject();
    %>
    <tr>
      <td style="padding:8px; border:1px solid #eee;"><%= item.get("name").getAsString() %></td>
      <td style="padding:8px; border:1px solid #eee; text-align:right;"><%= item.get("quantity").getAsInt() %></td>
      <td style="padding:8px; border:1px solid #eee; text-align:right;">
        <%= String.format("%.2f", item.get("salesAmount").getAsDouble()) %>
      </td>
    </tr>
    <%
      }
    %>
  </table>
<%
      } else {
%>
  <span style="color:#d00000;">Invalid or unsupported report format.</span>
<%
      }
    } catch (Exception ex) {
%>
  <span style="color:#d00000;">Error parsing report data.</span>
<%
    }
  }
%>