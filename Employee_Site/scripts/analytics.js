document.addEventListener("DOMContentLoaded", function () {
    const user = JSON.parse(localStorage.getItem("user"));
    if (!user) {
        window.location.href = "/";
        return;
    }

    // Load default analytics (top 10)
    fetchAnalytics('top_10');
});

function fetchAnalytics(endpoint) {
    fetch(`http://127.0.0.1:5000/analytics/${endpoint}`)
        .then(response => response.json())
        .then(data => {
            const analyticsTable = document.getElementById("analyticsTable");
            analyticsTable.innerHTML = '';

            if (Array.isArray(data)) {
                data.forEach(item => {
                    const row = document.createElement("tr");
                    row.innerHTML = `
                        <td>${item.foodname}</td>
                        <td>${item.category}</td>
                        <td>$${item.price.toFixed(2)}</td>
                        <td>${item.description}</td>
                    `;
                    analyticsTable.appendChild(row);
                });
            } else {
                // Handle single item response (e.g., most_popular, least_popular)
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${data.foodname}</td>
                    <td>${data.category}</td>
                    <td>$${data.price.toFixed(2)}</td>
                    <td>${data.description}</td>
                `;
                analyticsTable.appendChild(row);
            }
        })
        .catch(error => {
            console.error("Error fetching analytics data:", error);
        });
}
