<?php
/**
 * Created by PhpStorm.
 * список всех ключей (и соответствующх действий)
 * User: AVGorbunov
 * Date: 11.07.2016
 * Time: 9:12
 */

require_once 'agconst.php';

function agGetActionsList ($isConsole = false){
    $result = [    ];
    $res_cons = [
        // имя_параметра = имя_вызываемой_процедуры
        '__help' => 'agHandle__help' // показываем список всех возможных экшенов
        , '__testcrypt' => 'agHandle__testcrypt' // пробуем хэширование паролей
        , '__updppl' => 'agHandle__updatePupilsInDB' // корректируем таблицу обучающихся в БД
    ];
    $res_web = [
        AG_AN_TIC =>'agHandleTic', // обрабатываем Tic-Tac от клиента во время прохождения тестирования
        AG_AN_GETTESTINGJSON =>'agHandleGetTestingJSON', // обрабатываем Tic-Tac от клиента во время прохождения тестирования
    ];

    if ($isConsole) {
        $result = $result + $res_cons;
    } else {
        $result = $result + $res_web;
    }

    return $result;
}