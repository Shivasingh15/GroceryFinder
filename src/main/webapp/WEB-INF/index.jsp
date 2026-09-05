<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>GrocerySaver – Find the Lowest Grocery Prices</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<%-- Navbar --%>
<nav class="navbar">
  <a href="${pageContext.request.contextPath}/" class="navbar-brand">
    <span>🛒</span> GrocerySaver
  </a>
  <form class="navbar-search" action="${pageContext.request.contextPath}/search" method="get">
    <input type="text" name="q" placeholder="Search fruits, vegetables, dairy…"/>
    <button type="submit">Search</button>
  </form>
  <div class="navbar-links">
    <a href="${pageContext.request.contextPath}/">🏠 Home</a>
    <a href="${pageContext.request.contextPath}/search">🔍 Browse</a>
    <a href="${pageContext.request.contextPath}/cart">
      🛒 Cart
      <c:if test="${not empty sessionScope.cart}">
        <span class="cart-badge">${sessionScope.cart.size()}</span>
      </c:if>
    </a>
  </div>
</nav>

<%-- Hero --%>
<section class="hero">
  <h1>🥦 Save Money on Every Grocery Run</h1>
  <p>Compare prices across FreshMart, SaveMore &amp; BigBasket. Find the best deals today.</p>
  <form class="hero-search" action="${pageContext.request.contextPath}/search" method="get">
    <input type="text" name="q" placeholder="What are you looking for? e.g. Banana, Milk…"/>
    <button type="submit">Find Deals</button>
  </form>
  <div class="stats-bar">
    <span class="stat-chip">🏪 3 Stores Compared</span>
    <span class="stat-chip">🏷️ 35+ Products Tracked</span>
    <span class="stat-chip">💰 Save up to 33% today</span>
  </div>
</section>

<div class="container">

  <%-- Category pills --%>
  <p class="section-title">🗂️ Shop by Category</p>
  <div class="category-strip">
    <a href="${pageContext.request.contextPath}/search" class="category-pill">All</a>
    <c:forEach var="cat" items="${categories}">
      <a href="${pageContext.request.contextPath}/search?category=${cat}"
         class="category-pill" data-cat="${cat}">${cat}</a>
    </c:forEach>
  </div>

  <%-- Today's Deals --%>
  <p class="section-title">🔥 Today's Best Deals</p>
  <div class="product-grid">
    <c:forEach var="p" items="${deals}">
      <div class="product-card">
        <c:if test="${p.onSale}">
          <span class="badge-sale">-<fmt:formatNumber value="${p.discountPercent}" pattern="0"/>%</span>
        </c:if>
        <div class="product-emoji">${p.imageUrl}</div>
        <div class="product-info">
          <div class="product-name">${p.name}</div>
          <div class="product-meta">${p.unit}</div>
          <span class="store-tag">📍 ${p.store}</span>
          <div class="price-row">
            <span class="price-current">$<fmt:formatNumber value="${p.price}" pattern="0.00"/></span>
            <c:if test="${p.onSale}">
              <span class="price-original">$<fmt:formatNumber value="${p.originalPrice}" pattern="0.00"/></span>
              <span class="price-save">Save $<fmt:formatNumber value="${p.originalPrice - p.price}" pattern="0.00"/></span>
            </c:if>
          </div>
        </div>
        <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.id}"
           class="add-btn">+ Add to Cart</a>
      </div>
    </c:forEach>
  </div>

  <%-- Store comparison --%>
  <div style="margin-top:2.5rem;">
    <p class="section-title">🏪 Compare by Store</p>
    <div style="display:flex;gap:1rem;flex-wrap:wrap;">
      <c:forEach var="store" items="${stores}">
        <a href="${pageContext.request.contextPath}/search?store=${store}"
           style="flex:1;min-width:160px;background:#fff;border-radius:12px;
                  box-shadow:0 2px 8px rgba(0,0,0,.08);padding:1.2rem 1.5rem;
                  text-align:center;font-weight:700;color:#2e7d32;
                  border:2px solid #e8f5e9;transition:all .15s;"
           onmouseover="this.style.borderColor='#4caf50'"
           onmouseout="this.style.borderColor='#e8f5e9'">
          🏬 ${store}
          <div style="font-size:.8rem;font-weight:400;color:#9e9e9e;margin-top:.3rem;">Browse all deals →</div>
        </a>
      </c:forEach>
    </div>
  </div>

</div>

<footer>
  <strong>GrocerySaver</strong> &mdash; Compare grocery prices and save more every day.
  Built with Java Servlet &amp; JSP.
</footer>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
