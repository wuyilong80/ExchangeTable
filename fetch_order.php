<?php

function the_check($link,$pd,$err)
{
    if ($link == null){
        $pd["mysqli_errno"] = $err;
        echo json_encode($pd);
        exit();
    }
}

$pd = array();
$pd["mysqli_errno"] = 0;


$link = mysqli_connect("localhost","root","root","change");
the_check($link,$pd,1);

$rv = mysqli_set_charset($link,"utf8");
the_check($rv,$pd,2);

//$rv = mysqli_select_db($link,"apr19");
//the_check($rv,$pd,3);

//$aaa = $_REQUEST["kw"];

$query = "select  * from Game";  //AND R.receiver_name = '張三'

//if (isset($aaa)){
//    if (strlen($aaa) > 0 ){
//        $query = $query."WHERE  name = '$aaa'";
//    }else{
//
//    }
//}


$result = mysqli_query($link,$query);
the_check($result,$pd,4);


$rows = array();


while ($er = mysqli_fetch_assoc($result) ){
    $rows[] = $er;
}

//$rows [] = $er;

$pd ["rows"] = $rows;


echo json_encode($pd);

?>

