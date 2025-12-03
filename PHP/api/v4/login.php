<?php
// login.php
require 'config.php';
require 'utils.php';
$input = json_decode(file_get_contents("php://input"), true);
$staffId = $input['staffId'] ?? '';
$password = $input['password'] ?? '';
// Validate input
if (empty($staffId) || empty($password)) {
    echo json_encode([
        'success' => false,
        'message' => "Staff ID and password are required.",
        'data' => null,
        'code' => 400
    ]);
    exit; // Ensure the script stops execution after response.
}
// Prepare SQL statement
$sql = "SELECT staffId, Name, Email, PhoneNo, Password, AccessLevel, Status
        FROM `user`
        WHERE staffId = :staffId AND Password = :password AND isdelete = 0";
$stmt = $pdo->prepare($sql);
$stmt->execute([':staffId' => $staffId, ':password' => md5($password)]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$user) {
    echo json_encode([
        'success' => false,
        'message' => "Invalid credentials.",
        'data' => null,
        'code' => 401
    ]);
    exit;
}
// Remove sensitive information
unset($user['Password']);
echo json_encode([
    'success' => true,
    'message' => "Login successful.",
    'data' => $user,
    'code' => 200
]);
