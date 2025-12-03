<?php
// forgot_password.php
require 'config.php';
require 'utils.php';

$input = getJsonInput();
$staffId     = $input['staffId']     ?? '';
$email       = $input['email']       ?? '';
$newPassword = $input['newPassword'] ?? '';

if (!$staffId || !$email || !$newPassword) {
    respond(false, "staffId, email and newPassword required", null, 400);
}

$sql = "SELECT staffId FROM `user`
        WHERE staffId = :staffId AND Email = :Email AND isdelete = 0";
$stmt = $pdo->prepare($sql);
$stmt->execute([':staffId' => $staffId, ':Email' => $email]);

if (!$stmt->fetch()) {
    respond(false, "User not found", null, 404);
}

$hashed = password_hash($newPassword, PASSWORD_DEFAULT);
$now    = date('Y-m-d H:i:s');

$update = $pdo->prepare("UPDATE `user` 
                         SET Password = :pwd, Password1 = :pwd, editby = :staffId, editdate = :dt 
                         WHERE staffId = :staffId");
$update->execute([
    ':pwd'     => $hashed,
    ':staffId' => $staffId,
    ':dt'      => $now
]);

respond(true, "Password updated");
