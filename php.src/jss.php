<?php
/**
 * НЕ ИСПОЛЬЗУЕТСЯ ПОКА
 * Created by PhpStorm.
 * User: AVGorbunov
 * Date: 04.07.2016
 * Time: 14:39
 */

require 'aglib.php';

$aTOCJSON = readGoogleTOC ('1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw');

$aTOCJSON = json_decode ($aTOCJSON);

foreach ($aTOCJSON as $key => $value) {

}

?>

$(document).ready(function () {

$('#tree').treeview({
data : getTree()
})
});
