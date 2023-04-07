document
  .getElementById("list-order-form")
  .addEventListener("submit", function (event) {
    event.preventDefault();

    const date = document.getElementById("date").value;
    const formData = new FormData();
    formData.append("date", date);

    fetch("listOrders.php", {
      method: "POST",
      body: formData,
    })
      .then((response) => {
        return response.json(); // Parse the response as JSON
      })
      .then((orders) => {
        const ordersContainer = document.getElementById("orders-container");
        const listOrderText = document.querySelector(".list-order-text");
        ordersContainer.innerHTML = "";

        if (orders.length === 0) {
          listOrderText.innerText = `No orders found on ${date}`;
        } else {
          listOrderText.innerText = `List of orders on ${date}`;
          for (const order of orders) {
            const orderHtml = `
              <div class='order-item'>
                  Customer Name: ${order.firstName} ${order.lastName}<br>
                  Item Ordered: ${order.name}<br>
                  Total Amount: $${order.totalPrice}<br>
                  Tip: $${order.tip}<br>
                  Delivery Person: ${order.deliveryFirstName} ${order.deliveryLastName}<br><br>
              `;

            ordersContainer.innerHTML += orderHtml;
          }
        }
      });
  });
