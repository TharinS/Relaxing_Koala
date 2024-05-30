document.addEventListener("DOMContentLoaded", function() {
    loadReservations();

    document.getElementById("reservationForm").addEventListener("submit", function(event) {
        event.preventDefault();
        createReservation();
    });
});

function loadReservations() {
    const reservationsList = document.getElementById("reservationsList");
    const user = JSON.parse(localStorage.getItem("user"));

    if (!user) {
        window.location.href = "/login";
        return;
    }

    fetch("http://127.0.0.1:5000/reservations")
        .then(response => response.json())
        .then(data => {
            reservationsList.innerHTML = '';

            data.forEach(reservation => {
                const reservationHTML = `
                    <tr>
                        <td>${reservation.reservation_time}</td>
                        <td>${reservation.table_number}</td>
                        <td>${reservation.number_of_guests}</td>
                        <td>${reservation.special_requests}</td>
                        <td>${reservation.created_at}</td>
                    </tr>
                `;
                reservationsList.innerHTML += reservationHTML;
            });
        })
        .catch(error => {
            console.error("Error fetching reservations:", error);
        });
}

function createReservation() {
    const user = JSON.parse(localStorage.getItem("user"));

    const reservationData = {
        user_id: user.id,
        reservation_time: document.getElementById("reservationTime").value,
        table_number: document.getElementById("tableNumber").value,
        number_of_guests: document.getElementById("numberOfGuests").value,
        special_requests: document.getElementById("specialRequests").value
    };

    fetch("http://127.0.0.1:5000/reservations", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(reservationData)
    })
    .then(response => response.json())
    .then(data => {
        console.log("Reservation created:", data);
        loadReservations();
        document.getElementById("reservationForm").reset();
    })
    .catch(error => {
        console.error("Error creating reservation:", error);
    });
}
