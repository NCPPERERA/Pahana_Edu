<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.google.gson.*, com.google.gson.reflect.*, java.lang.reflect.Type" %>
<%
  if (session.getAttribute("user") == null) { response.sendRedirect("index.jsp"); return; }
  String error = (String) request.getAttribute("error");
  String success = (String) request.getAttribute("success");
  String json = (String) request.getAttribute("json");
  String editId = request.getParameter("editId");
  String editAccount = request.getParameter("editAccount");
  String editName = request.getParameter("editName");
  String editAddress = request.getParameter("editAddress");
  String editPhone = request.getParameter("editPhone");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customers - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f4f7fa; }
        
        .container { max-width: 900px; 
                    margin: 40px auto; 
                    background: #fff; 
                    border-radius: 15px; 
                    box-shadow: 0 6px 24px rgba(0,0,0,0.08); 
                    padding: 30px; }
        
        h2 { text-align: center; 
             color: #0e6fff; 
             margin-bottom: 24px; }
        
        nav { margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; background: #f6faff; }
        th, td { padding: 14px 10px; text-align: left; }
        th { background: #eaf3ff; }
        td img { border-radius: 50%; width: 48px; height: 48px; object-fit: cover; border: 2px solid #c2e6ff; }
        tr:nth-child(even) { background: #f4faff; }
        .msg { text-align: center; 
               padding: 10px; 
              border-radius: 7px; 
              margin-bottom: 15px;}
        .msg.error { background: #ffe9e9; 
                color: #d8000c; }
        .msg.success { background: #eaffea; 
                  color: #007b1f; }
        .form-group { display: flex; gap: 18px; 
                     flex-wrap: wrap; }
        form label { flex: 1 1 160px; }
        form button { margin-top: 12px; 
                      width: 120px; }
        .actions { display: flex; 
                  gap: 8px; }
        form.inline { display: inline; }
        
        .icon-btn {
                    background: none;
                    border: none;
                    padding: 1px 1px;       /* smaller padding */
                    cursor: pointer;
                    font-size: 18px;        /* slightly smaller icon */
                    color: #0e6fff;
                    transition: color 0.2s;
                    line-height: 1;
                    margin: 0 0px;          /* reduce space between buttons */
                    }
        .icon-btn.delete {
            color: #b00;
        }
        .icon-btn:hover {
            color: #005fcc;
        }
        .icon-btn.delete:hover {
            color: #a00;
        }
        @media (max-width: 700px) {
            .container { padding: 7px; }
            .form-group { flex-direction: column; gap: 5px; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>👥 Customers</h2>
        <nav><a href="dashboard.jsp">← Back to Dashboard</a></nav>
        <% if (error != null) { %>
            <div class="msg error"><%= error %></div>
        <% } else if (success != null) { %>
            <div class="msg success"><%= success %></div>
        <% } %>
        <!-- Add/Edit Form -->
        <form method="post" action="customers">
            <input type="hidden" name="action" value="<%= editId != null ? "edit" : "create" %>">
            <% if (editId != null) { %>
                <input type="hidden" name="id" value="<%= editId %>">
            <% } %>
            <div class="form-group">
                <label>Account # <input name="accountNumber" required pattern="\d+" value="<%= editAccount != null ? editAccount : "" %>"></label>
                <label>Name <input name="name" required value="<%= editName != null ? editName : "" %>"></label>
                <label>Address <input name="address" required value="<%= editAddress != null ? editAddress : "" %>"></label>
                <label>Phone <input name="phone" required pattern="\d{7,}" value="<%= editPhone != null ? editPhone : "" %>"></label>
            </div>
            <button type="submit"><%= editId != null ? "Update" : "Add" %></button><br
            <% if (editId != null) { %>
                <a href="customers">Cancel</a>
            <% } %>
        </form>

        <hr/>
        <h3>Customer List</h3>
        <table>
            <tr>
                <th>Avatar</th>
                <th>Account #</th>
                <th>Name</th>
                <th>Address</th>
                <th>Phone</th>
                <th>Actions</th>
            </tr>
            <%
            if (json != null && !json.isEmpty()) {
                try {
                    Gson gson = new Gson();
                    Type listType = new TypeToken<List<Map<String, Object>>>() {}.getType();
                    List<Map<String, Object>> customers = gson.fromJson(json, listType);
                    for (Map<String, Object> cust : customers) {
                        String id = cust.get("id") != null ? String.valueOf(cust.get("id")) : "";
                        String accountNumber = String.valueOf(cust.get("accountNumber"));
                        String name = String.valueOf(cust.get("name"));
                        String address = String.valueOf(cust.get("address"));
                        String phone = String.valueOf(cust.get("phone"));
                        String avatarUrl = "https://api.dicebear.com/7.x/initials/svg?radius=50&seed=" + java.net.URLEncoder.encode(name, "UTF-8");
            %>
            <tr>
                <td>
                    <img src="<%= avatarUrl %>" alt="avatar">
                </td>
                <td><%= accountNumber %></td>
                <td><%= name %></td>
                <td><%= address %></td>
                <td><%= phone %></td>
                <td class="actions">
                    <!-- Edit action: reload page with edit form populated -->
                    <form class="inline" method="get" action="customers">
                        <input type="hidden" name="editId" value="<%= id %>">
                        <input type="hidden" name="editAccount" value="<%= accountNumber %>">
                        <input type="hidden" name="editName" value="<%= name %>">
                        <input type="hidden" name="editAddress" value="<%= address %>">
                        <input type="hidden" name="editPhone" value="<%= phone %>">
                        <button class="icon-btn" type="submit" title="Edit" aria-label="Edit">
                            <i class="fa-solid fa-pen-to-square"></i>
                        </button>
                    </form>

                    <!-- Delete action: POST with action=delete -->
                    <form class="inline" method="post" action="customers" onsubmit="return confirm('Delete this customer?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button class="icon-btn delete" type="submit" title="Delete" aria-label="Delete">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
            %>
            <tr><td colspan="6">Error loading customers.</td></tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="6">No customers found.</td></tr>
            <%
            }
            %>
        </table>
    </div>
</body>
</html>