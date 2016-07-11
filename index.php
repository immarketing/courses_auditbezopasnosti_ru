<?php
/**
 * Created by PhpStorm.
 * Входящая точка для всех рабочих скриптов
 * User: AVGorbunov
 * Date: 11.07.2016
 * Time: 9:06
 */

// определяем, запущены ли мы из консоли, или нет.

$is_console = PHP_SAPI == 'cli' || (!isset($_SERVER['DOCUMENT_ROOT']) && !isset($_SERVER['REQUEST_URI']));

require 'vendor/autoload.php';
require_once './php.src/aglib.php';
require_once './php.src/agactions.php';

$actionValue = "";

if ($is_console) {
    require_once './php.src/agrunconsole.php';
    agHandleConsole();
    $options = getopt("a:");
    if ($options) {
        if ($options['a']) {
            $actionValue = $options['a'];
        }
    }
    //var_dump($options);
} else {
    require_once './php.src/agrunweb.php';
    agHandleWeb();
    $actionValue = $_GET['action'];
}

$actions = agGetActionsList($is_console);

foreach ($actions as $k => $v) {
    if ("".$k === "".$actionValue) {
        if ( is_callable ($v)) {
            $v();
        }
    }
}

