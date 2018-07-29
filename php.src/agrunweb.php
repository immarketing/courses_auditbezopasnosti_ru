<?php

use ReCaptcha\ReCaptcha;

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

    $tstJSON = $tst['JSON']; // в переменной хранится JSON тестирования
    $tstData = json_decode($tstJSON);
    $tstData = $tstData->data;

    $tstDataCorrAnsw = [];
    foreach ($tstData as $k=>$v) {
        //
        //$k ++;
        if ($v->qText){
            $tstDataCorrAnsw[$v->UID] = $v->qAnsCorr;
        }
    }

    $answrs = [];
    $answrsHash = [];
    // тут необходимо сохранить результаты тестирования в базе данных
    // пробегаемся по полученным результатам и вылавливаем ответы
    //     [_q00UID] => b113b166-c4b0-4117-8113-69fefcd35258
    // [_q00ansno] => 1
    foreach ($_POST as $k=>$v) {
        $matches = [];
        if (preg_match('/^_q(\d+)UID$/i', $k, $matches)) {
            //echo "Вхождение найдено.";
            // $matches[1] - номер вопроса
            $answrs[0+$matches[1]]['UID'] = $v;
            //$k ++;
        } else if (preg_match('/^_q(\d+)ansno$/i', $k, $matches)) {
            //echo "Вхождение найдено.";
            // $matches[1] - номер вопроса
            $answrs[0+$matches[1]]['ANO'] = $v;
            //$k ++;
        }
    }
    foreach ($answrs as $k=>$v) {
        $answrsHash[$v['UID']]=$v['ANO'];
    }

    $answersToStore = [
        qCount => count ($tstDataCorrAnsw) // всего вопросов
        , corrCount => 0 // всего правильных ответов
        , resPercent => 0 // итоговый процент
        , aData => $answrsHash // данные ответов в виде хеша
        , qData => $tstDataCorrAnsw // данные вопрос в виде хеша
    ];
    foreach ($tstDataCorrAnsw as $k=>$v) {
        if ($v) {
            if ($answrsHash[$k]){
                if ($v == $answrsHash[$k]) {
                    $answersToStore['corrCount'] ++;
                }
            }
        }
    }
    if ($answersToStore['qCount']) {
        $answersToStore['resPercent'] = $answersToStore['corrCount'] / $answersToStore['qCount'] * 100;
    }

    $user = new Auth\User ();
    $user->readFromDB();
    setTestResultForPPLID($user->getID(), json_encode($answersToStore));

    $res['resultProcent'] = $answersToStore['resPercent'];

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

    // {"qCount":12,"corrCount":1,"resPercent":8.3333333333333,"aData":{"b113b166-c4b0-4117-8113-69fefcd35258":"1","b346f89c-4311-4346-8299-dbf8c48b59a5":"4","91f3c142-be82-488c-9fed-16fbd89ed3c6":"2","fdb98a43-5a37-4ca5-a864-bac079d17b9e":"6","8c16e8ce-b8a8-40a6-bebc-97b207593f38":"5","c137e133-5b83-4dec-942e-2b0bf60f32b2":"3"},"qData":{"b113b166-c4b0-4117-8113-69fefcd35258":1,"b346f89c-4311-4346-8299-dbf8c48b59a5":"","91f3c142-be82-488c-9fed-16fbd89ed3c6":"","fdb98a43-5a37-4ca5-a864-bac079d17b9e":"","8c16e8ce-b8a8-40a6-bebc-97b207593f38":"","c137e133-5b83-4dec-942e-2b0bf60f32b2":"","f76ff71a-041b-4416-9b07-bd68f88d36c5":"","7cbb8c73-5e55-4113-a010-bc240141e813":"","554e8335-f536-48bf-9718-8650d6becb7a":"","fa782a5a-6126-4d09-af3c-78627f358a76":"","1f9ea0eb-d53b-47ed-9358-a5157b4a398a":"","bc031d41-7961-47de-95ca-9dd669247c25":""}}

    $res['isTestingCompleted'] = 0;
    $res['testingResult'] = 0;

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
            $res['isTestingCompleted'] = $user->getIsTestCompleted();
            $tstRslt = $user->getTestResult();
            if ($tstRslt) {
                $tstRsltJSON = json_decode($tstRslt);
                $res['testingResult'] = $tstRsltJSON->resPercent;
            } else {
                $res['testingResult'] = 0;
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

        $recaptcha = new ReCaptcha($secret);
        $resp = $recaptcha->verify($gcp, $_SERVER['REMOTE_ADDR']);

        if ($resp->isSuccess() ) {
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