package com.grocery.servlet;

import com.grocery.dao.ProductDAO;
import com.grocery.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword   = req.getParameter("q");
        String category  = req.getParameter("category");
        String store     = req.getParameter("store");
        String maxPriceStr = req.getParameter("maxPrice");
        String sortBy    = req.getParameter("sort");
        boolean onSale   = "true".equals(req.getParameter("onSale"));

        double maxPrice = 0;
        try { maxPrice = Double.parseDouble(maxPriceStr); } catch (Exception ignored) {}

        List<Product> results;
        if (keyword != null && !keyword.trim().isEmpty()) {
            results = productDAO.searchProducts(keyword);
        } else {
            results = productDAO.filterProducts(category, store, maxPrice, onSale, sortBy);
        }

        req.setAttribute("products",   results);
        req.setAttribute("categories", productDAO.getAllCategories());
        req.setAttribute("stores",     productDAO.getAllStores());
        req.setAttribute("keyword",    keyword);
        req.setAttribute("category",   category);
        req.setAttribute("store",      store);
        req.setAttribute("maxPrice",   maxPriceStr);
        req.setAttribute("sortBy",     sortBy);
        req.setAttribute("onSale",     onSale);

        req.getRequestDispatcher("/WEB-INF/results.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
