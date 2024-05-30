document.addEventListener("DOMContentLoaded", function() {
    loadCart();
});

function loadCart() {
    const cartItems = document.getElementById("cartItems");
    const cartSummary = document.getElementById("cartSummary");
    let cart = JSON.parse(localStorage.getItem('cart')) || [];

    cartItems.innerHTML = '';
    let total = 0;

    cart.forEach(item => {
        const itemHTML = `
            <tr>
                <td>${item.foodname}</td>
                <td>$${item.price}</td>
                <td>${item.quantity}</td>
                <td>
                    <button class="btn btn-primary btn-sm" onclick="addToCart(${item.id})">Add</button>
                    <button class="btn btn-secondary btn-sm" onclick="removeFromCart(${item.id})">Remove</button>
                </td>
            </tr>
        `;

        cartItems.innerHTML += itemHTML;
        total += item.price * item.quantity;
    });
    total += 5; // Delivery charge
    cartSummary.innerHTML = `<h6>Delivery Charge: $5.0</h6><h4>Total: $${total.toFixed(2)}</h4>`;
}

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
            loadCart();
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
        loadCart();
    }
}

function placeOrder() {
    const user = JSON.parse(localStorage.getItem("user"));
    if (!user) {
        window.location.href = "/login";
        return;
    }

    const cart = getCart();
    if (cart.length === 0) {
        alert("Your cart is empty!");
        return;
    }

    const paymentMode = document.getElementById("paymentMode").value;

    const formatDateTimeForMySQL = (date) => {
        return date.toISOString().slice(0, 19).replace('T', ' ');
    };

    const orderData = {
        creator_id: user.id,
        creator_type: user.type,
        table_number: null,
        order_time: formatDateTimeForMySQL(new Date()),
        order_type: "delivery",
        delivery: {
            address: user.address,
            state: user.state,
            postcode: user.postcode,
            delivery_time: formatDateTimeForMySQL(new Date())
        },
        total_price: cart.reduce((sum, item) => sum + item.price * item.quantity, 0) + 5,
        payment_mode: paymentMode,
        items: cart.map(item => ({
            id: item.id,
            quantity: item.quantity,
            price: item.price
        }))
    };

    fetch("http://127.0.0.1:5000/process_payment", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(orderData)
    })
    .then(response => response.json())
    .then(data => {
        console.log("Order placed:", data);
        localStorage.removeItem("cart");
        alert("Order placed successfully!");
    })
    .catch(error => {
        console.error("Error placing order:", error);
    });
}
