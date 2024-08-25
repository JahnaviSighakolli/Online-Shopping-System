package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.helper.FactoryProvider;
import com.vignan.Cart;

@WebServlet("/checkout_servlet")
public class checkout_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public checkout_servlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        try {
            // Fetch cart items
            @SuppressWarnings("unchecked")
            java.util.List<Cart> cartItems = session.createQuery("from Cart").getResultList();

            // Calculate total price
            int total = 0;
            for (Cart item : cartItems) {
                total += item.getPrice() * item.getQuantity();
            }

            // Print items and total price (can be sent to a receipt or payment gateway)
            System.out.println("Items in the cart:");
            for (Cart item : cartItems) {
                System.out.println(item.getProduct_name() + " - Quantity: " + item.getQuantity() + " - Price: " + item.getPrice());
            }
            System.out.println("Total Price: " + total);
            
            if(total==0) {
            	response.setContentType("text/html");
                PrintWriter out = response.getWriter();
            	out.println("<h1 style='text-align:center;'>No Items in your Cart</h1>");
            	out.println("<a href='additems.jsp' class='btn btn-primary'>Home</a>");
            }
            else {

            // Clear the cart (delete all items from the database)
            session.createQuery("delete from Cart").executeUpdate();

            tx.commit();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h1 style='text-align:center;'>Checkout Successful!</h1>");
            out.println("<h2 style='text-align:center;'>Thank you for shopping with us.</h2>");
            out.println("<div style='text-align:center;'>");
            out.println("<a href='additems.jsp' class='btn btn-primary'>Home</a>");
            out.println("</div>");
            }
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}