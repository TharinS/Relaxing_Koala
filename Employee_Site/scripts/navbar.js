document.addEventListener("DOMContentLoaded", function() {
    const user = JSON.parse(localStorage.getItem("user"));
    if (!user || user.type !== 'employee') {
        window.location.href = "/";
        return;
    }

    fetch("../pages/navbar.html")
        .then(response => response.text())
        .then(data => {
            document.getElementById("navbar").innerHTML = data;
            
            document.getElementById("logoutLink").addEventListener("click", function() {
                localStorage.removeItem("user");
                window.location.href = "/";
            });
        })
        .catch(error => {
            console.error("Error loading navbar:", error);
        });
});
