// main.js
document.addEventListener("DOMContentLoaded", function() {
    // Load the navbar
    fetch("../pages/navbar.html")
        .then(response => response.text())
        .then(data => {
            document.getElementById("navbar").innerHTML = data;

            // Update the navbar based on the user state
            const user = JSON.parse(localStorage.getItem("user"));
            if (user) {
                const userLinks = document.getElementById("userLinks");
                userLinks.innerHTML = `
                    <li class="nav-item">
                        <a class="nav-link" href="/basket">Basket</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/order_list">Order List</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="logoutLink">Logout</a>
                    </li>
                `;

                document.getElementById("logoutLink").addEventListener("click", function() {
                    localStorage.removeItem("user");
                    window.location.href = "/";
                });
            }
        });
});