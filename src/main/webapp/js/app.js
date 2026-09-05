/* grocery-finder.js */

/* ---- Price range slider ---- */
const priceSlider = document.getElementById('priceSlider');
const priceDisplay = document.getElementById('priceDisplay');
if (priceSlider && priceDisplay) {
  priceSlider.addEventListener('input', () => {
    const v = parseFloat(priceSlider.value);
    priceDisplay.textContent = v >= parseFloat(priceSlider.max)
      ? 'Any price' : '$' + v.toFixed(2);
    const hiddenInput = document.getElementById('maxPriceInput');
    if (hiddenInput) hiddenInput.value = v >= parseFloat(priceSlider.max) ? '' : v;
  });
}

/* ---- Cart quantity helpers ---- */
function changeQty(id, delta) {
  const input = document.getElementById('qty-' + id);
  if (!input) return;
  let v = parseInt(input.value) + delta;
  if (v < 0) v = 0;
  input.value = v;
}

function updateCart(id) {
  const input = document.getElementById('qty-' + id);
  if (!input) return;
  const qty = parseInt(input.value);
  window.location.href = 'cart?action=update&id=' + id + '&qty=' + qty;
}

/* ---- Add to cart toast ---- */
function addToCart(id, name) {
  fetch('cart?action=add&id=' + id, { method: 'GET' })
    .catch(() => {});
  showToast('🛒 ' + name + ' added to cart!');
  updateCartBadge();
}

function showToast(msg) {
  let toast = document.getElementById('toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'toast';
    toast.className = 'toast';
    document.body.appendChild(toast);
  }
  toast.textContent = msg;
  toast.classList.add('show');
  clearTimeout(toast._timer);
  toast._timer = setTimeout(() => toast.classList.remove('show'), 2800);
}

function updateCartBadge() {
  const badge = document.querySelector('.cart-badge');
  if (badge) {
    const n = parseInt(badge.textContent) || 0;
    badge.textContent = n + 1;
  }
}

/* ---- Category pill filter (home page) ---- */
document.querySelectorAll('.category-pill[data-cat]').forEach(pill => {
  pill.addEventListener('click', () => {
    const cat = pill.dataset.cat;
    window.location.href = 'search?category=' + encodeURIComponent(cat);
  });
});

/* ---- Sort dropdown auto-submit ---- */
const sortSelect = document.getElementById('sortSelect');
if (sortSelect) {
  sortSelect.addEventListener('change', () => {
    const form = sortSelect.closest('form') || document.getElementById('filterForm');
    if (form) form.submit();
  });
}

/* ---- Mobile filter toggle ---- */
const filterToggle = document.getElementById('filterToggle');
const filterPanel  = document.getElementById('filterPanel');
if (filterToggle && filterPanel) {
  filterToggle.addEventListener('click', () => {
    filterPanel.style.display = filterPanel.style.display === 'none' ? 'block' : 'none';
  });
}
