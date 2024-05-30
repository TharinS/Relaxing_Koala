document.addEventListener("DOMContentLoaded", function () {
    const user = JSON.parse(localStorage.getItem("user"));
    if (!user) {
        window.location.href = "/";
        return;
    }

    // Display employee info
    document.getElementById("employeeInfo").innerText = `${user.first_name} ${user.last_name}`;

    // Load and display current order
    loadCurrentOrder();
});

function loadCurrentOrder() {
    const orderDetails = JSON.parse(localStorage.getItem("orderDetails"));
    const cart = JSON.parse(localStorage.getItem('cart')) || [];

    if (orderDetails) {
        document.getElementById("tableNumber").innerText = orderDetails.table_number;
        document.getElementById("paymentType").innerText = orderDetails.payment_option;
    }

    const currentOrderTable = document.getElementById("currentOrderTable");
    currentOrderTable.innerHTML = '';
    let total = 0;

    cart.forEach(item => {
        const itemHTML = `
            <tr>
                <td>${item.foodname}</td>
                <td>${item.quantity}</td>
                <td>
                    <button class="btn btn-primary btn-sm" onclick="addToCart(${item.id})">Add</button>
                    <button class="btn btn-secondary btn-sm" onclick="removeFromCart(${item.id})">Remove</button>
                </td>
            </tr>
        `;

        currentOrderTable.innerHTML += itemHTML;
        total += item.price * item.quantity;
    });

    document.getElementById("totalAmount").innerText = total.toFixed(2);
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
            loadCurrentOrder();
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
        loadCurrentOrder();
    }
}

function completeOrder() {
    const user = JSON.parse(localStorage.getItem("user"));
    if (!user) {
        window.location.href = "/";
        return;
    }

    const orderDetails = JSON.parse(localStorage.getItem("orderDetails"));
    const cart = getCart();
    if (cart.length === 0) {
        alert("Your cart is empty!");
        return;
    }

    const formatDateTimeForMySQL = (date) => {
        return date.toISOString().slice(0, 19).replace('T', ' ');
    };

    const orderData = {
        creator_id: user.id,
        creator_type: "employee",
        table_number: orderDetails.table_number,
        order_time: formatDateTimeForMySQL(new Date()),
        order_type: "dine-in",
        total_price: cart.reduce((sum, item) => sum + item.price * item.quantity, 0),
        payment_mode: orderDetails.payment_option,
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
        console.log("Order completed:", data);
        localStorage.removeItem("cart");
        window.location.href = "/receipts";
        // Reload the current order to clear the table
        loadCurrentOrder();
    })
    .catch(error => {
        console.error("Error completing order:", error);
    });
}
