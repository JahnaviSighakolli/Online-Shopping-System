package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.vignan.Cart;
import com.helper.FactoryProvider;

@WebServlet("/updateqnt_servlet")
public class updateqnt_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public updateqnt_servlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();

            // Get all parameter names from the request
            Map<String, String[]> parameterMap = request.getParameterMap();
            Set<String> parameterNames = parameterMap.keySet();

            // Loop through the parameters
            for (String paramName : parameterNames) {
                // Check if the parameter starts with "update_"
                if (paramName.startsWith("update_")) {
                    // Extract the product ID from the parameter name
                    int productId = Integer.parseInt(paramName.substring("update_".length()));

                    // Get the corresponding quantity parameter
                    String quantityParam = "quantity_" + productId;
                    int newQuantity = Integer.parseInt(request.getParameter(quantityParam));

                    // Update the quantity using HQL
                    String hql = "UPDATE Cart SET quantity = :newQuantity WHERE product_id = :productId";
                    session.createQuery(hql)
                            .setParameter("newQuantity", newQuantity)
                            .setParameter("productId", productId)
                            .executeUpdate();
                }
            }

            tx.commit();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Quantity got Updated !!');");
            out.println("location='displaycart.jsp';");
            out.println("</script>");
            
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