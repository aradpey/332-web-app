<?php
$servername = "localhost";
$dbname = "restaurantDB";
$username = "root";
$password = "";


try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $emailAddress = $_POST['emailAddress'];
    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $cellNum = $_POST['cellNum'];
    $streetAddress = $_POST['streetAddress'];
    $city = $_POST['city'];
    $pc = $_POST['pc'];
    $creditAmt = 5.00;

    $stmt = $conn->prepare("SELECT * FROM customerAccount WHERE emailAddress = :emailAddress");
    $stmt->bindParam(':emailAddress', $emailAddress);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        echo "An account linked with the current email already exists";
    } else {
        $stmt = $conn->prepare("INSERT INTO customerAccount (emailAddress, firstName, lastName, cellNum, streetAddress, city, pc, creditAmt) VALUES (:emailAddress, :firstName, :lastName, :cellNum, :streetAddress, :city, :pc, :creditAmt)");
        $stmt->bindParam(':emailAddress', $emailAddress);
        $stmt->bindParam(':firstName', $firstName);
        $stmt->bindParam(':lastName', $lastName);
        $stmt->bindParam(':cellNum', $cellNum);
        $stmt->bindParam(':streetAddress', $streetAddress);
        $stmt->bindParam(':city', $city);
        $stmt->bindParam(':pc', $pc);
        $stmt->bindParam(':creditAmt', $creditAmt);
        $stmt->execute();
        echo "Customer account created successfully";
    }
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}

// Close the database connection
$conn = null;

?>
