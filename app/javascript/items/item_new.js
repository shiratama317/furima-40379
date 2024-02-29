function newItem (){
  const itemPrice = document.getElementById("item-price")
  const profit = document.getElementById("profit")
  itemPrice.addEventListener("input", () => {
    const addTaxPrice = document.getElementById("add-tax-price")
    addTaxPrice.innerHTML = Math.floor(itemPrice.value*0.1)
    profit.innerHTML = Math.floor(itemPrice.value - addTaxPrice.innerHTML)
  })
}

window.addEventListener('turbo:load', newItem)