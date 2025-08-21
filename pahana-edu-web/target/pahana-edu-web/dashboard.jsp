<%@ page contentType="text/html;charset=UTF-8" %>
<%
  if (session.getAttribute("user") == null) {
    response.sendRedirect("index.jsp"); return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Dashboard - Pahana Edu</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="https://cdn.jsdelivr.net/npm/remixicon/fonts/remixicon.css" rel="stylesheet">
  <style>
    body {
      font-family: "Segoe UI", Roboto, sans-serif;
      margin: 0;
      min-height: 100vh;
      background: url('https://images.unsplash.com/photo-1512820790803-83ca734da794?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80') no-repeat center center fixed;
      background-size: cover;
      color: #333;
    }

    /* Softer overlay so background books show more */
    .overlay {
      background: rgba(255, 255, 255, 0.82);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    header {
      background: rgba(79,70,229,0.92);
      background: linear-gradient(135deg, rgba(79,70,229,0.85), rgba(99,102,241,0.85));
      color: white;
      padding: 2rem 2rem 1.5rem 2rem;
      text-align: center;
      box-shadow: 0 2px 8px rgba(0,0,0,.15);
    }
    header h1 {
      margin: 0;
      font-size: 2.2rem;
    }
    header p {
      margin-top: .5rem;
      font-size: 1rem;
      opacity: 0.95;
    }

    nav {
      background: rgba(255,255,255,0.95);
      padding: .75rem 2rem;
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 1.2rem;
      border-bottom: 1px solid #e5e7eb;
      position: sticky;
      top: 0;
      z-index: 100;
      backdrop-filter: blur(4px);
    }
    nav a {
      text-decoration: none;
      color: #4f46e5;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: .4rem;
      padding: .4rem .8rem;
      border-radius: 6px;
      transition: background .2s;
    }
    nav a:hover {
      background: #eef2ff;
    }

    main {
      flex: 1;
      max-width: 1000px;
      margin: 2rem auto;
      padding: 0 1rem;
    }

    /* Fixed 2 rows for cards */
    .cards {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      grid-auto-rows: 1fr;
      gap: 1.5rem;
    }

    .card {
      background: rgba(255,255,255,0.95);
      border-radius: 16px;
      padding: 2rem 1.5rem;
      text-align: center;
      box-shadow: 0 4px 12px rgba(0,0,0,.08);
      transition: transform .2s, box-shadow .2s;
      cursor: pointer;
    }
    .card:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 20px rgba(14,111,255,0.18);
    }
    .card i {
      font-size: 2.2rem;
      color: #4f46e5;
      margin-bottom: 1rem;
      display: block;
    }
    .card strong {
      display: block;
      font-size: 1.2rem;
      font-weight: 600;
      color: #374151;
    }

    footer {
      text-align: center;
      padding: 1rem;
      background: rgba(255,255,255,0.88);
      color: #555;
      font-size: .9rem;
    }

    /* Mobile adjustments */
    @media (max-width: 768px) {
      .cards {
        grid-template-columns: repeat(2, 1fr);
      }
    }
    @media (max-width: 480px) {
      .cards {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
  <div class="overlay">
    <header>
      <h1>Pahana Edu – Dashboard</h1>
      <p>Quick access to manage your bookstore operations</p>
    </header>

    <nav>
      <a href="customers"><i class="ri-user-3-line"></i> Customers</a>
      <a href="items"><i class="ri-archive-line"></i> Items</a>
      <a href="bill"><i class="ri-file-list-line"></i> Bill</a>
      <a href="reports"><i class="ri-bar-chart-2-line"></i> Reports</a>
      <a href="help"><i class="ri-question-line"></i> Help</a>
      <a href="logout" title="Logout"><i class="ri-logout-box-r-line"></i> Logout</a>
    </nav>

    <main>
      <div class="cards">
        <div class="card" onclick="window.location='customers'">
          <i class="ri-user-settings-line"></i>
          <strong>Manage Customers</strong>
        </div>
        <div class="card" onclick="window.location='items'">
          <i class="ri-book-2-line"></i>
          <strong>Manage Items</strong>
        </div>
        <div class="card" onclick="window.location='bill'">
          <i class="ri-receipt-line"></i>
          <strong>Create Bill</strong>
        </div>
        <div class="card" onclick="window.location='reports'">
          <i class="ri-bar-chart-line"></i>
          <strong>View Reports</strong>
        </div>
        <div class="card" onclick="window.location='help'">
          <i class="ri-question-answer-line"></i>
          <strong>Get Help</strong>
        </div>
        <div class="card" onclick="window.location='logout'">
          <i class="ri-logout-box-r-line"></i>
          <strong>Logout</strong>
        </div>
      </div>
    </main>

    <footer>
      &copy; 2025 Pahana Edu. All Rights Reserved.
    </footer>
  </div>
</body>
</html>
