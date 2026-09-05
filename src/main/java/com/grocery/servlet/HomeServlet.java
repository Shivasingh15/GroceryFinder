package com.grocery.servlet;

import com.grocery.dao.ProductDAO;
import com.grocery.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet({"/", "/home"})
public class HomeServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Product> deals = productDAO.getAllProducts().stream()
            .filter(Product::isOnSale)
            .sorted((a, b) -> Double.compare(b.getDiscountPercent(), a.getDiscountPercent()))
            .limit(8)
            .collect(Collectors.toList());

        req.setAttribute("deals",      deals);
        req.setAttribute("categories", productDAO.getAllCategories());
        req.setAttribute("stores",     productDAO.getAllStores());
        req.getRequestDispatcher("/WEB-INF/index.jsp").forward(req, resp);
    }
}
