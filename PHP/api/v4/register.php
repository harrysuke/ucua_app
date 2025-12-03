<?php
// register.php
require 'config.php';
require 'utils.php';

$input = getJsonInput();

// Basic validation (adjust as needed)
$required = ['companyCode', 'branchCode', 'staffId', 'password', 'name', 'phoneNo', 'department', 'designation', 'email'];
foreach ($required as $field) {
    if (empty($input[$field])) {
        respond(false, "Missing field: $field", null, 400);
    }
}

$companyCode = $input['companyCode'];
$branchCode  = $input['branchCode'];
$staffId     = $input['staffId'];
$password    = $input['password'];
$name        = $input['name'];
$phoneNo     = $input['phoneNo'];
$department  = $input['department'];
$designation = $input['designation'];
$email       = $input['email'];
$companyID   = $input['companyID'] ?? 0;
$accessLevel = $input['accessLevel'] ?? 1;
$status      = 1;
$now         = date('Y-m-d H:i:s');

// Check duplicate staffId
$stmt = $pdo->prepare("SELECT staffId FROM `user` WHERE staffId = :staffId AND isdelete = 0");
$stmt->execute([':staffId' => $staffId]);
if ($stmt->fetch()) {
    respond(false, "Staff ID already exists", null, 409);
}

$hashed = md5($password);

$sql = "INSERT INTO `user` 
    (companyCode, branchCode, staffId, Password, Password1, Name, PhoneNo, CompanyID,
     Department, Designation, AccessLevel, Email, Status, createby, createdate,
     editby, editdate, isdelete, deleteby, deletedate)
    VALUES
    (:companyCode, :branchCode, :staffId, :Password, :Password1, :Name, :PhoneNo, :CompanyID,
     :Department, :Designation, :AccessLevel, :Email, :Status, :createby, :createdate,
     :editby, :editdate, 0, '', '0000-00-00 00:00:00')";

$stmt = $pdo->prepare($sql);
$stmt->execute([
    ':companyCode' => $companyCode,
    ':branchCode'  => $branchCode,
    ':staffId'     => $staffId,
    ':Password'    => $hashed,
    ':Password1'   => $hashed, // or use for history
    ':Name'        => $name,
    ':PhoneNo'     => $phoneNo,
    ':CompanyID'   => $companyID,
    ':Department'  => $department,
    ':Designation' => $designation,
    ':AccessLevel' => $accessLevel,
    ':Email'       => $email,
    ':Status'      => $status,
    ':createby'    => $staffId,
    ':createdate'  => $now,
    ':editby'      => $staffId,
    ':editdate'    => $now
]);

respond(true, "Registration successful");
