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
    $res = initJSONReply();
    $res['result'] = "OK";
    preventWebDefault();
    agAnswerJSON($res);
}

function agHandlePHPInfo(){
    preventWebDefault();
    phpinfo();
}

function agHandleLogout (){
    preventWebDefault();
    $res = initJSONReply();

    $user = new Auth\User ();
    $user->logout();

    if ( session_id() ) {
        // Если есть активная сессия, удаляем куки сессии,
        setcookie(session_name(), session_id(), time()-60*60*24);
        // и уничтожаем сессию
        session_unset();
        session_destroy();
    }

    $res['redirect'] = 'index.php';

    agAnswerJSON($res);
}

function agHandleGetTOC (){
    preventWebDefault();
    $res = initJSONReply();

    $aTOCJSON = readGoogleTOC ('1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw');
    //$aTOCJSON = json_decode ($aTOCJSON);
    //echo ($aTOCJSON);
    $user = new Auth\User ();
    if ($user->isAuthorized()) {
        if (! $user->readFromDB()) {
            $res['status'] = 'error';
            $res['error'] = 'User authorized, but not in DB! Relogin, please!';
        } else {
            $tID = $user->getTestID();
            $tst = readTests($tID);
            $cID = $user->getCourseID();
            $crs = readCourses($cID);
            if ($crs) {
                $aTOCJSON = $crs['TOCJSON'];
                $aTOCJSONJS = json_decode($aTOCJSON);
                $res['data'] = $aTOCJSONJS;
            }
        }
    } else {
        $res['status'] = 'error';
        $res['error'] = 'User is not authorized! Relogin, please!';
    }

    agAnswerJSON($res);
}

function agHandleLogin(){
    preventWebDefault();
    //phpinfo();
    if ($_POST) { // eсли пeрeдaн мaссив POST
        $lgn = htmlspecialchars($_POST["username"]); // пишeм дaнныe в пeрeмeнныe и экрaнируeм спeцсимвoлы
        $pwd = htmlspecialchars($_POST["password"]);

        $user = new Auth\User ();
        $user->authorize($lgn,$pwd, true);

        $json =  initJSONReply();
        $json['redirect'] = 'index.php'; // пoдгoтoвим мaссив oтвeтa

        agAnswerJSON($json); // вывoдим мaссив oтвeтa
        //echo json_encode($json); // вывoдим мaссив oтвeтa
        die(); // умирaeм
    }
}


function agHandleWeb (){

}