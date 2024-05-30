document.addEventListener("DOMContentLoaded", function () {
    const user = JSON.parse(localStorage.getItem("user"));
    if (!user) {
        window.location.href = "/index.html";
        return;
    }

    fetch(`http://127.0.0.1:5000/financial_document/last_receipt/${user.id}`)
        .then(response => response.json())
        .then(data => {
            if (data.message) {
                document.getElementById("receiptDetails").innerHTML = `<p class="text-danger">${data.message}</p>`;
            } else {
                const receiptHTML = `
                    <div class="card">
                        <div class="card-body text-dark">
                            <h5 class="card-title">Receipt ID: ${data.order_id}</h5>
                            <p class="card-text"><strong>Order ID:</strong> ${data.order_id}</p>
                            <p class="card-text"><strong>Order Type:</strong> ${data.order_type}</p>
                            <p class="card-text"><strong>Order Time:</strong> ${new Date(data.order_time).toLocaleString()}</p>
                            <p class="card-text"><strong>Total Price:</strong> $${data.total_price.toFixed(2)}</p>
                            ${data.delivery_address ? `<p class="card-text"><strong>Delivery Address:</strong> ${data.delivery_address}</p>` : `<p class="card-text"><strong>Table Number:</strong> ${data.table_number}</p>`}
                            <h5>Items:</h5>
                            <ul class="list-group">
                                ${data.items.map(item => `
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        ${item.name} - ${item.quantity} x $${item.price.toFixed(2)}
                                        <span class="badge badge-primary badge-pill">$${item.total.toFixed(2)}</span>
                                    </li>
                                `).join('')}
                            </ul>
                        </div>
                    </div>
                `;
                document.getElementById("receiptDetails").innerHTML = receiptHTML;
            }
        })
        .catch(error => {
            console.error("Error fetching receipt:", error);
            document.getElementById("receiptDetails").innerHTML = `<p class="text-danger">Error fetching receipt.</p>`;
        });
});
