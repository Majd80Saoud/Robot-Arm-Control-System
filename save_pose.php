<?php
include("db.php");

$m1 = $_POST['motor1'] ?? null;
$m2 = $_POST['motor2'] ?? null;
$m3 = $_POST['motor3'] ?? null;
$m4 = $_POST['motor4'] ?? null;
$status = $_POST['status'] ?? null;

var_dump($_POST);

if ($m1 !== null && $m2 !== null && $m3 !== null && $m4 !== null && $status !== null) {
    $sql = "INSERT INTO pose (motor1, motor2, motor3, motor4, status) VALUES ($m1, $m2, $m3, $m4, $status)";
    if ($conn->query($sql)) {
        echo "Pose saved successfully.";
    } else {
        echo "Database Error: " . $conn->error;
    }
} else {
    echo "Missing Data";
}

$conn->close();
?>