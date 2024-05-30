document.addEventListener("DOMContentLoaded", function() {
    // Load the navbar
    fetch("../pages/navbar.html")
        .then(response => response.text())
        .then(data => {
            document.getElementById("navbar").innerHTML = data;

            // Update the navbar based on the user state
            const user = JSON.parse(localStorage.getItem("user"));
            const userLinks = document.getElementById("userLinks");
            if (user) {
                userLinks.innerHTML = `
                    <li class="nav-item">
                        <a class="nav-link" href="/profile">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/cart">Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/past_orders">Past Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="logoutLink">Logout</a>
                    </li>
                `;

                document.getElementById("logoutLink").addEventListener("click", function() {
                    localStorage.removeItem("user");
                    window.location.href = "/login";
                });
            } else {
                userLinks.innerHTML = `
                    <li class="nav-item">
                        <a class="nav-link" href="/login">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/create_account">Create Account</a>
                    </li>
                `;
            }
        })
        .catch(error => {
            console.error("Error loading navbar:", error);
        });
});
