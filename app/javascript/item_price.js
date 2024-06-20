function post() {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profitElement = document.getElementById("profit");

  if (priceInput && addTaxPrice && profitElement) {
    priceInput.addEventListener("input", () => {
      const inputValue = parseFloat(priceInput.value);

      if (!isNaN(inputValue) && inputValue > 0) {
        const commissionRate = 0.1;
        const commissionFee = Math.floor(inputValue * commissionRate);
        const profit = Math.floor(inputValue - commissionFee);

        addTaxPrice.innerHTML = commissionFee;
        profitElement.innerHTML = profit;
      } else {
        addTaxPrice.innerHTML = 0;
        profitElement.innerHTML = 0;
      }
    });
  }
}

window.addEventListener('turbo:load', post);
window.addEventListener("turbo:render", post);