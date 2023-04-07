<?php

header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "restaurantDB";

try {

    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if (isset($_GET['id'])) {
        $stmt = $conn->prepare("SELECT employee.ID, employee.firstName, employee.lastName, shift.day, shift.startTime, shift.endTime
                                FROM employee
                                JOIN shift ON employee.ID = shift.empID
                                WHERE employee.ID = :id AND shift.day NOT IN ('Saturday', 'Sunday')
                                ORDER BY FIELD(shift.day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')");

        $stmt->bindParam(':id', $_GET['id']);
    } else {
        $stmt = $conn->prepare("SELECT employee.ID, employee.firstName, employee.lastName
                                FROM employee
                                ORDER BY employee.ID");
    }

    $stmt->execute();

    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $employees = [];

    if (isset($_GET['id'])) {
        foreach ($result as $row) {
            $employees[] = [
                'day' => $row['day'],
                'startTime' => $row['startTime'],
                'endTime' => $row['endTime']
            ];
        }
    } else {
        foreach ($result as $row) {
            $employees[] = [
                'id' => $row['ID'],
                'firstName' => $row['firstName'],
                'lastName' => $row['lastName']
            ];
        }
    }

    echo json_encode($employees);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error: ' . $e->getMessage()]);
}

$conn = null;
?>
