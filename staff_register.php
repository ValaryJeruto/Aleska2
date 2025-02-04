<?php
// Database connection
$servername = "localhost";
$username = "root"; // Change if needed
$password = ""; // Change if needed
$database = "alaskenadb";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["register_staff"])) {
    $teacher_id = $_POST["teacher_id"];
    $user_id = $_POST["user_id"];
    $full_name = $_POST["full_name_staff"];
    $subject = $_POST["subject"];
    $phone = $_POST["phone"];
    $email = $_POST["email"];
    $hire_date = $_POST["hire_date"];
    $avatar_path = NULL;

    // Handle avatar upload
    if (!empty($_FILES["avatar"]["name"])) {
        $target_dir = "uploads/";
        $avatar_name = basename($_FILES["avatar"]["name"]);
        $avatar_path = $target_dir . time() . "_" . $avatar_name; // Prevent duplicate filenames

        // Move uploaded file
        if (!move_uploaded_file($_FILES["avatar"]["tmp_name"], $avatar_path)) {
            die("Error uploading avatar.");
        }
    }

    // Escape input data to prevent SQL injection
    $teacher_id = mysqli_real_escape_string($conn, $teacher_id);
    $user_id = mysqli_real_escape_string($conn, $user_id);
    $full_name = mysqli_real_escape_string($conn, $full_name);
    $subject = mysqli_real_escape_string($conn, $subject);
    $phone = mysqli_real_escape_string($conn, $phone);
    $email = mysqli_real_escape_string($conn, $email);
    $hire_date = mysqli_real_escape_string($conn, $hire_date);
    $avatar_path = mysqli_real_escape_string($conn, $avatar_path);

    // Insert staff details into database
    $sql = "INSERT INTO staff (teacher_id, user_id, full_name, subject, phone, email, hire_date, avatar) 
            VALUES ('$teacher_id', '$user_id', '$full_name', '$subject', '$phone', '$email', '$hire_date', '$avatar_path')";

    if ($conn->query($sql) === TRUE) {
        echo "Staff registered successfully!";
    } else {
        echo "Error: " . $conn->error;
    }
}

// Close connection
$conn->close();
?>
