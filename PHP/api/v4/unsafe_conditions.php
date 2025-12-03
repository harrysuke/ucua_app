<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'config.php';

 $method = $_SERVER['REQUEST_METHOD'];
 $input = json_decode(file_get_contents('php://input'), true);

switch ($method) {
    case 'GET':
        if (isset($_GET['id'])) {
            getUnsafeCondition($pdo, $_GET['id']);
        } else {
            getUnsafeConditions($pdo);
        }
        break;
    case 'POST':
        createUnsafeCondition($pdo, $input);
        break;
    case 'PUT':
        if (isset($_GET['id'])) {
            updateUnsafeCondition($pdo, $_GET['id'], $input);
        }
        break;
    case 'DELETE':
        if (isset($_GET['id'])) {
            deleteUnsafeCondition($pdo, $_GET['id']);
        }
        break;
    default:
        http_response_code(405);
        echo json_encode(['message' => 'Method not allowed']);
        break;
}

function getUnsafeConditions($pdo) {
    $stmt = $pdo->prepare("SELECT conditionDetails, locationId, submitdate FROM ucuaform WHERE form_type = 'Unsafe Condition' AND conditionDetails IS NOT NULL AND locationId IS NOT NULL AND submitdate IS NOT NULL ORDER BY id DESC");
    $stmt->execute();
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($results);
}

function createUnsafeCondition($pdo, $data) {
    $sql = "INSERT INTO ucuaform (LocationId, conditionDetails, staffId, form_type, submitdate, createby, createdate, observerName, observerDepartment, observerEmail, observerDatetime) 
            VALUES (?, ?, ?, 'Unsafe Condition', ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        $data['LocationId'],
        $data['conditionDetails'],
        $data['staffId'],
        $data['submitdate'],
        $data['createby'],
        $data['createdate'],
        $data['observerName'],
        $data['observerDepartment'],
        $data['observerEmail'],
        $data['observerDatetime']
    ]);

    http_response_code(201);
    echo json_encode(['message' => 'Unsafe Condition created successfully']);
}

// Implement updateUnsafeCondition and deleteUnsafeCondition similarly to the actions endpoint
function updateUnsafeCondition($pdo, $id, $data) {
    $sql = "UPDATE ucuaform SET LocationId=?, conditionDetails=? WHERE id=? AND form_type='Unsafe Condition'";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$data['LocationId'], $data['conditionDetails'], $id]);
    echo json_encode(['message' => 'Unsafe Condition updated successfully']);
}

function deleteUnsafeCondition($pdo, $id) {
    $stmt = $pdo->prepare("DELETE FROM ucuaform WHERE id = ? AND form_type = 'Unsafe Condition'");
    $stmt->execute([$id]);
    echo json_encode(['message' => 'Unsafe Condition deleted successfully']);
}
?>