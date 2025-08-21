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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    /* Background image with overlay */
    body {
        background: url('images/bookstore-bg.jpg') no-repeat center center fixed;
        background-size: cover;
        font-family: 'Segoe UI', sans-serif;
    }

    /* Semi-transparent glass effect container */
    .container {
        max-width: 1000px;
        margin: 40px auto;
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(8px);
        border-radius: 18px;
        box-shadow: 0 6px 24px rgba(0,0,0,0.15);
        padding: 30px;
    }

    h2 {
        text-align: center;
        color: #0e6fff;
        margin-bottom: 20px;
        font-size: 28px;
    }

    /* Tabs in two rows */
    nav {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 10px;
        margin-bottom: 25px;
    }
    nav a {
        display: block;
        padding: 12px;
        text-align: center;
        text-decoration: none;
        background: #0e6fff;
        color: #fff;
        font-weight: 500;
        border-radius: 10px;
        transition: 0.3s;
    }
    nav a:hover {
        background: #094bb8;
    }

    .msg {
        text-align: center;
        padding: 10px;
        border-radius: 7px;
        margin-bottom: 15px;
    }
    .msg.error { background: #ffe9e9; color: #d8000c; }
    .msg.success { background: #eaffea; color: #007b1f; }

    /* Form */
    form {
        margin-bottom: 20px;
    }
    .form-group {
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
        margin-bottom: 10px;
    }
    form label {
        flex: 1 1 220px;
        font-weight: bold;
    }
    form input {
        width: 100%;
        padding: 8px;
        border-radius: 8px;
        border: 1px solid #ccc;
    }
    form button {
        margin-top: 12px;
        width: 150px;
        padding: 10px;
        border-radius: 10px;
        border: none;
        font-weight: bold;
        cursor: pointer;
    }
    button[type="submit"] {
        background: #9ac74e;
        color: #000;
    }
    #cancelButton {
        background: #bbb;
        color: #000;
    }

    /* Table */
    table {
        width: 100%;
        border-collapse: collapse;
        background: #f8fbff;
        border-radius: 10px;
        overflow: hidden;
    }
    th, td {
        padding: 14px 10px;
        text-align: left;
    }
    th {
        background: #eaf3ff;
    }
    tr:nth-child(even) { background: #f4faff; }

    .action-buttons button {
    padding: 8px 12px;
    border-radius: 8px;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px; /* icon size */
}

button.update { background: #4e9ac7;}
button.delete { background: #c74e4e; }

.action-buttons button i {
    pointer-events: none; /* allow click on button, not the icon */
}


    @media (max-width: 700px) {
        .form-group { flex-direction: column; gap: 5px; }
       
    }
</style>
</head>
<body>
<div class="container">
    <h2>📦 Manage Items</h2>
    
  

    <!-- Messages -->
    <% if (error != null) { %>
        <div class="msg error"><%= error %></div>
    <% } else if (success != null) { %>
        <div class="msg success"><%= success %></div>
    <% } %>

    <!-- Item Form -->
    <form method="post" action="items" id="itemForm">
        <input type="hidden" name="action" id="formAction" value="create">
        <input type="hidden" name="originalSku" id="originalSku">
        <div class="form-group">
            <label>Item ID <input name="sku" id="sku" required></label>
            <label>Name <input name="name" id="name" required></label>
            <label>Unit Price <input name="unitPrice" id="unitPrice" required type="number" step="0.01" min="0"></label>
        </div>
        <button type="submit" id="submitButton">Add Item</button>
        <button type="button" id="cancelButton" style="display:none;" onclick="resetForm()">Cancel</button>
    </form>

    <hr/>

    <!-- Item List -->
    <h3>📋 Item List</h3>
    <table>
        <tr>
            <th>Item ID</th>
            <th>Name</th>
            <th>Unit Price</th>
            <th>Actions</th>
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
            <td class="action-buttons">
                <button class="update" title="Update" onclick='editItem("<%= sku %>", "<%= name %>", "<%= unitPrice %>")'>
                    <i class="fas fa-edit"></i>
                </button>
                <button class="delete" title="Delete" onclick='deleteItem("<%= sku %>")'>
                    <i class="fas fa-trash-alt"></i>
                </button>
            </td>

        </tr>
        <%
                }
            } catch (Exception e) {
        %>
        <tr><td colspan="4">Error loading items.</td></tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="4">No items found.</td></tr>
        <%
        }
        %>
    </table>
</div>

<script>
function editItem(sku, name, unitPrice) {
    document.getElementById('formAction').value = 'update';
    document.getElementById('originalSku').value = sku;
    document.getElementById('sku').value = sku;
    document.getElementById('name').value = name;
    document.getElementById('unitPrice').value = unitPrice;
    document.getElementById('submitButton').textContent = 'Update Item';
    document.getElementById('sku').readOnly = true;
    document.getElementById('cancelButton').style.display = 'inline-block';
}

function deleteItem(sku) {
    if (confirm('Are you sure you want to delete item ' + sku + '?')) {
        document.getElementById('formAction').value = 'delete';
        document.getElementById('originalSku').value = sku;
        document.getElementById('itemForm').submit();
    }
}

function resetForm() {
    document.getElementById('formAction').value = 'create';
    document.getElementById('originalSku').value = '';
    document.getElementById('sku').value = '';
    document.getElementById('name').value = '';
    document.getElementById('unitPrice').value = '';
    document.getElementById('submitButton').textContent = 'Add Item';
    document.getElementById('sku').readOnly = false;
    document.getElementById('cancelButton').style.display = 'none';
}
</script>
</body>
</html>
