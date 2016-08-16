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

    $user = new Auth\User ();
    if ($user->isAuthorized()) {
        // пользователь авторизован
        if ($user->readFromDB()) {
            // прочитали пользователя из базы
            $tID = $user->getTestID();
            $tst = readTests($tID);
            if ($tst) {
                // прочитали данные теста из базы. Реально мне нужна только информация по ID гугл документа
                $courseID = $tst['GoogleSheetID'];
            }
        } else {
            // пользователь авторизован, но данные его из базы почему-то не прочитались. :(
            setJSONReplyError($res, 'User authorized, but not in DB! Relogin, please!');
        }
    } else {
        // пользователь неавторизован. произошла какая-то ошибка. Не включены КУКИ? Возможно
    }

    if (array_key_exists  (AG_PN_COURSEID,$_REQUEST)) {
        $courseID = $_REQUEST[AG_PN_COURSEID];
    } else {
        //return;
    }

    $result = getTestingJSONForTestID($tst);

    //запрошу информацию непосредственно с сайта ГУГЛ
    // 1bjsUfCOpTP7LOOQTpsZqqKwxIbZxkQu6lD386K68TRM
    //      https://script.google.com/macros/s/AKfycbxCQvc631SEAgPfjIukHwyGlT89IyL8XMb3UdODclQaAWpBjA/exec?docid=1wguJxZMOM9gxCl_IxXg6EetORwIEzG-qWHDbHltiiIw&version=2
    //$url = 'https://script.google.com/macros/s/AKfycbxCQvc631SEAgPfjIukHwyGlT89IyL8XMb3UdODclQaAWpBjA/exec?version=2&docid='.$courseID;
    //$result = file_get_contents($url);
    // Will dump a beauty json :3

    if ($is_console) {
        var_dump(json_decode($result, true));
    } else {
        agAnswerJSON(json_decode($result, true));
    }
    die();
}

function agHandleTic(){
    $res = initJSONReply();
    //$res['result'] = "OK";
    preventWebDefault();
    agAnswerJSON($res);
}

function agHandlePHPInfo(){
    preventWebDefault();
    phpinfo();
}

function agHandleSaveAnswers (){
    preventWebDefault();
    $res = initJSONReply();
    /*
     *                    answrJSON['_q'+(i<=9?'0':'')+i+'UID'] = agTestingData.answData[i].UID;
                    answrJSON['_q'+(i<=9?'0':'')+i+'ansno'] = agTestingData.answData[i].answrNo;

     */

    if ($_POST) { // eсли пeрeдaн мaссив POST
        //$lgn = htmlspecialchars($_POST["username"]); // пишeм дaнныe в пeрeмeнныe и экрaнируeм спeцсимвoлы
    }
    $tID = $_POST['testID'];
    $tst = readTests($tID);

    agAnswerJSON($res);
    die();
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

    setJSONReplyRedirect($res, 'index.php');

    //$res['redirect'] = 'index.php';

    agAnswerJSON($res);
}

function agHandleGetTOC (){
    preventWebDefault();
    $res = initJSONReply();

    //$aTOCJSON = readGoogleTOC ('1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw');
    //$aTOCJSON = json_decode ($aTOCJSON);
    //echo ($aTOCJSON);
    $user = new Auth\User ();
    if ($user->isAuthorized()) {
        if (! $user->readFromDB()) {
            setJSONReplyError($res, 'User authorized, but not in DB! Relogin, please!');
            /*
            $res['status'] = 'error';
            $res['error'] = 'User authorized, but not in DB! Relogin, please!';
            */
        } else {
            $tID = $user->getTestID();
            $tst = readTests($tID);
            if ($tst) {
                $res['testData'] = $tst;
                //$aTOCJSON = $crs['TOCJSON'];
                //$aTOCJSONJS = json_decode($aTOCJSON);
                //$res['data'] = $aTOCJSONJS;
            }

            $cID = $user->getCourseID();
            $crs = readCourses($cID);
            if ($crs) {
                $res['courseData'] = $crs;
                $aTOCJSON = $crs['TOCJSON'];
                $aTOCJSONJS = json_decode($aTOCJSON);
                $res['data'] = $aTOCJSONJS;
            }
        }
    } else {
        setJSONReplyError($res, 'User is not authorized! Relogin, please!');
        /*
        $res['status'] = 'error';
        $res['error'] = 'User is not authorized! Relogin, please!';
        */
    }

    agAnswerJSON($res);
}

function agHandleLogin()
{
    preventWebDefault();
    //phpinfo();
    if ($_POST) { // eсли пeрeдaн мaссив POST
        $lgn = htmlspecialchars($_POST["username"]); // пишeм дaнныe в пeрeмeнныe и экрaнируeм спeцсимвoлы
        $pwd = htmlspecialchars($_POST["password"]);
        // to.do доделать капчу гугла
        // https://www.google.com/recaptcha/admin
        $gcp = $_POST["g-recaptcha-response"];

        $siteKey = '';
        $secret = '6LcnDSYTAAAAAOh4W1VSboT7cTsWKxq7hL_LD4AK';

        $recaptcha = new \ReCaptcha\ReCaptcha($secret);
        $resp = $recaptcha->verify($gcp, $_SERVER['REMOTE_ADDR']);

        if ($resp->isSuccess()) {
            $user = new Auth\User ();
            $user->authorize($lgn, $pwd, true);

            if ($user->isAuthorized()) {
                $json = initJSONReply();
                setJSONReplyRedirect($json, 'index.php'); // пoдгoтoвим мaссив oтвeтa
                //$json['redirect'] = 'index.php'; // пoдгoтoвим мaссив oтвeтa
                agAnswerJSON($json); // вывoдим мaссив oтвeтa
                //echo json_encode($json); // вывoдим мaссив oтвeтa
                die(); // умирaeм
            }else {
                $json = initJSONReply();
                setJSONReplyError($json, 'Login error!','lgn pwd');
                agAnswerJSON($json); // вывoдим мaссив oтвeтa
                //echo json_encode($json); // вывoдим мaссив oтвeтa
                die(); // умирaeм
            }
        } else {
            $json = initJSONReply();
            setJSONReplyError($json, 'Login error!','cpt');
            agAnswerJSON($json); // вывoдим мaссив oтвeтa
            //echo json_encode($json); // вывoдим мaссив oтвeтa
            die(); // умирaeм

        }

    } else {
        // какая-то ошибка. Ожидаем только
        $json = initJSONReplyError();
        setJSONReplyError($json,'Something wrong :(!');
        agAnswerJSON($json); // вывoдим мaссив oтвeтa
        die(); // умирaeм
    }
}


function agHandleWeb (){

}