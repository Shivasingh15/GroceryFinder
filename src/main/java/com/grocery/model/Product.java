package com.grocery.model;

public class Product {
    private int id;
    private String name;
    private String category;
    private double price;
    private double originalPrice;
    private String store;
    private String unit;
    private String imageUrl;
    private boolean onSale;
    private double discountPercent;

    public Product() {}

    public Product(int id, String name, String category, double price,
                   double originalPrice, String store, String unit,
                   String imageUrl, boolean onSale, double discountPercent) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.originalPrice = originalPrice;
        this.store = store;
        this.unit = unit;
        this.imageUrl = imageUrl;
        this.onSale = onSale;
        this.discountPercent = discountPercent;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public double getOriginalPrice() { return originalPrice; }
    public void setOriginalPrice(double originalPrice) { this.originalPrice = originalPrice; }
    public String getStore() { return store; }
    public void setStore(String store) { this.store = store; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public boolean isOnSale() { return onSale; }
    public void setOnSale(boolean onSale) { this.onSale = onSale; }
    public double getDiscountPercent() { return discountPercent; }
    public void setDiscountPercent(double discountPercent) { this.discountPercent = discountPercent; }
}
