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

    //agHandleGetTestingJSON();
}

function agHandle__testcrypt() {
    $p = 'pwd';
    $ph = password_hash ( $p, PASSWORD_DEFAULT, [
        'cost' => 14,
    ]);
    echo "$p => $ph \n";
}


function agHandleConsole(){

}

//echo "Hello\n";