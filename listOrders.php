<?php
function listOrdersByDate($date) {
    $host = 'localhost';
    $db_name = 'restaurantDB';
    $username = 'root';
    $password = '';

    try {
        $conn = new PDO("mysql:host=$host;dbname=$db_name", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $query = "SELECT c.firstName, c.lastName, f.name, fo.totalPrice, fo.tip, e.firstName as deliveryFirstName, e.lastName as deliveryLastName
                  FROM customerAccount c
                  JOIN orderPlacement op ON c.emailAddress = op.customerEmail
                  JOIN foodOrder fo ON op.orderID = fo.orderID
                  JOIN foodItemsinOrder fio ON fo.orderID = fio.orderID
                  JOIN food f ON fio.food = f.name
                  JOIN delivery d ON fo.orderID = d.orderID
                  JOIN employee e ON d.deliveryPerson = e.ID
                  WHERE op.orderDate = :date";

        $stmt = $conn->prepare($query);
        $stmt->bindParam(':date', $date);
        $stmt->execute();

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $result;
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }

    $conn = null;
}

// Usage
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $date = $_POST['date']; // Get the date entered by the user

    $orders = listOrdersByDate($date);

    echo json_encode($orders); // Output the result set as JSON
}
