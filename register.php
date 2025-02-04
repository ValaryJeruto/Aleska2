<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Check if the form is submitted
if (isset($_POST['register_pupil'])) {
    // Get form data
    $adm_no = $_POST['adm_no'];
    $full_name_pupil = $_POST['full_name_pupil'];
    $date_of_birth = $_POST['date_of_birth'];
    $gender = $_POST['gender'];
    $address = $_POST['address'];
    $admission_date = $_POST['admission_date'];
    $grade_level = $_POST['grade_level'];

    // Check if file is uploaded
    $avatar_path = null; // Default if no file is uploaded
    if (isset($_FILES['avatar']) && $_FILES['avatar']['error'] == 0) {
        $avatar_tmp_name = $_FILES['avatar']['tmp_name'];
        $avatar_name = $_FILES['avatar']['name'];
        $upload_dir = 'uploads/';  // Ensure this folder exists

        // Create uploads directory if it doesn't exist
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0777, true);
        }

        $avatar_path = $upload_dir . basename($avatar_name);

        // Check and move the uploaded file to the "uploads" directory
        if (!move_uploaded_file($avatar_tmp_name, $avatar_path)) {
            echo "Failed to upload avatar image.";
            $avatar_path = null; // Reset if file upload fails
        }
    }

    // Database connection
    $conn = new mysqli('localhost', 'root', '', 'alaskenadb');
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // If no avatar was uploaded, set a default value for the photo column
    if ($avatar_path === null) {
        $avatar_path = 'uploads/default-avatar.png'; // Default avatar
    }

    // Insert form data and file path into the database
    $sql = "INSERT INTO pupil (adm_no, full_name_pupil, date_of_birth, gender, address, admission_date, grade_level, photo) 
            VALUES ('$adm_no', '$full_name_pupil', '$date_of_birth', '$gender', '$address', '$admission_date', '$grade_level', '$avatar_path')";

    if ($conn->query($sql) === TRUE) {
        echo "New learner registered successfully!";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Close the database connection
    $conn->close();
}
?>
