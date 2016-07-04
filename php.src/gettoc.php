<?php
/**
 * Created by PhpStorm.
 * User: AVGorbunov
 * Date: 04.07.2016
 * Time: 15:03
 */
header("Content-Type: application/json");

require 'aglib.php';
$aTOCJSON = readGoogleTOC ('1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw');
//$aTOCJSON = json_decode ($aTOCJSON);
echo ($aTOCJSON);