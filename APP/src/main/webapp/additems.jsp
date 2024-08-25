<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Shopping</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: peachpuff;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: #333;
            text-align: center;
            padding: 20px;
            background-color: #007bff;
            color: white;
            margin: 0;
        }

        .product-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            padding: 20px;
        }

        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin: 10px;
            width: 300px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .product-card h3 {
            color: #333;
            margin-bottom: 10px;
        }

        .product-card p {
            color: #777;
            margin-bottom: 20px;
        }

        .add-to-cart-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
        }

        .add-to-cart-btn:hover {
            background-color: #0056b3;
        }

        .title-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
        }
        
        .title-container a{
        	background-color: navy;
        }

        .my-cart-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            text-decoration: none;
        }

        .my-cart-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="title-container">
        <h1>Products</h1>
        <a href="displaycart.jsp" class="my-cart-btn">My Cart</a>
    </div>

    <div class="product-container">
        <div class="product-card">
            <h3>Watch</h3>
            <p>Price: 500/-</p>
            <button class="add-to-cart-btn" onclick="addToCart(1, 'Watch', 1, 500)">Add to Cart</button>
        </div>

        <div class="product-card">
            <h3>Vase</h3>
            <p>Price: 750/-</p>
            <button class="add-to-cart-btn" onclick="addToCart(2, 'Vase', 1, 750)">Add to Cart</button>
        </div>
        
        <div class="product-card">
            <h3>Coke</h3>
            <p>Price: 60/-</p>
            <button class="add-to-cart-btn" onclick="addToCart(3, 'Coke', 1, 500)">Add to Cart</button>
        </div>
        
        <div class="product-card">
            <h3>Dress</h3>
            <p>Price: 1000/-</p>
            <button class="add-to-cart-btn" onclick="addToCart(4, 'Dress', 1, 1000)">Add to Cart</button>
        </div>
        
        <div class="product-card">
            <h3>Chain</h3>
            <p>Price: 100/-</p>
            <button class="add-to-cart-btn" onclick="addToCart(5, 'Chain', 1, 100)">Add to Cart</button>
        </div>
        
        <div class="product-card">
            <h3>Bottle</h3>
            <p>Price: 300/-</p>
            <button class="add-to-cart-btn" onclick="addToCart(6, 'Bottle', 1, 300)">Add to Cart</button>
        </div>
        
        <div class="product-card">
            <h3>Bag</h3>
            <p>Price: 700/-</p>
            <button class="add-to-cart-btn" onclick="addToCart(7, 'Bag', 1, 700)">Add to Cart</button>
        </div>
        
        <div class="product-card">
            <h3>Chocolate</h3>
            <p>Price: 50/-</p>
            <button class="add-to-cart-btn" onclick="addToCart(8, 'Chocolate', 1, 50)">Add to Cart</button>
        </div>
        
        <div class="product-card">
            <h3>Cricket Bat</h3>
            <p>Price: 500/-</p>
            <button class="add-to-cart-btn" onclick="addToCart(9, 'Cricket Bat', 1, 500)">Add to Cart</button>
        </div>

    </div>

    <script>
        function addToCart(product_id, product_name, quantity, price) {
            document.forms["cartForm"]["product_id"].value = product_id;
            document.forms["cartForm"]["product_name"].value = product_name;
            document.forms["cartForm"]["quantity"].value = quantity;
            document.forms["cartForm"]["price"].value = price;
            document.forms["cartForm"].submit();
        }
    </script>
    
    <form id="cartForm" action="additems_servlet" method="post" style="display: none;">
        <input type="text" name="product_id">
        <input type="text" name="product_name">
        <input type="number" name="quantity">
        <input type="text" name="price">
    </form>
    
</body>
</html>