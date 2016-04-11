<?php

/**
 * Created by PhpStorm.
 * User: AlGO
 * Date: 02.04.2016
 * Time: 0:01
 */

require_once dirname(__FILE__) . '/../MainClass.php';

class MainClassTest extends PHPUnit_Framework_TestCase
{
    function testCanCreateAMainClass() {
        $mainClass = new MainClass();
    }

}
