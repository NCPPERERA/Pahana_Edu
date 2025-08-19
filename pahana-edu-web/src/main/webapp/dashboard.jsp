<%@ page contentType="text/html;charset=UTF-8" %>
<%
  if (session.getAttribute("user") == null) {
    response.sendRedirect("index.jsp"); return;
  }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background-image: url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .dashboard-outer {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100vw;
            min-height: 100vh;
        }
        .dashboard-container {
            max-width: 900px;
            width: 100%;
            background: rgba(255,255,255,0.96);
            border-radius: 28px;
            box-shadow: 0 10px 32px rgba(0,0,0,0.14);
            padding: 48px 40px 40px 40px;
            margin: 30px auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h2 {
            color: #0e6fff;
            font-size: 3em;
            text-align: center;
            font-weight: 650;
            margin-bottom: 30px;
            letter-spacing: 2px;
        }
        nav {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 22px;
            padding: 18px;
            background: rgba(255, 255, 255, 0.98);
            border-radius: 15px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
            margin-bottom: 40px;
            width: 100%;
            max-width: 800px;
            font-size: 1.7em;
        }
        nav a {
            text-decoration: none;
            color: #0e6fff;
            font-size: 1em;
            font-weight: 600;
            padding: 10px 18px;
            border-radius: 7px;
            transition: background 0.2s, color 0.2s;
        }
        nav a:hover {
            background: #0e6fff;
            color: white;
        }
        nav .icon-btn {
            font-size: 1.3em;
            padding: 8px 12px;
        }
        nav .icon-btn:hover {
            background: #0e6fff;
            color: #fff;
        }
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 32px;
            margin-top: 15px;
            width: 100%;
            max-width: 800px;
        }
        .dashboard-card {
            background: #f4f6fc;
            border-radius: 18px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            padding: 38px 15px 30px 15px;
            text-align: center;
            transition: box-shadow 0.2s, transform 0.2s;
            font-size: 1.5em;
            font-weight: 500;
            cursor: pointer;
            min-width: 180px;
        }
        .dashboard-card:hover {
            box-shadow: 0 8px 26px rgba(14,111,255,0.15);
            transform: translateY(-3px) scale(1.03);
            background: #eaf3ff;
        }
        .dashboard-card span {
            font-size: 2em;
            display: block;
            margin-bottom: 12px;
        }
        @media (max-width: 900px) {
            .dashboard-cards {
                grid-template-columns: repeat(2, 1fr);
                gap: 18px;
            }
        }
        @media (max-width: 600px) {
            .dashboard-container {
                margin: 10px 0;
                padding: 10px 2px;
            }
            nav {
                flex-wrap: wrap;
                gap: 9px;
                font-size: 1em;
                max-width: 99vw;
            }
            h2 {
                font-size: 1.2em;
            }
            .dashboard-cards {
                grid-template-columns: 1fr;
                gap: 14px;
            }
            .dashboard-card {
                font-size: 1em;
                min-width: 90px;
                padding: 28px 8px 20px 8px;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-outer">
        <div class="dashboard-container">
            <h2>Pahana Edu Home</h2>
            <nav>
                <a href="customers">Customers</a>
                <a href="items">Items</a>
                <a href="bill">Bill</a>
                <a href="reports">Reports</a>
                <a href="help">Help</a>
                
                <a href="logout" class="icon-btn" title="Logout">↩️</a>
            </nav>
            <div class="dashboard-cards">
                <div class="dashboard-card" onclick="window.location='customers'">
                    <span>👥</span>
                    <strong>Manage Customers</strong>
                </div>
                <div class="dashboard-card" onclick="window.location='items'">
                    <span>📦</span>
                    <strong>Manage Items</strong>
                </div>
                <div class="dashboard-card" onclick="window.location='bill'">
                    <span>🧾</span>
                    <strong>Create Bill</strong>
                </div>
                <div class="dashboard-card" onclick="window.location='reports'">
                    <span>📊</span>
                    <strong>View Reports</strong>
                </div>
                <div class="dashboard-card" onclick="window.location='help'">
                    <span>❓</span>
                    <strong>Get Help</strong>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
