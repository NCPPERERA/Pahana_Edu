<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Help & User Guide - Pahana Edu</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">
  <style>
    .note { background: #f7f7ff; padding: .75rem 1rem; border-left: 4px solid #8a8aff; }
    .kbd { border: 1px solid #ccc; padding: 0 .3rem; border-radius: 4px; font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace; }
    @media print {
      nav, .no-print { display: none !important; }
      body { font-size: 12pt; }
      h1, h2, h3 { page-break-after: avoid; }
      pre, code { white-space: pre-wrap; }
    }
    details > summary { cursor: pointer; }
  </style>
</head>
<body>
  <nav class="no-print">
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="customers">Customers</a> |
    <a href="items">Items</a> |
    <a href="bill">Create Bill</a> |
    <a href="reports">Reports</a> |
    <a href="logout">Logout</a>
  </nav>

  <h1>Pahana Edu – Help & User Guide</h1>
  <p class="note">This guide explains how to log in, manage customers and items, create bills (orders), view reports, and troubleshoot common issues. Use the <span class="kbd">Ctrl</span> + <span class="kbd">P</span> shortcut to print.</p>

  <h2 id="login">1) Login</h2>
  <ul>
    <li>Open the application. The login screen appears.</li>
    <li>Default credentials (for demo/testing): <strong>admin / admin123</strong>.</li>
    <li>On success you are redirected to the <em>Dashboard</em>.</li>
  </ul>

  <h2 id="customers">2) Customers</h2>
  <p>Use <em>Customers</em> to add and view student/parent accounts.</p>
  <ol>
    <li>Go to <em>Customers</em> → fill <strong>Account #, Name, Address, Phone</strong>.</li>
    <li>Click <strong>Add</strong> to save. The list updates below.</li>
  </ol>

  <h2 id="items">3) Items</h2>
  <p>Use <em>Items</em> to manage products (books, stationery, services).</p>
  <ol>
    <li>Go to <em>Items</em> → fill <strong>SKU, Name, Unit Price</strong>.</li>
    <li>Click <strong>Add</strong>. The list updates below.</li>
  </ol>

  <h2 id="billing">4) Create Bill</h2>
  <p>Use <em>Create Bill</em> to make an order and auto-calculate totals.</p>
  <ol>
    <li>Enter a valid <strong>Customer ID</strong> (see Customers list).</li>
    <li>Provide <strong>Items JSON</strong> like:
      <pre>[{"itemId":1,"quantity":2},{"itemId":2,"quantity":1}]</pre>
    </li>
    <li>Click <strong>Calculate & Save</strong>. The service creates the order in a transaction and returns the computed total.</li>
  </ol>

  <h2 id="reports">5) Reports</h2>
  <p>Use <em>Reports</em> for quick summaries (sample stubs are included and can be extended to daily sales, top items, etc.).</p>

  <h2 id="troubleshoot">6) Troubleshooting</h2>
  <details>
    <summary>Can’t connect to database</summary>
    <ul>
      <li>Start XAMPP → MySQL; import <code>db/mysql-schema.sql</code>.</li>
      <li>Update <code>pahana-edu-service/src/main/resources/db.properties</code> with your MySQL username/password.</li>
    </ul>
  </details>
  <details>
    <summary>Service not reachable</summary>
    <ul>
      <li>Run the <strong>service</strong> project first; test <code>/api/health</code> returns <code>OK</code>.</li>
      <li>If you changed ports, update the web client VM option: <code>-Dservice.base=http://localhost:8080/pahana-edu-service/api/</code></li>
    </ul>
  </details>
  <details>
    <summary>GlassFish port 8080 is busy</summary>
    <ul>
      <li>Stop other servers on 8080 or change GlassFish HTTP listener port.</li>
    </ul>
  </details>

  <h2 id="about">7) About</h2>
  <ul>
    <li>Architecture: 3-tier (JSP/Servlet) → REST (JAX-RS) → MySQL (DAO/DTO).</li>
    <li>Print-friendly page; works offline after load.</li>
  </ul>

  <div class="no-print">
    <button onclick="window.print()">Print this page</button>
  </div>
</body>
</html>
