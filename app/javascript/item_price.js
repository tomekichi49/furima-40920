
const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;
  console.log(inputValue);
})

const commissionFee = document.getElementById("add-tax-price");
console.log(commissionFee);

const totalProfit = document.getElementById("profit");
console.log(totalProfit);