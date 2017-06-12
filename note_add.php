<?php

//step2. read from mysql

//echo $_POST["name"];
//echo $_POST["price"];

$connection = mysqli_connect("localhost","root","root","change");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}
$stmt = $connection->prepare("insert into Game (GameName,WantGame,Area,ChangeType,mail,UserID,`Date`) values (?,?,?,?,?,?,?)");
//可以先用$_GET測試
$stmt->bind_param('sssssss',$_POST["GameName"] , $_POST["WantGame"] , $_POST["Area"] , $_POST["ChangeType"] , $_POST["mail"] , $_POST["UserID"], $_POST["Date"]); //first parameter, s :string d:integer
$stmt->execute();
$stmt->close();

mysqli_close($connection);
echo json_encode(array("status"=>"ok"));

?>

