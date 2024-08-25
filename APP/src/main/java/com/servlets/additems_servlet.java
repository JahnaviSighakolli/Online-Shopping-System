package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.vignan.Cart;
import com.helper.FactoryProvider;

@WebServlet("/additems_servlet")
public class additems_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public additems_servlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String product_name = request.getParameter("product_name");
        String qnt = request.getParameter("quantity");
        int quantity = Integer.parseInt(qnt);
        String prc = request.getParameter("price");
        int price = Integer.parseInt(prc);

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        Cart existingCartItem = (Cart) session.createQuery("FROM Cart WHERE product_name = :product_name")
                .setParameter("product_name", product_name)
                .uniqueResult();

        if (existingCartItem == null) {
            Cart ct = new Cart();
            ct.setProduct_name(product_name);
            ct.setQuantity(quantity);
            ct.setPrice(price);
            session.save(ct);
            tx.commit();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Item added successfully');");
            out.println("location='additems.jsp';");
            out.println("</script>");
        } else {
            tx.commit();
            session.close();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Item is already in the cart');");
            out.println("location='additems.jsp';");
            out.println("</script>");
        }
    }
}
