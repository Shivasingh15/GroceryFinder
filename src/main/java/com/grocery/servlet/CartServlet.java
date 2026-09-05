package com.grocery.servlet;

import com.grocery.dao.ProductDAO;
import com.grocery.model.CartItem;
import com.grocery.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @SuppressWarnings("unchecked")
    private Map<Integer, CartItem> getCart(HttpSession session) {
        Map<Integer, CartItem> cart =
            (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = getCart(session);

        if ("add".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product p = productDAO.getProductById(id);
            if (p != null) {
                cart.merge(id, new CartItem(p, 1),
                    (existing, newItem) -> {
                        existing.setQuantity(existing.getQuantity() + 1);
                        return existing;
                    });
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if ("remove".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            cart.remove(id);
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if ("update".equals(action)) {
            int id  = Integer.parseInt(req.getParameter("id"));
            int qty = Integer.parseInt(req.getParameter("qty"));
            if (qty <= 0) {
                cart.remove(id);
            } else if (cart.containsKey(id)) {
                cart.get(id).setQuantity(qty);
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if ("clear".equals(action)) {
            cart.clear();
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        double total = cart.values().stream()
            .mapToDouble(CartItem::getTotalPrice).sum();
        double savings = cart.values().stream()
            .mapToDouble(ci -> (ci.getProduct().getOriginalPrice() - ci.getProduct().getPrice())
                                * ci.getQuantity()).sum();

        req.setAttribute("cartItems", new ArrayList<>(cart.values()));
        req.setAttribute("total",    String.format("%.2f", total));
        req.setAttribute("savings",  String.format("%.2f", savings));
        req.getRequestDispatcher("/WEB-INF/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
