<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Help & User Guide - Pahana Edu</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="https://cdn.jsdelivr.net/npm/remixicon/fonts/remixicon.css" rel="stylesheet">
  <style>
    body {
      font-family: "Segoe UI", Roboto, sans-serif;
      margin: 0;
      padding: 0;
      background: #f9fafc;
      color: #333;
      line-height: 1.6;
    }

    header {
      background: linear-gradient(135deg, #4f46e5, #6366f1);
      color: white;
      padding: 1.5rem 2rem;
      text-align: center;
      box-shadow: 0 2px 8px rgba(0,0,0,.15);
    }
    header h1 {
      margin: 0;
      font-size: 2rem;
    }
    header p {
      margin: .5rem 0 0;
      font-size: 1rem;
      opacity: 0.9;
    }

    nav {
      background: #fff;
      padding: .75rem 2rem;
      display: flex;
      gap: 1rem;
      border-bottom: 1px solid #e5e7eb;
      position: sticky;
      top: 0;
      z-index: 100;
    }
    nav a {
      text-decoration: none;
      color: #4f46e5;
      font-weight: 500;
    }
    nav a:hover {
      text-decoration: underline;
    }

    main {
      max-width: 900px;
      margin: 2rem auto;
      padding: 0 1rem;
    }

    section {
      background: #fff;
      padding: 1.5rem;
      margin-bottom: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 6px rgba(0,0,0,.08);
    }
    section h2 {
      display: flex;
      align-items: center;
      gap: .5rem;
      color: #4f46e5;
      margin-top: 0;
    }
    section h2 i {
      font-size: 1.4rem;
    }

    .note {
      background: #eef2ff;
      border-left: 4px solid #4f46e5;
      padding: .75rem 1rem;
      border-radius: 6px;
      margin: 1rem 0;
    }

    pre {
      background: #f3f4f6;
      padding: .75rem;
      border-radius: 8px;
      overflow-x: auto;
    }

    details {
      background: #f9fafc;
      border: 1px solid #e5e7eb;
      border-radius: 8px;
      padding: .75rem 1rem;
      margin: .75rem 0;
    }
    details summary {
      cursor: pointer;
      font-weight: 600;
      color: #374151;
    }

    button {
      background: #4f46e5;
      color: white;
      padding: .6rem 1.2rem;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: .95rem;
      margin-top: 1rem;
    }
    button:hover {
      background: #4338ca;
    }

    footer {
      text-align: center;
      padding: 1rem;
      background: #f3f4f6;
      color: #555;
      font-size: .9rem;
      margin-top: 2rem;
    }

    @media print {
      nav, button, footer { display: none !important; }
      body { background: white; }
      section { box-shadow: none; border: none; }
    }
  </style>
</head>
<body>

  <header>
    <h1>Pahana Edu – Help & User Guide</h1>
    <p>Your step-by-step guide to using the system effectively</p>
  </header>

  <nav>
    <a href="dashboard.jsp"><i class="ri-home-4-line"></i> Dashboard</a>
    <a href="customers"><i class="ri-user-3-line"></i> Customers</a>
    <a href="items"><i class="ri-archive-line"></i> Items</a>
    <a href="bill"><i class="ri-file-list-line"></i> Create Bill</a>
    <a href="reports"><i class="ri-bar-chart-2-line"></i> Reports</a>
    <a href="logout"><i class="ri-logout-box-line"></i> Logout</a>
  </nav>

  <main>
    <div class="note">
      <strong>Tip:</strong> Use <kbd>Ctrl</kbd> + <kbd>P</kbd> to print this guide. Print view is optimized for clean output.
    </div>

    <section id="login">
      <h2><i class="ri-login-circle-line"></i> 1) Login</h2>
      <ul>
        <li>Open the application to see the login screen.</li>
        <li>Default demo credentials: <strong>admin / admin123</strong>.</li>
        <li>On success you will be redirected to the <em>Dashboard</em>.</li>
      </ul>
    </section>

    <section id="customers">
      <h2><i class="ri-user-add-line"></i> 2) Customers</h2>
      <p>Add and manage student/parent accounts.</p>
      <ol>
        <li>Go to <em>Customers</em> → fill <strong>Account #, Name, Address, Phone</strong>.</li>
        <li>Click <strong>Add</strong>. The list updates below.</li>
      </ol>
    </section>

    <section id="items">
      <h2><i class="ri-book-line"></i> 3) Items</h2>
      <p>Manage books, stationery, and services.</p>
      <ol>
        <li>Go to <em>Items</em> → fill <strong>SKU, Name, Unit Price</strong>.</li>
        <li>Click <strong>Add</strong>. The list updates below.</li>
      </ol>
    </section>

    <section id="billing">
      <h2><i class="ri-receipt-line"></i> 4) Create Bill</h2>
      <p>Make an order with automatic total calculation.</p>
      <ol>
        <li>Enter a valid <strong>Customer ID</strong>.</li>
        <li>Provide <strong>Items JSON</strong>:
          <pre>[{"itemId":1,"quantity":2},{"itemId":2,"quantity":1}]</pre>
        </li>
        <li>Click <strong>Calculate & Save</strong>. The system creates the order transaction and returns the computed total.</li>
      </ol>
    </section>

    <section id="reports">
      <h2><i class="ri-bar-chart-line"></i> 5) Reports</h2>
      <p>Access sales summaries, top items, and daily reports.</p>
    </section>

    <section id="troubleshoot">
      <h2><i class="ri-tools-line"></i> 6) Troubleshooting</h2>
      <details>
        <summary>Can’t connect to database</summary>
        <ul>
          <li>Start XAMPP → MySQL; import <code>db/mysql-schema.sql</code>.</li>
          <li>Update <code>db.properties</code> with MySQL credentials.</li>
        </ul>
      </details>
      <details>
        <summary>Service not reachable</summary>
        <ul>
          <li>Run the <strong>service</strong> project first; test <code>/api/health</code>.</li>
          <li>If ports changed, update VM option: <code>-Dservice.base=http://localhost:8080/pahana-edu-service/api/</code></li>
        </ul>
      </details>
      <details>
        <summary>GlassFish port 8080 is busy</summary>
        <ul>
          <li>Stop other servers on port 8080 or change GlassFish HTTP port.</li>
        </ul>
      </details>
    </section>

    <section id="about">
      <h2><i class="ri-information-line"></i> 7) About</h2>
      <ul>
        <li>Architecture: 3-tier (JSP/Servlet) → REST (JAX-RS) → MySQL (DAO/DTO).</li>
        <li>Print-friendly, works offline after load.</li>
      </ul>
    </section>

    <button onclick="window.print()"><i class="ri-printer-line"></i> Print this Guide</button>
  </main>

  <footer>
    &copy; 2025 Pahana Edu. All Rights Reserved.
  </footer>

</body>
</html>
