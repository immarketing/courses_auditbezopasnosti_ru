<?php

require_once 'aglib.php';
require_once 'agactions.php';

$preventWebDefault = false;

function isWebDefaultPrevented (){
    global $preventWebDefault;
    return $preventWebDefault;

}
function preventWebDefault (){
    global $preventWebDefault;
    $preventWebDefault = true;
}


function agHandleGetTestingJSON () {
    global $is_console;
    preventWebDefault();
    // http://localhost:63342/courses_auditbezopasnosti_ru/index.php?action=gettestingjson&
    // пока мне эта информация не нужна
    $courseID ='';
    if (array_key_exists  (AG_PN_COURSEID,$_REQUEST)) {
        $courseID = $_REQUEST[AG_PN_COURSEID];
    } else {
        //return;
    }


    //запрошу информацию непосредственно с сайта ГУГЛ
    $url = 'https://script.google.com/macros/s/AKfycbxCQvc631SEAgPfjIukHwyGlT89IyL8XMb3UdODclQaAWpBjA/exec?docid=1bjsUfCOpTP7LOOQTpsZqqKwxIbZxkQu6lD386K68TRM';
    $result = file_get_contents($url);
    // Will dump a beauty json :3

    if ($is_console) {
        var_dump(json_decode($result, true));
    } else {
        agAnswerJSON(json_decode($result, true));
    }

}

function agHandleTic(){
    $res = ['result'=>"OK"];
    preventWebDefault();
    agAnswerJSON($res);
}

function agHandlePHPInfo(){
    preventWebDefault();
    phpinfo();
}

function agHandleLogin(){
    preventWebDefault();
    //phpinfo();
    if ($_POST) { // eсли пeрeдaн мaссив POST
        $lgn = htmlspecialchars($_POST["username"]); // пишeм дaнныe в пeрeмeнныe и экрaнируeм спeцсимвoлы
        $pwd = htmlspecialchars($_POST["password"]);

        $user = new Auth\User ();
        $user->authorize($lgn,$pwd, true);

        $json = array( 'status' => 'OK', 'redirect' => 'index.php'); // пoдгoтoвим мaссив oтвeтa


        agAnswerJSON($json); // вывoдим мaссив oтвeтa
        //echo json_encode($json); // вывoдим мaссив oтвeтa
        die(); // умирaeм
    }
}


function agHandleWeb (){

}