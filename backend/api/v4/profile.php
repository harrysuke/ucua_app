<?php
// profile.php
require 'config.php';
require 'utils.php';

$staffId = $_GET['staffId'] ?? '';

if (!$staffId) {
    respond(false, "staffId required", null, 400);
}

$sql = "SELECT companyCode, branchCode, staffId, Name, PhoneNo,
               CompanyID, Department, Designation, AccessLevel, Email, Status
        FROM `user` 
        WHERE staffId = :staffId AND isdelete = 0";
$stmt = $pdo->prepare($sql);
$stmt->execute([':staffId' => $staffId]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    respond(false, "User not found", null, 404);
}

respond(true, "Profile loaded", $user);
