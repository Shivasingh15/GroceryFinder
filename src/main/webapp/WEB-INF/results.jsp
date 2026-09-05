<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Browse Products – GrocerySaver</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<nav class="navbar">
  <a href="${pageContext.request.contextPath}/" class="navbar-brand">
    <span>🛒</span> GrocerySaver
  </a>
  <form class="navbar-search" action="${pageContext.request.contextPath}/search" method="get">
    <input type="text" name="q" value="${keyword}" placeholder="Search products…"/>
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

<div class="container page-wrap">
  <div class="search-layout">

    <%-- Filter sidebar --%>
    <aside class="filter-panel" id="filterPanel">
      <h3>🎛️ Filters</h3>
      <form id="filterForm" action="${pageContext.request.contextPath}/search" method="get">
        <input type="hidden" name="q" value="${keyword}"/>
        <input type="hidden" id="maxPriceInput" name="maxPrice" value="${maxPrice}"/>

        <div class="filter-group">
          <label>Category</label>
          <select name="category">
            <option value="all">All Categories</option>
            <c:forEach var="cat" items="${categories}">
              <option value="${cat}" ${category == cat ? 'selected' : ''}>${cat}</option>
            </c:forEach>
          </select>
        </div>

        <div class="filter-group">
          <label>Store</label>
          <select name="store">
            <option value="all">All Stores</option>
            <c:forEach var="s" items="${stores}">
              <option value="${s}" ${store == s ? 'selected' : ''}>${s}</option>
            </c:forEach>
          </select>
        </div>

        <div class="filter-group">
          <label>Max Price</label>
          <input type="range" id="priceSlider" min="0" max="20" step="0.5"
                 value="${not empty maxPrice ? maxPrice : 20}"/>
          <div class="price-display" id="priceDisplay">
            ${not empty maxPrice ? '$'.concat(maxPrice) : 'Any price'}
          </div>
        </div>

        <div class="filter-group">
          <label class="checkbox-label">
            <input type="checkbox" name="onSale" value="true" ${onSale ? 'checked' : ''}/>
            On Sale Only
          </label>
        </div>

        <div class="filter-group">
          <label>Sort By</label>
          <select name="sort" id="sortSelect">
            <option value="">Default</option>
            <option value="price_asc"  ${sortBy == 'price_asc'  ? 'selected' : ''}>Price: Low to High</option>
            <option value="price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
            <option value="discount"   ${sortBy == 'discount'   ? 'selected' : ''}>Best Discount</option>
            <option value="name"       ${sortBy == 'name'       ? 'selected' : ''}>Name (A-Z)</option>
          </select>
        </div>

        <button type="submit" class="filter-btn">Apply Filters</button>
        <a href="${pageContext.request.contextPath}/search">
          <button type="button" class="clear-btn">✕ Clear All</button>
        </a>
      </form>
    </aside>

    <%-- Results area --%>
    <main>
      <div class="sort-bar">
        <span class="result-count">
          <c:choose>
            <c:when test="${not empty keyword}">
              Results for "<strong>${keyword}</strong>" —
            </c:when>
            <c:when test="${not empty category && category != 'all'}">
              Category: <strong>${category}</strong> —
            </c:when>
          </c:choose>
          <strong>${products.size()}</strong> product(s) found
        </span>
      </div>

      <c:choose>
        <c:when test="${empty products}">
          <div class="empty-state">
            <div class="icon">🔍</div>
            <h3>No products found</h3>
            <p>Try adjusting your filters or search for something else.</p>
            <br/>
            <a href="${pageContext.request.contextPath}/search"
               style="color:#2e7d32;font-weight:700;">← Browse all products</a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="product-grid">
            <c:forEach var="p" items="${products}">
              <div class="product-card">
                <c:if test="${p.onSale}">
                  <span class="badge-sale">
                    -<fmt:formatNumber value="${p.discountPercent}" pattern="0"/>%
                  </span>
                </c:if>
                <div class="product-emoji">${p.imageUrl}</div>
                <div class="product-info">
                  <div class="product-name">${p.name}</div>
                  <div class="product-meta">${p.category} · ${p.unit}</div>
                  <span class="store-tag">📍 ${p.store}</span>
                  <div class="price-row">
                    <span class="price-current">
                      $<fmt:formatNumber value="${p.price}" pattern="0.00"/>
                    </span>
                    <c:if test="${p.onSale}">
                      <span class="price-original">
                        $<fmt:formatNumber value="${p.originalPrice}" pattern="0.00"/>
                      </span>
                      <span class="price-save">
                        Save $<fmt:formatNumber value="${p.originalPrice - p.price}" pattern="0.00"/>
                      </span>
                    </c:if>
                  </div>
                </div>
                <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.id}"
                   class="add-btn">+ Add to Cart</a>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </main>
  </div>
</div>

<footer>
  <strong>GrocerySaver</strong> &mdash; Compare grocery prices and save more every day.
</footer>

<div class="toast" id="toast"></div>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
