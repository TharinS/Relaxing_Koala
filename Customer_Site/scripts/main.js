// Main JavaScript file for the homepage
document.addEventListener('DOMContentLoaded', () => {
    console.log('Homepage loaded');
});

document.addEventListener("DOMContentLoaded", function() {
    const user = localStorage.getItem('user');
    if (user) {
        console.log("User found in local storage:", JSON.parse(user));
    } else {
        console.log("No user found in local storage.");
    }
});
