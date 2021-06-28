<?php
header("Access-Control-Allow-Origin: *");
include 'config.php';

$username = $_POST['username'];

$query = mysqli_query($koneksi,"DELETE FROM user WHERE username='$username'");


?>