<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.google.gson.*, com.google.gson.reflect.*, java.lang.reflect.Type" %>
<%
  if (session.getAttribute("user") == null) { response.sendRedirect("index.jsp"); return; }
  String error = (String) request.getAttribute("error");
  String success = (String) request.getAttribute("success");
  String json = (String) request.getAttribute("json");
%>
<!DOCTYPE html>
<html>
<head>
<title>Items - Pahana Edu</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">
<style>
    body { background: #f4f7fa; }
    .container { max-width: 900px; margin: 40px auto; background: #fff; border-radius: 15px; box-shadow: 0 6px 24px rgba(0,0,0,0.08); padding: 30px; }
    h2 { text-align: center; color: #0e6fff; margin-bottom: 24px; }
    nav { margin-bottom: 20px; }
    table { width: 100%; border-collapse: collapse; background: #f6faff; }
    th, td { padding: 14px 10px; text-align: left; }
    th { background: #eaf3ff; }
    tr:nth-child(even) { background: #f4faff; }
    .msg { text-align: center; padding: 10px; border-radius: 7px; margin-bottom: 15px;}
    .msg.error { background: #ffe9e9; color: #d8000c; }
    .msg.success { background: #eaffea; color: #007b1f; }
    .form-group { display: flex; gap: 18px; flex-wrap: wrap; }
    form label { flex: 1 1 160px; }
    form button { margin-top: 12px; width: 120px; }
    @media (max-width: 700px) {
        .container { padding: 7px; }
        .form-group { flex-direction: column; gap: 5px; }
    }
</style>
</head>
<body>
<div class="container">
    <h2>📦 Items</h2>
    <nav><a href="dashboard.jsp">← Back to Dashboard</a></nav>
    <% if (error != null) { %>
        <div class="msg error"><%= error %></div>
    <% } else if (success != null) { %>
        <div class="msg success"><%= success %></div>
    <% } %>
    <form method="post" action="items">
        <input type="hidden" name="action" value="create">
        <div class="form-group">
            <label>SKU <input name="sku" required></label>
            <label>Name <input name="name" required></label>
            <label>Unit Price <input name="unitPrice" required type="number" step="0.01" min="0"></label>
        </div>
        <button type="submit">Add Item</button>
    </form>
    <hr/>
    <h3>Item List</h3>
    <table>
        <tr>
            <th>SKU</th>
            <th>Name</th>
            <th>Unit Price</th>
        </tr>
        <%
        if (json != null && !json.isEmpty()) {
            try {
                Gson gson = new Gson();
                Type listType = new TypeToken<List<Map<String, Object>>>() {}.getType();
                List<Map<String, Object>> items = gson.fromJson(json, listType);
                for (Map<String, Object> item : items) {
                    String sku = String.valueOf(item.get("sku"));
                    String name = String.valueOf(item.get("name"));
                    String unitPrice = String.valueOf(item.get("unitPrice"));
        %>
        <tr>
            <td><%= sku %></td>
            <td><%= name %></td>
            <td style="text-align:right;">Rs. <%= unitPrice %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
        %>
        <tr><td colspan="3">Error loading items.</td></tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="3">No items found.</td></tr>
        <%
        }
        %>
    </table>
</div>
</body>
</html>