document.addEventListener("DOMContentLoaded", function () {

    const user = JSON.parse(localStorage.getItem("user"));
    if (user) {

        // Display user profile details
        document.getElementById("profileDetails").innerHTML = `
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">User Profile</h5>
                        <p class="card-text"><strong>First Name:</strong> ${user.first_name}</p>
                        <p class="card-text"><strong>Last Name:</strong> ${user.last_name}</p>
                        <p class="card-text"><strong>Email:</strong> ${user.email}</p>
                        <p class="card-text"><strong>Address:</strong> ${user.address}</p>
                        <p class="card-text"><strong>State:</strong> ${user.state}</p>
                        <p class="card-text"><strong>Postcode:</strong> ${user.postcode}</p>
                    </div>
                </div>
            `;
    } else {
        // Redirect to login page if user is not logged in
        window.location.href = "/login";
    }
});
