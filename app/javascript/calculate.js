function calc() {
    const price = document.getElementById("item-price");
    price.addEventListener("keyup",() => {
        priceIndex(price);
    });
    priceIndex(price);
};

const priceIndex = (price) => {
    const priceValue = price.value;  
    const tax = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    let tax_calc = priceValue * 0.1;     
    let profit_calc = priceValue - tax_calc;     

    tax.innerHTML = Math.floor(tax_calc)       
    profit.innerHTML = Math.floor(profit_calc)    
}



window.addEventListener("turbo:load",calc);  
window.addEventListener("turbo:render", calc); 
