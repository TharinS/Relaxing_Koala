document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("loginForm").addEventListener("submit", function(event) {
        event.preventDefault();

        const email = document.getElementById("email").value;
        const password = document.getElementById("password").value;
        const loginMessage = document.getElementById("loginMessage");

        // Clear previous messages
        loginMessage.textContent = '';

        fetch("http://127.0.0.1:5000/users/employee_login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                email: email,
                password: password
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.message === "Login successful") {
                localStorage.setItem("user", JSON.stringify(data.user));
                loginMessage.textContent = data.message
                loginMessage.style.color = 'green';
                window.location.href = "/dashboard";
            } else {
                loginMessage.textContent = data.message || "Invalid email or password!";
                loginMessage.style.color = 'red';
            }
        })
        .catch(error => {
            console.error("Error during login:", error);
            loginMessage.textContent = "An error occurred during login. Please try again.";
            loginMessage.style.color = 'red';
        });
    });
});
