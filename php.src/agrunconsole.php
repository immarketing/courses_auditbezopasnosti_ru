<?php

require_once 'agactions.php';
require_once 'aglib.php';

function agHandle__updatePupilsInDB (){
    // update agpupils set login = 100000 + id where login is NULL or login = ''
    $db = connectDB();
    $result = $db->query("update agpupils set login = 100000 + id where login is NULL or login = ''");
    //$row = $result->fetch_assoc();
    if ($result === TRUE) {
        // OK
        //echo "Record updated successfully";
    } else {
        // ERROR
        //echo "Error updating record: " . $conn->error;
    }
    //$db = connectDB();
    $result = $db->query("UPDATE agpupils SET pwd1=concat(
    substring('123456789123456789', rand(@seed:=round(rand(id)*rand()*4294967296))*10+1, 1),
    substring('01234567890123456789', rand(@seed:=round(rand(@seed)*4294967296))*10+1, 1),
    substring('01234567890123456789', rand(@seed:=round(rand(@seed)*4294967296))*10+1, 1),
    substring('01234567890123456789', rand(@seed:=round(rand(@seed)*4294967296))*10+1, 1),
    substring('01234567890123456789', rand(@seed:=round(rand(@seed)*4294967296))*10+1, 1),
    substring('01234567890123456789', rand(@seed:=round(rand(@seed)*4294967296))*10+1, 1)
)
WHERE pwd1='' or pwd1 is NULL ;");
    //$row = $result->fetch_assoc();
    if ($result === TRUE) {
        // OK
        //echo "Record updated successfully";
    } else {
        // ERROR
        //echo "Error updating record: " . $conn->error;
    }

    $db->close();
}

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