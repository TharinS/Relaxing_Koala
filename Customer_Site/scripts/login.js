document.getElementById("loginForm").addEventListener("submit", async function (event) {
    event.preventDefault();

    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    try {
        const response = await fetch("http://127.0.0.1:5000/users/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ email, password })
        });

        const data = await response.json();

        if (response.ok) {
            console.log(data.message);
            console.log(data.user);  // Log the user details
            // Display success message
            document.getElementById("loginMessage").innerText = data.message;
            document.getElementById("loginMessage").style.color = "green";
            // Save user details in local storage
            localStorage.setItem('user', JSON.stringify(data.user));
            // Redirect to home page or dashboard after successful login
            window.location.href = "/index.html";
        } else {
            console.error(data.message);
            // Display error message
            document.getElementById("loginMessage").innerText = data.message;
            document.getElementById("loginMessage").style.color = "red";
        }
    } catch (error) {
        console.error("Error:", error);
        // Display network error message
        document.getElementById("loginMessage").innerText = "Network error. Please try again.";
        document.getElementById("loginMessage").style.color = "red";
    }
});
