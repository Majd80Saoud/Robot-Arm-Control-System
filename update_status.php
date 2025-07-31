<?php
include 'db.php';

if (!isset($_GET['id'])) {
    echo "Missing ID";
    exit;
}

$id = intval($_GET['id']);

$sql = "UPDATE pose SET status = 0 WHERE id = $id";
if ($conn->query($sql)) {
    echo "Status updated";
} else {
    echo "Error: " . $conn->error;
}
?>