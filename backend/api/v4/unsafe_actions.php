<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'config.php';

 $method = $_SERVER['REQUEST_METHOD'];
 $input = json_decode(file_get_contents('php://input'), true);

// Basic routing
switch ($method) {
    case 'GET':
        if (isset($_GET['id'])) {
            getUnsafeAction($pdo, $_GET['id']);
        } else {
            getUnsafeActions($pdo);
        }
        break;
    case 'POST':
        createUnsafeAction($pdo, $input);
        break;
    case 'PUT':
        if (isset($_GET['id'])) {
            updateUnsafeAction($pdo, $_GET['id'], $input);
        }
        break;
    case 'DELETE':
        if (isset($_GET['id'])) {
            deleteUnsafeAction($pdo, $_GET['id']);
        }
        break;
    default:
        http_response_code(405);
        echo json_encode(['message' => 'Method not allowed']);
        break;
}

function getUnsafeActions($pdo) {
    $stmt = $pdo->prepare("SELECT * FROM ucuaform WHERE form_type = 'Unsafe Action' ORDER BY id DESC");
    $stmt->execute();
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($results);
}

function getUnsafeAction($pdo, $id) {
    $stmt = $pdo->prepare("SELECT * FROM ucuaform WHERE id = ? AND form_type = 'Unsafe Action'");
    $stmt->execute([$id]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($result) {
        echo json_encode($result);
    } else {
        http_response_code(404);
        echo json_encode(['message' => 'Unsafe Action not found']);
    }
}

function createUnsafeAction($pdo, $data) {
    // Note: Your original SQL used PHP sessions. In a REST API, this data should come from the client request.
    // I've mapped the fields from your original INSERT statement.
    $sql = "INSERT INTO ucuaform (LocationId, OffenceCode, staffId, form_type, ViolatorName, violatorContactNo, ViolatorDept, violatorCompany, ViolatorIc, violatorDatetime, submitdate, ActionTaken, remark, createby, createdate, observerName, observerDepartment, observerEmail, observerDatetime) 
            VALUES (?, ?, ?, 'Unsafe Action', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $pdo->prepare($sql);
    // Bind parameters
    $stmt->execute([
        $data['LocationId'],
        $data['OffenceCode'],
        $data['staffId'],
        $data['ViolatorName'],
        $data['violatorContactNo'],
        $data['ViolatorDept'],
        $data['violatorCompany'],
        $data['ViolatorIc'],
        $data['violatorDatetime'],
        $data['submitdate'],
        $data['ActionTaken'],
        $data['remark'],
        $data['createby'],
        $data['createdate'],
        $data['observerName'],
        $data['observerDepartment'],
        $data['observerEmail'],
        $data['observerDatetime']
    ]);

    http_response_code(201);
    echo json_encode(['message' => 'Unsafe Action created successfully']);
}

function updateUnsafeAction($pdo, $id, $data) {
    // For simplicity, this example updates all fields. In a real app, you might build the query dynamically.
    $sql = "UPDATE ucuaform SET LocationId=?, OffenceCode=?, ViolatorName=?, violatorContactNo=?, ViolatorDept=?, violatorCompany=?, ViolatorIc=?, violatorDatetime=?, ActionTaken=?, remark=? WHERE id=? AND form_type='Unsafe Action'";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        $data['LocationId'],
        $data['OffenceCode'],
        $data['ViolatorName'],
        $data['violatorContactNo'],
        $data['ViolatorDept'],
        $data['violatorCompany'],
        $data['ViolatorIc'],
        $data['violatorDatetime'],
        $data['ActionTaken'],
        $data['remark'],
        $id
    ]);

    echo json_encode(['message' => 'Unsafe Action updated successfully']);
}

function deleteUnsafeAction($pdo, $id) {
    $stmt = $pdo->prepare("DELETE FROM ucuaform WHERE id = ? AND form_type = 'Unsafe Action'");
    $stmt->execute([$id]);
    echo json_encode(['message' => 'Unsafe Action deleted successfully']);
}
?>