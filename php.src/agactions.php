<?php
/**
 * Created by PhpStorm.
 * список всех ключей (и соответствующх действий)
 * User: AVGorbunov
 * Date: 11.07.2016
 * Time: 9:12
 */
function agGetActionsList ($isConsole = false){
    $result = [    ];
    $res_cons = [
        '__help' => 'agHandle__help' // показываем список всех возможных экшенов
    ];
    $res_web = [
        'tic'=>'agHandleTic' // обрабатываем Tic-Tac от клиента во время прохождения тестирования
    ];

    if ($isConsole) {
        $result = $result + $res_cons;
    } else {
        $result = $result + $res_web;
    }

    return $result;
}