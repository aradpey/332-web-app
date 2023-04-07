document.addEventListener("DOMContentLoaded", () => {
  fetch("ordersPerDate.php")
    .then((response) => response.json())
    .then((data) => {
      let table = '<table border="1">';
      table += "<tr><th>Date</th><th>Number of Orders</th></tr>";

      data.forEach((row) => {
        table += `<tr><td>${row.date}</td><td>${row.orders}</td></tr>`;
      });

      table += "</table>";
      document.getElementById("ordersTable").innerHTML = table;
    })
    .catch((error) => {
      console.error("Error:", error);
    });
});
