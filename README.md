# 🛒 GrocerySaver – Low Cost Grocery Finder

A full-stack Java web app that compares grocery prices across multiple stores, built with **Java Servlets**, **JSP (JSTL)**, **CSS**, and **JavaScript**.

---

## 📁 Project Structure

```
GroceryFinder/
├── pom.xml                              ← Maven build file
└── src/main/
    ├── java/com/grocery/
    │   ├── model/
    │   │   ├── Product.java             ← Product data model
    │   │   └── CartItem.java            ← Shopping cart item
    │   ├── dao/
    │   │   └── ProductDAO.java          ← In-memory product database (35 items)
    │   └── servlet/
    │       ├── HomeServlet.java         ← GET /  → today's deals
    │       ├── SearchServlet.java       ← GET /search  → filter & search
    │       └── CartServlet.java         ← GET /cart    → cart CRUD
    └── webapp/
        ├── css/
        │   └── style.css               ← Full responsive stylesheet
        ├── js/
        │   └── app.js                  ← UI interactions (price slider, qty, toast)
        └── WEB-INF/
            ├── web.xml                 ← Deployment descriptor
            ├── index.jsp               ← Home page (deals + categories)
            ├── results.jsp             ← Search / browse results
            └── cart.jsp                ← Shopping cart page
```

---

## ✨ Features

| Feature | Details |
|---|---|
| 🏠 Home page | Hero banner, category pills, top 8 sale deals |
| 🔍 Search | Keyword search across name, category, store |
| 🎛️ Filters | Category, store, max price slider, on-sale toggle |
| 📊 Sort | Price (asc/desc), best discount, name A-Z |
| 🛒 Cart | Add, update quantity, remove, clear, session-based |
| 💰 Savings | Shows original vs sale price, total savings in cart |
| 📱 Responsive | Works on mobile, tablet, desktop |
| 🏪 Stores | FreshMart, SaveMore, BigBasket |

---

## 🚀 Setup & Run

### Prerequisites
- Java 11+
- Maven 3.6+
- Apache Tomcat 10+ (Jakarta EE 9)

### Option 1 – Deploy to Tomcat

```bash
# 1. Build the WAR
cd GroceryFinder
mvn clean package

# 2. Copy to Tomcat webapps
cp target/GroceryFinder.war /path/to/tomcat/webapps/

# 3. Start Tomcat
/path/to/tomcat/bin/startup.sh

# 4. Open in browser
http://localhost:8080/GroceryFinder/
```

### Option 2 – IDE (IntelliJ IDEA / Eclipse)

1. Import as Maven project
2. Add Tomcat 10 server configuration
3. Deploy the `GroceryFinder` artifact
4. Run → visit `http://localhost:8080/GroceryFinder/`

### Option 3 – Embedded Tomcat (quick test, Java 8/Tomcat 7 mode)

```bash
mvn tomcat7:run
# Visit: http://localhost:8080/grocery/
```

---

## 🗄️ Data

The app uses an in-memory `ProductDAO` with **35 pre-loaded products** across 10 categories:
- Fruits, Vegetables, Dairy, Meat, Seafood
- Grains, Bakery, Beverages, Snacks, Pantry

Each product has: name, category, price, original price, store, unit, sale status, and discount %.

### To add a database (MySQL example):
Replace `ProductDAO.java` with JDBC queries:

```java
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/grocery", "user", "pass");
PreparedStatement ps = conn.prepareStatement(
    "SELECT * FROM products WHERE category = ?");
```

---

## 📸 Pages

| URL | Page |
|---|---|
| `/GroceryFinder/` | Home – deals & categories |
| `/GroceryFinder/search` | Browse all / search / filter |
| `/GroceryFinder/search?q=milk` | Search results for "milk" |
| `/GroceryFinder/search?category=Fruits` | Filter by category |
| `/GroceryFinder/search?onSale=true&sort=discount` | Best deals sorted |
| `/GroceryFinder/cart` | Shopping cart |
| `/GroceryFinder/cart?action=add&id=1` | Add product to cart |

---

## 🛠️ Tech Stack

- **Backend**: Java 11, Jakarta Servlet 5.0, JSP 3.0, JSTL 2.0
- **Frontend**: HTML5, CSS3 (custom design system), Vanilla JavaScript
- **Server**: Apache Tomcat 10+
- **Build**: Maven 3.6+
- **Data**: In-memory (swap with JDBC + MySQL/PostgreSQL for production)
