<%@ page contentType="text/html;charset=UTF-8" %>
<%
  if (session.getAttribute("user") == null) { response.sendRedirect("index.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Reports</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">
  <style>
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      font-size: 1.5rem;
      background: #f5f7fa;
    }
    .container {
      max-width: 700px;
      margin: 3em auto 0 auto;
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 4px 32px #e0e0e0;
      padding: 2.5em 3em 2em 3em;
      text-align: center;
    }
    h2 {
      font-size: 3rem;
      margin-bottom: 0.75em;
      color: #3246a8;
    }
    nav {
      margin-bottom: 2em;
      font-size: 1.25rem;
    }
    ul {
      list-style: none;
      padding: 0;
      margin-bottom: 2em;
      text-align: center;
    }
    ul li {
      display: inline-block;
      margin: 0 1.5em;
    }
    ul li a {
      font-size: 1.3rem;
      padding: 0.6em 1.2em;
      border-radius: 6px;
      background: #3246a8;
      color: #fff;
      text-decoration: none;
      transition: background 0.2s;
      box-shadow: 0 2px 6px #e0e0e0;
    }
    ul li a:hover {
      background: #4668e2;
    }
    hr {
      margin: 2.5em 0;
    }
    .report-output {
      font-size: 1.25rem;
      padding: 1.5em 1em;
      border-radius: 8px;
      background: #f0f4ff;
      min-height: 80px;
      text-align: left;
      margin-top: 0;
      word-break: break-all;
      box-shadow: 0 2px 8px #e0e0e0;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Reports</h2>
  <nav><a href="dashboard.jsp" style="font-size:1.25rem;">Back</a></nav>
  <ul>
    <li><a href="reports?type=sales-today">Sales</a></li>
   <%-- <li><a href="reports?type=top-items">Top Items</a></li> --%>
  </ul>
  <hr/>
  <div class="report-output">
  <jsp:include page="report_output.jsp"/>
</div>
</div>
</body>
</html>