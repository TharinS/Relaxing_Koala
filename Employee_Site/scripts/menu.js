document.addEventListener("DOMContentLoaded", function () {
    const user = JSON.parse(localStorage.getItem("user"));
    if (!user) {
        window.location.href = "/";
        return;
    }

    fetch("http://127.0.0.1:5000/food_items")
        .then(response => response.json())
        .then(data => {
            const foodItemsTable = document.getElementById("foodItemsTable");
            foodItemsTable.innerHTML = '';

            data.forEach(item => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${item.foodname}</td>
                    <td id="quantity-${item.id}">${getItemQuantity(item.id)}</td>
                    <td>
                        <button class="btn btn-primary btn-sm" onclick="addToCart(${item.id})">Add</button>
                        <button class="btn btn-secondary btn-sm" onclick="removeFromCart(${item.id})">Remove</button>
                    </td>
                `;
                foodItemsTable.appendChild(row);
            });
        })
        .catch(error => {
            console.error("Error fetching food items:", error);
        });
});

function getCart() {
    return JSON.parse(localStorage.getItem('cart')) || [];
}

function saveCart(cart) {
    localStorage.setItem('cart', JSON.stringify(cart));
}

function addToCart(itemId) {
    fetch(`http://127.0.0.1:5000/food_items/${itemId}`)
        .then(response => response.json())
        .then(item => {
            let cart = getCart();
            const existingItem = cart.find(cartItem => cartItem.id === item.id);
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                item.quantity = 1;
                cart.push(item);
            }
            saveCart(cart);
            updateQuantityDisplay(item.id);
        })
        .catch(error => {
            console.error("Error adding item to cart:", error);
        });
}

function removeFromCart(itemId) {
    let cart = getCart();
    const itemIndex = cart.findIndex(cartItem => cartItem.id === itemId);
    if (itemIndex !== -1) {
        if (cart[itemIndex].quantity > 1) {
            cart[itemIndex].quantity -= 1;
        } else {
            cart.splice(itemIndex, 1);
        }
        saveCart(cart);
        updateQuantityDisplay(itemId);
    }
}

function updateQuantityDisplay(itemId) {
    const cart = getCart();
    const item = cart.find(cartItem => cartItem.id === itemId);
    const quantityElement = document.getElementById(`quantity-${itemId}`);
    if (item) {
        quantityElement.textContent = item.quantity;
    } else {
        quantityElement.textContent = '0';
    }
}

function getItemQuantity(itemId) {
    const cart = getCart();
    const item = cart.find(cartItem => cartItem.id === itemId);
    return item ? item.quantity : '0';
}

function printCart () {
    console.log(getCart());
}
