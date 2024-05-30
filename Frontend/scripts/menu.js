document.addEventListener("DOMContentLoaded", function () {
    // Fetch and display the food items
    fetch("http://127.0.0.1:5000/food_items")
        .then(response => response.json())
        .then(data => {
            console.log("Fetched food items:", data); // Log the fetched data

            const mainDishes = document.getElementById("mainDishes");
            const sideDishes = document.getElementById("sideDishes");

            data.forEach(item => {
                const cardHTML = `
                    <div class="col-md-4 mb-4">
                        <div class="card">
                            <img class="card-img-top" src="http://127.0.0.1:5000/food_items/asset/${item.asset}" alt="${item.foodname}">
                            <div class="card-body">
                                <h5 class="card-title">${item.foodname}</h5>
                                <p class="card-text">${item.description}</p>
                                <p class="card-text"><strong>Price:</strong> $${item.price}</p>
                            </div>
                        </div>
                    </div>
                `;

                console.log("Processing item:", item); // Log each item being processed

                if (item.category === "main dish") {
                    mainDishes.innerHTML += cardHTML;
                } else if (item.category === "side dish") {
                    sideDishes.innerHTML += cardHTML;
                }
            });
        })
        .catch(error => {
            console.error("Error fetching food items:", error);
        });
});
