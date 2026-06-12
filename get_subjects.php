<?php
include("db.php");

if (isset($_GET['semester'])) {
    $semester = intval($_GET['semester']);
    $subjects = [];

    $query = "SELECT DISTINCT name FROM scheme WHERE sem = $semester ORDER BY name ASC";
    $result = $conn->query($query);

    while ($row = $result->fetch_assoc()) {
        $subjects[] = $row['name'];
    }

    echo json_encode($subjects);
}
?>
