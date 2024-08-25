<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.vignan.Cart" %>
<%@ page import="com.helper.FactoryProvider" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Shopping Cart</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: peachpuff;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: #007bff;
            text-align: center;
            padding: 20px;
            margin-bottom: 20px;
        }

        nav {
            background-color: #007bff;
            overflow: hidden;
        }

        nav a {
            float: right;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        nav a:hover {
            background-color: #0056b3;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: #fff;
        }

        .update-quantity {
            width: 50px;
            padding: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .update-btn {
            padding: 8px 16px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .update-btn:hover {
            background-color: #0056b3;
        }

        .container {
            text-align: center;
            margin-top: 20px;
        }

        .btn-primary {
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <nav>
        <a href="additems.jsp">Home</a>
    </nav>

    <h1>Your Shopping Cart</h1>
    
    <form action="updateqnt_servlet" method="post">
        <table>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Action</th>
            </tr>
            
            <% 
                Session session2 = FactoryProvider.getFactory().openSession();
                
                try {
                    session2.beginTransaction();
                    List<Cart> shopping_cart = session2.createQuery("from Cart").getResultList();
                    
                    for (Cart ct : shopping_cart) {
            %>
                    <tr>
                        <td><%= ct.getProduct_id() %></td>
                        <td><%= ct.getProduct_name() %></td>
                        <td><input type="number" class="update-quantity" name="quantity_<%= ct.getProduct_id() %>" value="<%= ct.getQuantity() %>" min="1" required></td>
                        <td><%= ct.getPrice() %></td>
                        <td>
                        	<button type="submit" class="update-btn" name="update_<%= ct.getProduct_id() %>">Update</button>
                        </td>
                    </tr>
            <%
                    }
                    session2.getTransaction().commit();
                } finally {
                    session2.close();
                }
            %>
        </table>
    </form>

    <div class="container">
        <a href="javascript:void(0);" class="checkout-btn btn-primary" onclick="checkout()">Checkout</a>
    </div>

    <script>
        function checkout() {
            window.location.href = "checkout.jsp"; 
        }

    </script>
    
</body>
</html>