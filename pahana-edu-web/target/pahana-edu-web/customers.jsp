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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Background bookstore image */
        body {
            background: url("https://images.unsplash.com/photo-1512820790803-83ca734da794") no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
        }

        /* Transparent container */
        .container {
            max-width: 950px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.90); /* more visible transparency */
            border-radius: 15px;
            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.25);
            padding: 30px;
        }

        h2 {
            text-align: center;
            color: #0e6fff;
            margin-bottom: 24px;
        }

        nav { margin-bottom: 20px; }
        nav a { text-decoration: none; color: #0e6fff; font-weight: bold; }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fdfdfd;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px 12px;
            text-align: left;
        }
        th {
            background: #eaf3ff;
        }
        tr:nth-child(even) { background: #f8fbff; }

        td img {
            border-radius: 50%;
            width: 48px;
            height: 48px;
            object-fit: cover;
            border: 2px solid #c2e6ff;
        }

        .msg {
            text-align: center;
            padding: 10px;
            border-radius: 7px;
            margin-bottom: 15px;
        }
        .msg.error {
            background: #ffe9e9;
            color: #d8000c;
        }
        .msg.success {
            background: #eaffea;
            color: #007b1f;
        }

        .form-group {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
        }
        form label {
            flex: 1 1 160px;
        }
        form button {
            margin-top: 12px;
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            background: #0e6fff;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        form button:hover {
            background: #005fcc;
        }

        .actions {
            display: flex;
            gap: 6px;
        }
        form.inline { display: inline; }

        .icon-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
            color: #0e6fff;
            transition: color 0.2s;
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
            .container { padding: 15px; }
            .form-group { flex-direction: column; gap: 10px; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>👥 Customers</h2>
        <nav><a href="dashboard.jsp">Back</a></nav>

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
            <button type="submit"><%= editId != null ? "Update" : "Add" %></button>
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
                <td><img src="<%= avatarUrl %>" alt="avatar"></td>
                <td><%= accountNumber %></td>
                <td><%= name %></td>
                <td><%= address %></td>
                <td><%= phone %></td>
                <td class="actions">
                    <!-- Edit action -->
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

                    <!-- Delete action -->
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
