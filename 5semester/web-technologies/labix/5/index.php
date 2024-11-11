<?php

$host = "localhost";
$username = "k";
$password = "";
$dbname = "web_lab_5";

$conn = mysqli_connect($host, $username, $password, $dbname);

if (!$conn) {
	die("Connection error: " . mysqli_connect_error());
}

$sql = "SELECT id, nickname, login FROM users";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        echo "ID: " . $row["id"] . ", Никнейм: " . $row["nickname"] . ", Логин: " . $row["login"] . "<br>";
    }
} else {
    echo "Записи не найдены.";
}

// Закрытие соединения
mysqli_close($conn);

?>
