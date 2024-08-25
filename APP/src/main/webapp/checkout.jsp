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
    <title>Checkout</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: #007bff;
            text-align: center;
            padding: 20px;
            margin-bottom: 20px;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #dee2e6;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: #fff;
        }

        .checkout-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
        }

        .checkout-btn:hover {
            background-color: #0056b3;
        }

        .total-container {
            text-align: right;
            margin-top: 20px;
        }

        .total-price {
            font-size: 18px;
            margin-top: 10px;
            color: #007bff;
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
    <h1>Checkout</h1>
    
    <form action="checkout_servlet" method="post">
        <table>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
            
            <% 
                Session sessions = FactoryProvider.getFactory().openSession();
                
                try {
                    sessions.beginTransaction();
                    List<Cart> shopping_cart = sessions.createQuery("from Cart").getResultList();
                    
                    for (Cart ct : shopping_cart) {
            %>
                    <tr>
                        <td><%= ct.getProduct_id() %></td>
                        <td><%= ct.getProduct_name() %></td>
                        <td><%= ct.getQuantity() %></td>
                        <td><%= ct.getPrice() %></td>
                    </tr>
            <%
                    }
                } finally {
                    sessions.close();
                }
            %>
        </table>

        <div class="total-container">
            <span class="total-price">Total Price: <%= getTotalPrice() %></span>
            <button type="submit" class="checkout-btn">Checkout</button>
        </div>
    </form>

    <div class="container">
        <a href="index.jsp" class="btn btn-primary">Home</a>
        <a href="displaycart.jsp" class="btn btn-primary">Back to Cart</a>
    </div>
</body>
</html>

<%! 
    private int getTotalPrice() {
        int total = 0;

        Session session = FactoryProvider.getFactory().openSession();
        try {
            session.beginTransaction();
            @SuppressWarnings("unchecked")
            List<Cart> shopping_cart = session.createQuery("from Cart").getResultList();

            for (Cart ct : shopping_cart) {
                total += ct.getPrice() * ct.getQuantity();
            }
            session.getTransaction().commit();
        } finally {
            session.close();
        }

        return total;
    }
%>