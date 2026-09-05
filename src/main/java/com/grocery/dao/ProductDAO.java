package com.grocery.dao;

import com.grocery.model.Product;
import java.util.*;
import java.util.stream.Collectors;

public class ProductDAO {

    private static final List<Product> products = new ArrayList<>();

    static {
        // Fruits & Vegetables
        products.add(new Product(1,  "Banana",           "Fruits",      0.49,  0.69, "FreshMart",   "per lb",  "🍌", true,  29));
        products.add(new Product(2,  "Apple (Gala)",     "Fruits",      0.89,  1.19, "SaveMore",    "per lb",  "🍎", true,  25));
        products.add(new Product(3,  "Orange",           "Fruits",      0.75,  0.99, "FreshMart",   "per lb",  "🍊", true,  24));
        products.add(new Product(4,  "Watermelon",       "Fruits",      3.99,  5.49, "BigBasket",   "each",    "🍉", true,  27));
        products.add(new Product(5,  "Grapes",           "Fruits",      1.49,  1.99, "SaveMore",    "per lb",  "🍇", false, 0));
        products.add(new Product(6,  "Mango",            "Fruits",      0.99,  1.29, "BigBasket",   "each",    "🥭", true,  23));

        products.add(new Product(7,  "Tomato",           "Vegetables",  0.59,  0.79, "FreshMart",   "per lb",  "🍅", true,  25));
        products.add(new Product(8,  "Potato",           "Vegetables",  0.39,  0.49, "SaveMore",    "5 lb bag","🥔", false, 0));
        products.add(new Product(9,  "Onion",            "Vegetables",  0.45,  0.59, "BigBasket",   "per lb",  "🧅", true,  24));
        products.add(new Product(10, "Spinach",          "Vegetables",  1.29,  1.79, "FreshMart",   "per bag", "🥬", true,  28));
        products.add(new Product(11, "Carrot",           "Vegetables",  0.69,  0.89, "SaveMore",    "per lb",  "🥕", false, 0));
        products.add(new Product(12, "Broccoli",         "Vegetables",  0.99,  1.29, "BigBasket",   "each",    "🥦", true,  23));

        // Dairy
        products.add(new Product(13, "Whole Milk",       "Dairy",       2.49,  3.19, "SaveMore",    "1 gallon","🥛", true,  22));
        products.add(new Product(14, "Cheddar Cheese",   "Dairy",       2.99,  3.99, "BigBasket",   "8 oz",    "🧀", true,  25));
        products.add(new Product(15, "Eggs (Large)",     "Dairy",       2.79,  3.49, "FreshMart",   "12 count","🥚", true,  20));
        products.add(new Product(16, "Butter",           "Dairy",       3.49,  4.29, "SaveMore",    "1 lb",    "🧈", false, 0));
        products.add(new Product(17, "Greek Yogurt",     "Dairy",       1.29,  1.79, "BigBasket",   "6 oz",    "🍦", true,  28));

        // Meat & Seafood
        products.add(new Product(18, "Chicken Breast",   "Meat",        2.99,  4.49, "FreshMart",   "per lb",  "🍗", true,  33));
        products.add(new Product(19, "Ground Beef",      "Meat",        3.99,  5.29, "SaveMore",    "per lb",  "🥩", true,  25));
        products.add(new Product(20, "Salmon Fillet",    "Seafood",     5.99,  7.99, "BigBasket",   "per lb",  "🐟", true,  25));
        products.add(new Product(21, "Shrimp",           "Seafood",     6.99,  9.99, "FreshMart",   "per lb",  "🦐", true,  30));

        // Grains & Bakery
        products.add(new Product(22, "White Rice",       "Grains",      2.99,  3.99, "SaveMore",    "5 lb bag","🍚", true,  25));
        products.add(new Product(23, "Bread (White)",    "Bakery",      1.49,  1.99, "BigBasket",   "per loaf","🍞", true,  25));
        products.add(new Product(24, "Pasta",            "Grains",      0.99,  1.29, "FreshMart",   "16 oz",   "🍝", false, 0));
        products.add(new Product(25, "Oats",             "Grains",      2.49,  3.29, "SaveMore",    "18 oz",   "🌾", true,  24));
        products.add(new Product(26, "Whole Wheat Bread","Bakery",      2.49,  2.99, "BigBasket",   "per loaf","🥖", false, 0));

        // Beverages
        products.add(new Product(27, "Orange Juice",     "Beverages",   2.99,  3.79, "FreshMart",   "52 oz",   "🍹", true,  21));
        products.add(new Product(28, "Bottled Water",    "Beverages",   3.49,  4.99, "SaveMore",    "24-pack", "💧", true,  30));
        products.add(new Product(29, "Green Tea",        "Beverages",   2.99,  3.99, "BigBasket",   "20 bags", "🍵", false, 0));

        // Snacks
        products.add(new Product(30, "Potato Chips",     "Snacks",      1.99,  2.79, "SaveMore",    "8 oz",    "🥔", true,  29));
        products.add(new Product(31, "Peanut Butter",    "Snacks",      2.99,  3.79, "FreshMart",   "16 oz",   "🥜", true,  21));
        products.add(new Product(32, "Mixed Nuts",       "Snacks",      4.99,  6.99, "BigBasket",   "12 oz",   "🥜", true,  29));

        // Pantry
        products.add(new Product(33, "Olive Oil",        "Pantry",      4.99,  6.99, "FreshMart",   "16.9 fl oz","🫒", true,  29));
        products.add(new Product(34, "Canned Tomatoes",  "Pantry",      0.89,  1.19, "SaveMore",    "28 oz",   "🥫", false, 0));
        products.add(new Product(35, "Chicken Broth",    "Pantry",      1.49,  1.99, "BigBasket",   "32 oz",   "🍲", true,  25));
    }

