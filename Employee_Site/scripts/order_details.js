document.addEventListener("DOMContentLoaded", function() {
    const user = JSON.parse(localStorage.getItem("user"));
    if (!user) {
        window.location.href = "/";
        return;
    }

    // Load existing order details if available
    loadOrderDetails();

    document.getElementById("orderForm").addEventListener("submit", function(event) {
        event.preventDefault();

        const tableNumber = document.getElementById("tableNumber").value;
        const paymentOption = document.getElementById("paymentOption").value;

        const cart = JSON.parse(localStorage.getItem('cart')) || [];

        if (cart.length === 0) {
            alert("Your cart is empty!");
            return;
        }

        const orderData = {
            table_number: tableNumber,
            payment_option: paymentOption,
            items: cart.map(item => ({
                id: item.id,
                quantity: item.quantity,
                price: item.price
            }))
        };

        // Save order details to local storage
        saveOrderDetails(orderData);

        console.log("Submitting order:", orderData);
        // Here you would send orderData to your backend endpoint for processing
    });
});

function loadOrderDetails() {
    const orderDetails = JSON.parse(localStorage.getItem("orderDetails"));
    if (orderDetails) {
        document.getElementById("tableNumber").value = orderDetails.table_number;
        document.getElementById("paymentOption").value = orderDetails.payment_option;
    }
}

function saveOrderDetails(orderData) {
    localStorage.setItem("orderDetails", JSON.stringify(orderData));
}

function clearOrder() {
    localStorage.removeItem('cart');
    localStorage.removeItem('orderDetails');
    alert("Order cleared!");
    document.getElementById("orderForm").reset();
}
