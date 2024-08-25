<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ONLINE SHOPPING</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: peachpuff;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        h1 {
            color: #333;
            text-align: center;
        }

        .operation-links {
            margin-top: 20px;
            text-align: center;
        }

        .operation-links a {
            text-decoration: none;
            padding: 10px 20px;
            margin: 0 10px;
            background-color: navy;
            color: #fff;
            border: 1px solid #007bff;
            border-radius: 5px;
            transition: background-color 0.3s, border-color 0.3s, color 0.3s;
        }

        .operation-links a:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            color: #fff;
        }
    </style>
</head>
<body>
    <center>
        <h1>ONLINE SHOPPING SYSTEM</h1>
        
        <div class="operation-links">
            <a href="additems.jsp">Enter</a>
        </div>
    </center>
</body>
</html>
