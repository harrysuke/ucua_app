<?php
// utils.php
function getJsonInput() {
    $data = file_get_contents("php://input");
    return json_decode($data, true) ?? [];
}

function respond($success, $message, $data = null, $code = 200) {
    http_response_code($code);
    echo json_encode([
        "success" => $success,
        "message" => $message,
        "data"    => $data
    ]);
    exit;
}