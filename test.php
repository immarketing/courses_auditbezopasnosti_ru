<?php
/**
 * Created by PhpStorm.
 * User: Папа
 * Date: 18.03.2016
 * Time: 23:12
 */
require 'vendor/autoload.php';

\PhpOffice\PhpWord\Autoloader::register();

require './php.src/gettoc.php';

/*
require './php.src/aglib.php';
$aTOCJSON = readGoogleTOC ('1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw');
$aTOCJSON = json_decode ($aTOCJSON);
var_dump($aTOCJSON);
*/
