document.addEventListener("DOMContentLoaded", function () {
    // Fetch and display the chef's recommendation
    fetch("http://127.0.0.1:5000/analytics/random_recommendation")
        .then(response => response.json())
        .then(data => {
            const recommendation = data;
            const chefsRecommendation = document.getElementById("chefsRecommendation");

            const cardHTML = `
                <div class="card mb-4">
                    <div class="row no-gutters">
                        <div class="col-md-4">
                            <img class="card-img" src="http://127.0.0.1:5000/food_items/asset/${recommendation.asset}" alt="${recommendation.foodname}">
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <h5 class="card-title">${recommendation.foodname}</h5>
                                <p class="card-text">${recommendation.description}</p>
                                <p class="card-text"><strong>Price:</strong> $${recommendation.price}</p>
                                <p class="card-text" id="quantity-${recommendation.id}"></p>
                                <div class="d-flex align-items-center">
                                    <button class="btn btn-primary mr-2" onclick="addToCart(${recommendation.id})">Add to Cart</button>
                                    <button class="btn btn-secondary" onclick="removeFromCart(${recommendation.id})">Remove from Cart</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            `;

            chefsRecommendation.innerHTML = cardHTML;

            // Update the quantity display for the item
            updateQuantityDisplay(recommendation.id);
        })
        .catch(error => {
            console.error("Error fetching chef's recommendation:", error);
        });

    // Fetch and display the food items
    fetch("http://127.0.0.1:5000/food_items")
        .then(response => response.json())
        .then(data => {
            const mainDishes = document.getElementById("mainDishes");
            const sideDishes = document.getElementById("sideDishes");

            data.forEach(item => {
                const cardHTML = `
                    <div class="card mb-4">
                        <div class="row no-gutters">
                            <div class="col-md-4">
                                <img class="card-img" src="http://127.0.0.1:5000/food_items/asset/${item.asset}" alt="${item.foodname}">
                            </div>
                            <div class="col-md-8">
                                <div class="card-body">
                                    <h5 class="card-title">${item.foodname}</h5>
                                    <p class="card-text">${item.description}</p>
                                    <p class="card-text"><strong>Price:</strong> $${item.price}</p>
                                    <p class="card-text" id="quantity-${item.id}"></p>
                                    <div class="d-flex align-items-center">
                                        <button class="btn btn-primary mr-2" onclick="addToCart(${item.id})">Add to Cart</button>
                                        <button class="btn btn-secondary" onclick="removeFromCart(${item.id})">Remove from Cart</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                `;

                if (item.category === "main dish") {
                    mainDishes.innerHTML += cardHTML;
                } else if (item.category === "side dish") {
                    sideDishes.innerHTML += cardHTML;
                }

                // Update the quantity display for the item
                updateQuantityDisplay(item.id);
            });
        })
        .catch(error => {
            console.error("Error fetching food items:", error);
        });
});

function getCart() {
    return JSON.parse(localStorage.getItem('cart')) || [];
}

function printCart() {console.log(JSON.parse(localStorage.getItem('cart')))}

function saveCart(cart) {
    localStorage.setItem('cart', JSON.stringify(cart));
}

function addToCart(itemId) {
    const user = JSON.parse(localStorage.getItem("user"));
    if (!user) {
        window.location.href = "/login";
        return;
    }
    fetch(`http://127.0.0.1:5000/food_items/${itemId}`)
        .then(response => response.json())
        .then(item => {
            let cart = getCart();
            const existingItem = cart.find(cartItem => cartItem.id === item.id);
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                item.quantity = 1;
                cart.push(item);
            }
            saveCart(cart);
            updateQuantityDisplay(item.id);
            console.log("Item added to cart:", item);
        })
        .catch(error => {
            console.error("Error adding item to cart:", error);
        });
}

function removeFromCart(itemId) {
    let cart = getCart();
    const itemIndex = cart.findIndex(cartItem => cartItem.id === itemId);
    if (itemIndex !== -1) {
        if (cart[itemIndex].quantity > 1) {
            cart[itemIndex].quantity -= 1;
        } else {
            cart.splice(itemIndex, 1);
        }
        saveCart(cart);
        updateQuantityDisplay(itemId);
        console.log("Item removed from cart:", itemId);
    }
}

function updateQuantityDisplay(itemId) {
    const cart = getCart();
    const item = cart.find(cartItem => cartItem.id === itemId);
    const quantityElement = document.getElementById(`quantity-${itemId}`);
    if (item) {
        quantityElement.textContent = `${item.quantity}x`;
    } else {
        quantityElement.textContent = '';
    }
}
