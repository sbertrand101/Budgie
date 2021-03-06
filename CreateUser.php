<?php
session_start();
$data = json_decode(file_get_contents('php://input'));
$db = new mysqli("classroom.cs.unc.edu", "kjbass", "426password!", "kjbassdb");

$stmt = $db->prepare('SELECT * FROM ProjUser u WHERE u.UserID=?;');
$userID = $data->{"UserID"};
$stmt->bind_param('s', $userID);
$stmt->execute();
$result = $stmt->get_result();
$response = NULL;
if($result->num_rows === 0){
    $salt = time();
    $FirstName = $data->{'FirstName'};
    $LastName = $data->{'LastName'};
    $HashedPass = hash('md5', $data->{'Password'}.$salt);
    $stmt = $db->prepare('INSERT INTO ProjUser(UserID, HashedPassword, Salt, FirstName, LastName) VALUES(?,?,?,?,?);
    ');
    $stmt->bind_param('sssss', $userID, $HashedPass, $salt, $FirstName, $LastName);
    $stmt->execute();
} else {
    $response = (object) ['error' => 'Username Taken'];
}
if (!is_null($response)){
    echo json_encode($response);
    return;
}
$_SESSION['userID'] = $userID;
?>