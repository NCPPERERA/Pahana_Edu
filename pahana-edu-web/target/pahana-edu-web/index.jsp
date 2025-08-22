<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">
    <style>
        body {
            
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: url('images/bg2.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .overlay {
            /* Add a semi-transparent overlay for a professional look */
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.35);
            z-index: 0;
        }
        .login-container {
            position: relative;
            z-index: 1;
            text-align: center;
            width: 100%;
            max-width: 420px;
            padding: 40px 30px;
            background: rgba(255,255,255,0.98);
            border-radius: 12px;
            box-shadow: 0 10px 24px rgba(0, 0, 0, 0.15);
        }
        h2 {
            font-size: 2.2em;
            margin-bottom: 1.3em;
            color: #222;
            letter-spacing: 1px;
            font-weight: 600;
        }
        h4 {
            font-size: 1.4em;
            margin-bottom: 1.0em;
            color: #222;
            letter-spacing: 3px;
            font-weight: 900;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }
        label {
            font-size: 1.2em;
            width: 100%;
            text-align: left;
            color: #444;
            font-weight: 500;
        }
        input {
            font-size: 1.08em;
            padding: 13px 12px;
            width: 100%;
            box-sizing: border-box;
            border: 1px solid #bbb;
            border-radius: 7px;
        }
        button {
            font-size: 1.15em;
            padding: 12px;
            width: 100%;
            max-width: 220px;
            margin-top: 12px;
            background: linear-gradient(90deg, #0e6fff 0%, #2ba4ff 100%);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.3s, box-shadow 0.3s;
            box-shadow: 0 3px 12px rgba(14,111,255,0.11);
        }
        button:hover {
            background: linear-gradient(90deg, #0056b3 0%, #0e6fff 100%);
            box-shadow: 0 5px 20px rgba(14,111,255,0.15);
        }
        p.error {
            font-size: 1.07em;
            margin: 8px 0;
            color: #c0392b;
            font-weight: 500;
            min-height: 1em;
        }
        p.note {
            font-size: 0.97em;
            color: #555;
            margin-top: 17px;
        }
        @media (max-width: 500px) {
            .login-container {
                padding: 22px 10px;
                max-width: 95%;
            }
            h2 {
                font-size: 1.4em;}
            }
            label {
                font-size: 1em;
            }
            input {
                font-size: 0.97em;
            }
            button {
                font-size: 1em;
            }
        
    </style>
</head>
<body>
    <div class="overlay"></div>
    <div class="login-container">
        
        <img src="images/pahana2.jpg" alt="" width="150" height="150">
        <h4>Login</h4>
        <form method="post" action="login">
            <label>Username <input name="username" required></label>
            <label>Password <input name="password" type="password" required></label>
            <button type="submit">Login</button>
            <p class="error"><%= request.getAttribute("error") == null ? "" : request.getAttribute("error") %></p>
        </form>
        <p class="note"><small>Pahana Edu © Colombo</small></p>
    </div>
</body>
</html>