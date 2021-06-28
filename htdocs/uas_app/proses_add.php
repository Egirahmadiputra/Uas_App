<?php
header("Access-Control-Allow-Origin: *");
include 'config.php';

$username = $_POST['username'];
$password = $_POST['password'];

$query = mysqli_query($koneksi,"INSERT INTO USER VALUES ('$username', '$password', 'customer');");


?>
