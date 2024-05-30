document.addEventListener("DOMContentLoaded", function() {
    const user = JSON.parse(localStorage.getItem("user"));

    if (!user) {
        window.location.href = "/login";
        return;
    }

    fetch(`http://127.0.0.1:5000/financial_document/user_receipts/${user.id}`)
        .then(response => response.json())
        .then(data => {
            const ordersContainer = document.getElementById("ordersContainer");
            if (data.length === 0) {
                ordersContainer.innerHTML = "<p>No past orders found.</p>";
            } else {
                data.forEach(order => {
                    const orderCard = document.createElement("div");
                    orderCard.className = "card mb-3";
                    orderCard.innerHTML = `
                        <div class="card-body">
                            <p class="card-text">Order Time: ${new Date(order.order_time).toLocaleString()}</p>
                            <p class="card-text">Order Type: ${order.order_type}</p>
                            <p class="card-text">Delivery Address: ${order.delivery_address || 'N/A'}</p>
                            <p class="card-text">Delivery Charge: $${order.delivery_charge || 0.00}</p>
                            <h6>Items:</h6>
                            <ul>
                                ${order.items.map(item => `
                                    <li>${item.name} - $${item.price} x ${item.quantity} = $${item.total}</li>
                                `).join('')}
                            </ul>
                            <p class="card-text">Total Price: $${order.total_price}</p>
                        </div>
                    `;
                    ordersContainer.appendChild(orderCard);
                });
            }
        })
        .catch(error => {
            console.error("Error fetching past orders:", error);
            document.getElementById("ordersContainer").innerHTML = "<p>Error fetching past orders. Please try again later.</p>";
        });
});
