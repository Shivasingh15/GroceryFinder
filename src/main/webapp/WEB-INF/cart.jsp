<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Your Cart – GrocerySaver</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<nav class="navbar">
  <a href="${pageContext.request.contextPath}/" class="navbar-brand">
    <span>🛒</span> GrocerySaver
  </a>
  <form class="navbar-search" action="${pageContext.request.contextPath}/search" method="get">
    <input type="text" name="q" placeholder="Search products…"/>
    <button type="submit">Search</button>
  </form>
  <div class="navbar-links">
    <a href="${pageContext.request.contextPath}/">🏠 Home</a>
    <a href="${pageContext.request.contextPath}/search">🔍 Browse</a>
    <a href="${pageContext.request.contextPath}/cart">
      🛒 Cart
      <c:if test="${not empty cartItems}">
        <span class="cart-badge">${cartItems.size()}</span>
      </c:if>
    </a>
  </div>
</nav>

<div class="container page-wrap">
  <p class="section-title" style="margin-bottom:1.5rem;">🛒 Your Shopping Cart</p>

  <c:choose>
    <c:when test="${empty cartItems}">
      <div class="empty-state">
        <div class="icon">🛒</div>
        <h3>Your cart is empty</h3>
        <p>Start adding some great deals to your cart!</p>
        <br/>
        <a href="${pageContext.request.contextPath}/search"
           style="display:inline-block;margin-top:1rem;padding:.7rem 2rem;
                  background:#2e7d32;color:#fff;border-radius:8px;font-weight:700;">
          Browse Products
        </a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="cart-layout">

        <%-- Cart items table --%>
        <div class="cart-table">
          <table>
            <thead>
              <tr>
                <th>Product</th>
                <th>Store</th>
                <th>Unit Price</th>
                <th>Qty</th>
                <th>Subtotal</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="item" items="${cartItems}">
                <tr>
                  <td>
                    <div class="cart-product">
                      <span class="cart-emoji">${item.product.imageUrl}</span>
                      <div>
                        <div class="cart-name">${item.product.name}</div>
                        <div class="cart-meta">${item.product.unit}</div>
                        <c:if test="${item.product.onSale}">
                          <span style="font-size:.75rem;color:#c62828;font-weight:600;">
                            🏷️ On Sale
                          </span>
                        </c:if>
                      </div>
                    </div>
                  </td>
                  <td><span class="store-tag">📍 ${item.product.store}</span></td>
                  <td>
                    <strong style="color:#2e7d32;">
                      $<fmt:formatNumber value="${item.product.price}" pattern="0.00"/>
                    </strong>
                    <c:if test="${item.product.onSale}">
                      <div style="font-size:.8rem;text-decoration:line-through;color:#9e9e9e;">
                        $<fmt:formatNumber value="${item.product.originalPrice}" pattern="0.00"/>
                      </div>
                    </c:if>
                  </td>
                  <td>
                    <div class="qty-control">
                      <button class="qty-btn" onclick="changeQty(${item.product.id}, -1)">−</button>
                      <input type="number" id="qty-${item.product.id}"
                             value="${item.quantity}" min="0" max="99"
                             onchange="updateCart(${item.product.id})"/>
                      <button class="qty-btn" onclick="changeQty(${item.product.id}, 1)">+</button>
                    </div>
                  </td>
                  <td>
                    <strong style="color:#212121;">
                      $<fmt:formatNumber value="${item.totalPrice}" pattern="0.00"/>
                    </strong>
                  </td>
                  <td>
                    <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.product.id}">
                      <button class="remove-btn">✕ Remove</button>
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <div style="padding:1rem 1.2rem;display:flex;justify-content:space-between;align-items:center;border-top:1px solid #eee;">
            <a href="${pageContext.request.contextPath}/search"
               style="color:#2e7d32;font-weight:600;font-size:.9rem;">← Continue Shopping</a>
            <a href="${pageContext.request.contextPath}/cart?action=clear">
              <button class="clear-btn" style="width:auto;padding:.4rem 1rem;">🗑️ Clear Cart</button>
            </a>
          </div>
        </div>

        <%-- Order summary --%>
        <div class="order-summary">
          <h3>📋 Order Summary</h3>
          <div class="summary-row">
            <span>Items (${cartItems.size()})</span>
            <span>$${total}</span>
          </div>
          <div class="summary-row">
            <span>Delivery</span>
            <span style="color:#2e7d32;font-weight:600;">FREE</span>
          </div>
          <c:if test="${savings != '0.00'}">
            <div class="summary-row savings">
              <span>🎉 You save</span>
              <span>-$${savings}</span>
            </div>
          </c:if>
          <div class="summary-row total">
            <span>Total</span>
            <span>$${total}</span>
          </div>

          <button class="checkout-btn" onclick="alert('Order placed! Thank you for shopping with GrocerySaver 🎉')">
            ✅ Place Order
          </button>
          <a href="${pageContext.request.contextPath}/search">
            <button class="continue-btn">← Continue Shopping</button>
          </a>

          <div style="margin-top:1rem;padding:.8rem;background:#e8f5e9;border-radius:8px;font-size:.82rem;color:#2e7d32;text-align:center;">
            💚 You're saving <strong>$${savings}</strong> compared to original prices!
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<footer>
  <strong>GrocerySaver</strong> &mdash; Compare grocery prices and save more every day.
</footer>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
<script>
  /* qty update triggers on blur/enter */
  document.querySelectorAll('.qty-control input').forEach(inp => {
    inp.addEventListener('keydown', e => {
      if (e.key === 'Enter') {
        const id = inp.id.replace('qty-', '');
        updateCart(id);
      }
    });
  });
</script>
</body>
</html>
