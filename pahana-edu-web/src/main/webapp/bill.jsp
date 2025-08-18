<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Map, java.util.List" %>

<%
  if (session.getAttribute("user") == null) { response.sendRedirect("index.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Create bill</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">
  <style>
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      font-size: 1.25rem;
      max-width: 1200px;
      margin: 0 auto;
      padding: 2rem;
      background-color: #f5f7fa;
    }
    h2 {
      font-size: 2.5rem;
      margin-bottom: 0.5em;
      color: #1a3c6d;
      text-align: center;
    }
    label {
      font-weight: 600;
      font-size: 1.1rem;
      margin-top: 1em;
      color: #333;
    }
    .items-table {
      width: 100%;
      margin-bottom: 1em;
      border-collapse: collapse;
      background-color: #fff;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }
    .items-table th, .items-table td {
      font-size: 1.15rem;
      padding: 0.8em;
      text-align: left;
      border-bottom: 1px solid #e0e0e0;
    }
    .items-table th {
      background-color: #f0f4f8;
      color: #1a3c6d;
      font-weight: 600;
    }
    .items-table input[name="itemId"], .items-table input[name="quantity"] {
      width: 100px;
      font-size: 1.15rem;
      padding: 0.5em;
      border: 2px solid #1a3c6d;
      border-radius: 6px;
      background-color: #e6f0fa;
      transition: background-color 0.2s, border-color 0.2s;
    }
    .items-table input[name="itemId"]:focus, .items-table input[name="quantity"]:focus {
      background-color: #ffffff;
      border-color: #2b5ea1;
      outline: none;
    }
    .add-row-btn, .remove-row-btn {
      font-size: 1.1rem;
      padding: 0.4em 1em;
      margin: 0.2em;
      cursor: pointer;
      border-radius: 4px;
      transition: background-color 0.2s;
      color: #000;
      border: none;
    }
    .add-row-btn {
      background-color: #1a3c6d;
      color: #000;
      font-size: 1.2rem;
      padding: 0.4em;
      line-height: 1;
    }
    .add-row-btn::before {
      content: '\2795'; /* Unicode for plus sign */
      display: inline-block;
    }
    .add-row-btn:hover {
      background-color: #2b5ea1;
    }
    .remove-row-btn {
      background-color: #d9534f;
      color: #000;
      font-size: 1.2rem;
      padding: 0.4em;
      line-height: 1;
    }
    .remove-row-btn::before {
      content: '\2796'; /* Unicode for minus sign */
      display: inline-block;
    }
    .remove-row-btn:hover {
      background-color: #c9302c;
    }
    .output-section {
      margin-top: 2em;
      background: #fff;
      padding: 2em;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      border: 1px solid #d0d7de;
      max-width: 800px;
      margin-left: auto;
      margin-right: auto;
      text-align: center;
    }
    .output-section h3 {
      font-size: 1.8rem;
      margin-bottom: 0.75em;
      color: #1a3c6d;
      font-weight: 600;
    }
    .output-section pre {
      font-size: 1.15rem;
      background: #f8fafc;
      padding: 1.5em;
      border-radius: 6px;
      border: 1px solid #e0e0e0;
      text-align: left;
      white-space: pre-wrap;
      word-wrap: break-word;
      box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
    }
    .success-msg {
      color: #2e7d32;
      font-size: 1.15rem;
      font-weight: 500;
      margin-bottom: 1em;
      background: #e8f5e9;
      padding: 0.8em;
      border-radius: 4px;
      border: 1px solid #c8e6c9;
    }
    .error-msg {
      color: #d32f2f;
      font-size: 1.15rem;
      font-weight: 500;
      margin-bottom: 1em;
      background: #ffebee;
      padding: 0.8em;
      border-radius: 4px;
      border: 1px solid #ffcdd2;
    }
    form > button[type="submit"] {
      font-size: 1.25rem;
      padding: 0.5em 2em;
      background-color: #1a3c6d;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.2s;
    }
    form > button[type="submit"]:hover {
      background-color: #2b5ea1;
    }
    nav a {
      font-size: 1.15rem;
      color: #1a3c6d;
      text-decoration: none;
      font-weight: 500;
    }
    nav a:hover {
      text-decoration: underline;
    }
  </style>
  <script>
    function addRow() {
      const table = document.getElementById('itemsTable');
      const row = table.insertRow();
      row.innerHTML = `
        <td><input name="itemId" type="number" min="1" required style="width: 100px; font-size: 1.15rem; padding: 0.5em; border: 2px solid #1a3c6d; border-radius: 6px; background-color: #e6f0fa;"></td>
        <td><input name="quantity" type="number" min="1" required style="width: 100px; font-size: 1.15rem; padding: 0.5em; border: 2px solid #1a3c6d; border-radius: 6px; background-color: #e6f0fa;"></td>
        <td><button type="button" class="remove-row-btn" onclick="removeRow(this)"></button></td>
      `;
    }
    function removeRow(btn) {
      const row = btn.parentElement.parentElement;
      row.parentElement.removeChild(row);
    }
    function gatherItemsJSON() {
      const itemIds = document.getElementsByName('itemId');
      const quantities = document.getElementsByName('quantity');
      const result = [];
      for (let i = 0; i < itemIds.length; i++) {
        const itemId = itemIds[i].value;
        const quantity = quantities[i].value;
        if (itemId && quantity) result.push({ itemId: parseInt(itemId), quantity: parseInt(quantity) });
      }
      document.getElementById('itemsHidden').value = JSON.stringify(result);
    }
  </script>
</head>
<body>
<h2>Buy Books</h2>
<nav><a href="dashboard.jsp">Back</a></nav>
<form method="post" action="bill" onsubmit="gatherItemsJSON()">
  <label>Customer ID
    <input name="customerId" type="number" min="1" required style="font-size:1.15rem; width:150px; padding:0.4em; border: 1px solid #d0d7de; border-radius: 4px;">
  </label><br>
  <label>Items and Quantity</label>
  <table class="items-table" id="itemsTable">
    <tr>
      <th>Item ID</th>
      <th>Quantity</th>
      <th></th>
    </tr>
    <tr>
      <td><input name="itemId" type="number" min="1" required style="width: 100px; font-size: 1.15rem; padding: 0.5em; border: 2px solid #1a3c6d; border-radius: 6px; background-color: #e6f0fa;"></td>
      <td><input name="quantity" type="number" min="1" required style="width: 100px; font-size: 1.15rem; padding: 0.5em; border: 2px solid #1a3c6d; border-radius: 6px; background-color: #e6f0fa;"></td>
      <td><button type="button" class="remove-row-btn" onclick="removeRow(this)"></button></td>
    </tr>
  </table>
  <button type="button" class="add-row-btn" onclick="addRow()"></button>
  <input type="hidden" id="itemsHidden" name="items">
  <button type="submit">Calculate &amp; Save</button>
</form>

<div class="output-section">
  <% 
    // Show success message if bill was added successfully
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getAttribute("success") == null && request.getAttribute("error") == null) { 
  %>
    <div class="success-msg">bill added successfully</div>
  <% } %>
  <% if (request.getAttribute("success") != null) { %>
    <div class="success-msg"><%= request.getAttribute("success") %></div>
  <% } %>
  <% if (request.getAttribute("error") != null) { %>
    <div class="error-msg"><%= request.getAttribute("error") %></div>
  <% } %>
</div>
</body>
</html>