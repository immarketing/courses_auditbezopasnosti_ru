<?php

require_once 'agactions.php';

/**
 *
 */
function agHandle__help() {
    $ca = agGetActionsList(true);
    $wa = agGetActionsList(false);

    echo "Console actions:\n";
    var_dump($ca);
    echo "Web actions:\n";
    var_dump($wa);

    agHandleGetTestingJSON();
}


function agHandleConsole(){

}

//echo "Hello\n";