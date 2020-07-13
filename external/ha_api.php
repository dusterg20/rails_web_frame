<?php
session_start();
$action=$_GET['action'];
$pin=$_GET['pin'];
//$ip=$_SERVER['REMOTE_ADDR'];
$ip="localhost";
$relay_read="pigs r ".$pin;
$relay_write="pigs w ".$pin;
$status=shell_exec($relay_read);

if ($action == "status"){
print($status);
exit;
}

if ($action == "toggle"){
  if ($status == 1){
  $toggle = $relay_write." 0";
  passthru($toggle);
  } ELSE {
  $toggle = $relay_write." 1";
  passthru($toggle);
  }
  exit;
}
?>
