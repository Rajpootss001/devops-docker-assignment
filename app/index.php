<?php
$host = "mysql";
$db   = "testdb";
$user = "root";
$pass = "rootpass";

try{
    new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    echo "Database connection successful!";
} catch(PDOException $e) {
    echo "Database connection failed: ";
}
?>
