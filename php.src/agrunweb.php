<?php

require_once 'aglib.php';
require_once 'agactions.php';


function agHandleGetTestingJSON () {
    // http://localhost:63342/courses_auditbezopasnosti_ru/index.php?action=gettestingjson&
    // пока мне эта информация не нужна
    $courseID ='';
    if (array_key_exists  (AG_PN_COURSEID,$_REQUEST)) {
        $courseID = $_REQUEST[AG_PN_COURSEID];
    } else {
        return;
    }


    //запрошу информацию непосредственно с сайта ГУГЛ
    $url = 'https://script.google.com/macros/s/AKfycbxCQvc631SEAgPfjIukHwyGlT89IyL8XMb3UdODclQaAWpBjA/exec?docid=1bjsUfCOpTP7LOOQTpsZqqKwxIbZxkQu6lD386K68TRM';
    $result = file_get_contents($url);
    // Will dump a beauty json :3
    var_dump(json_decode($result, true));
}

function agHandleTic(){
    $res = ['result'=>"OK"];
    agAnswerJSON($res);
}

function agHandleWeb (){

}