    public List<Product> getAllProducts() {
        return new ArrayList<>(products);
    }

    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) return getAllProducts();
        String kw = keyword.toLowerCase().trim();
        return products.stream()
            .filter(p -> p.getName().toLowerCase().contains(kw)
                      || p.getCategory().toLowerCase().contains(kw)
                      || p.getStore().toLowerCase().contains(kw))
            .collect(Collectors.toList());
    }

    public List<Product> filterProducts(String category, String store,
                                        double maxPrice, boolean onSaleOnly,
                                        String sortBy) {
        List<Product> result = products.stream()
            .filter(p -> (category == null || category.isEmpty() || "all".equals(category)
                          || p.getCategory().equalsIgnoreCase(category)))
            .filter(p -> (store == null || store.isEmpty() || "all".equals(store)
                          || p.getStore().equalsIgnoreCase(store)))
            .filter(p -> (maxPrice <= 0 || p.getPrice() <= maxPrice))
            .filter(p -> (!onSaleOnly || p.isOnSale()))
            .collect(Collectors.toList());

        if (sortBy != null) {
            switch (sortBy) {
                case "price_asc":  result.sort(Comparator.comparingDouble(Product::getPrice)); break;
                case "price_desc": result.sort(Comparator.comparingDouble(Product::getPrice).reversed()); break;
                case "discount":   result.sort(Comparator.comparingDouble(Product::getDiscountPercent).reversed()); break;
                case "name":       result.sort(Comparator.comparing(Product::getName)); break;
                default: break;
            }
        }
        return result;
    }

    public Product getProductById(int id) {
        return products.stream().filter(p -> p.getId() == id).findFirst().orElse(null);
    }

    public List<String> getAllCategories() {
        return products.stream()
            .map(Product::getCategory)
            .distinct()
            .sorted()
            .collect(Collectors.toList());
    }

    public List<String> getAllStores() {
        return products.stream()
            .map(Product::getStore)
            .distinct()
            .sorted()
            .collect(Collectors.toList());
    }
}
