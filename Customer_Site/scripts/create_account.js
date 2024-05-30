document.getElementById("createAccountForm").addEventListener("submit", async function (event) {
    event.preventDefault();

    const firstName = document.getElementById("first_name").value;
    const lastName = document.getElementById("last_name").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const address = document.getElementById("address").value;
    const state = document.getElementById("state").value;
    const postcode = document.getElementById("postcode").value;

    // Input validation
    let isValid = true;

    // Name validation
    if (!/^[A-Za-z]+$/.test(firstName)) {
        document.getElementById("first_name").classList.add("is-invalid");
        isValid = false;
    } else {
        document.getElementById("first_name").classList.remove("is-invalid");
    }

    if (!/^[A-Za-z]+$/.test(lastName)) {
        document.getElementById("last_name").classList.add("is-invalid");
        isValid = false;
    } else {
        document.getElementById("last_name").classList.remove("is-invalid");
    }

    // Email validation
    if (!/^\S+@\S+\.\S+$/.test(email)) {
        document.getElementById("email").classList.add("is-invalid");
        isValid = false;
    } else {
        document.getElementById("email").classList.remove("is-invalid");
    }

    // Postcode validation
    if (!/^\d{4}$/.test(postcode)) {
        document.getElementById("postcode").classList.add("is-invalid");
        isValid = false;
    } else {
        document.getElementById("postcode").classList.remove("is-invalid");
    }

    if (!isValid) {
        return;
    }

    try {
        // Check if email already exists
        const emailCheckResponse = await fetch("http://127.0.0.1:5000/users/check_email", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ email })
        });

        const emailCheckData = await emailCheckResponse.json();

        if (emailCheckData.exists) {
            document.getElementById("createAccountMessage").innerText = "Email already in use. Please use a different email.";
            document.getElementById("createAccountMessage").style.color = "red";
            return;
        }

        // Create the new user
        const response = await fetch("http://127.0.0.1:5000/users", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ first_name: firstName, last_name: lastName, email, password, address, state, postcode, type: "customer" })
        });

        const data = await response.json();

        if (response.ok) {
            console.log(data.message);
            document.getElementById("createAccountMessage").innerText = "Account created successfully!";
            document.getElementById("createAccountMessage").style.color = "green";

            window.location.href = "pages/login.html";

        } else {
            console.error(data.message);
            document.getElementById("createAccountMessage").innerText = data.message;
            document.getElementById("createAccountMessage").style.color = "red";
        }
    } catch (error) {
        console.error("Error:", error);
        document.getElementById("createAccountMessage").innerText = "Network error. Please try again.";
        document.getElementById("createAccountMessage").style.color = "red";
    }
});
