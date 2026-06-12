<?php
session_start();
include("db.php");

// Get form inputs
$username = trim($_POST['username']);
$password = trim($_POST['password']);
$role     = trim($_POST['role']);

// Function to check login
function checkLogin($conn, $table, $userColumn, $passwordColumn, $username, $password) {
    $query = $conn->prepare("SELECT * FROM $table WHERE $userColumn=?");
    $query->bind_param("s", $username);
    $query->execute();
    $result = $query->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();

        if (password_verify($password, $row[$passwordColumn]) || $password === $row[$passwordColumn]) {
            return $row;
        }
    }
    return false;
}

// =============== STUDENT LOGIN ===============
if ($role === "student") {
    $row = checkLogin($conn, "student", "usn", "password", $username, $password);
    if ($row) {
        $_SESSION['username'] = $row['usn'];
        $_SESSION['name'] = $row['name'];
        $_SESSION['role'] = "student";
        $_SESSION['student_logged_in'] = true;

        header("Location: student_dashboard.php");
        exit;
    }
}

// =============== TEACHER LOGIN ===============
if ($role === "teacher") {
    $row = checkLogin($conn, "teachers", "teacher_id", "password", $username, $password);
    if ($row) {
        $_SESSION['username'] = $row['teacher_id'];
        $_SESSION['name'] = $row['name'];
        $_SESSION['role'] = "teacher";
        $_SESSION['teacher_logged_in'] = true;

        header("Location: teacher_dashboard.php");
        exit;
    }
}

// =============== HOD LOGIN ===============
if ($role === "hod") {
    $row = checkLogin($conn, "hod", "username", "password", $username, $password);

    if ($row) {
        $_SESSION['username'] = $row['username'];
        $_SESSION['name'] = $row['name'];
        $_SESSION['role'] = "hod";

        // IMPORTANT: This is required for dashboard access!!
        $_SESSION['hod_logged_in'] = true;

        header("Location: hod_dashboard.php");
        exit;
    }
}

// =============== INVALID LOGIN ===============
echo "<script>alert('❌ Invalid Login Credentials'); window.location='index.php';</script>";
exit;

?>
