<?php
header("Access-Control-Allow-Origin: *");
include 'config.php';

$username = $_POST['username'];
$password = $_POST['password'];
$status = $_POST['status'];

$query = mysqli_query($koneksi,"SELECT * FROM user WHERE username='$username' AND password='$password' AND status = '$status'");

$result = array();

while($data = mysqli_fetch_assoc($query)){
	$result[]=$data;
}

echo json_encode($result);

?>