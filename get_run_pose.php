<?php
include("db.php");




$sql = "SELECT * FROM pose WHERE status = 1";
$result = $conn->query($sql);


if ($result->num_rows > 0) {
    echo "<h2>(Status = 1):</h2><br>";
    while ($row = $result->fetch_assoc()) {
        echo "Pose ID: " . $row['id'] . " - ";
        echo "M1: " . $row['motor1'] . ", ";
        echo "M2: " . $row['motor2'] . ", ";
        echo "M3: " . $row['motor3'] . ", ";
        echo "M4: " . $row['motor4'] . "<br><br>";
    }
} else {
    echo "لا توجد وضعيات مفعلة حالياً.";
}

$conn->close();
?>