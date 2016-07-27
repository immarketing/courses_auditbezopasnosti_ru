<?php
/**
 * Created by PhpStorm.
 * User: AVGorbunov
 * Date: 27.07.2016
 * Time: 13:58
 */
?>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <meta name="description"
          content='НОУ ДОПК "Школа безопасности" оказывает образовательные услуги по направлению "Пожарная безопасность". В том числе, обучение пожарно-техническому минимуму для руководителей и работников организаций. Наши услуги всегда качественны, а цены - приятные!'>
    <meta name="author" content='НОУ ДОПК "Школа безопасности"'>

    <title>НОУ ДОПК "Школа безопасности". Курс ПТМ для руководителей</title>

    <link rel="icon" type="image/png" href="/images/favicon-nrm.png"/>

    <!-- Bootstrap core CSS ->
    <link href="./css/bootstrap.css" rel="stylesheet">

    <!-- Bootstrap core CSS включен теперь в мой ЦСС - компилируется из бутстрапа -->
    <link href="./css/courses.css" rel="stylesheet">

    <!-- Magnific Popup core CSS file -->
    <link rel="stylesheet" href="./css/magnific-popup.css">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="./css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <link
        href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700|Open+Sans+Condensed:300,700&subset=latin,cyrillic'
        rel='stylesheet' type='text/css'>

    <link rel="stylesheet" type="text/css" href="./css/animate.css"/>
    <link href="./css/font-awesome.css" rel="stylesheet">

    <!-- Bootstrap treeview core CSS -->
    <link href="./css/bootstrap-treeview.min.css" rel="stylesheet">

</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top ">
    <div class="container-fluid ">
        <div class="navbar-header">
            <span class="navbar-brand">
                НОУ ДОПК "Школа безопасности"
            </span>
            <!--
            <a class="navbar-brand" href="#">НОУ ДОПК "Школа безопасности"</a> -->
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Выйти</a></li>
        </ul>
    </div>
</nav>

<div class="container-fluid" id="agWrongResolution">
    <div class="row" id="agWrongResolutionRow">
        Пожалуйста, используйте верное разрешение и правильный браузер.
        Заранее большое спасибО!
    </div>
</div>

<div class="container-fluid" id="agContentContainer">
    <div class="row" id="agContentRow">
        <div class="col-md-3" id="agLeftCol">
            <div id="agTOCTree">The tree</div>
            agLeftCol
        </div>
        <div class="col-md-9" id="agRightCol">
            <div id="agLearning">
                <iframe src="https://docs.google.com/document/d/1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw/pub?embedded=true"
                        name="agContentFrame" id="agContentFrameID"></iframe>
                agLearning
            </div>

            <div id="agTesting" class="agDisplayNone">
                <div id="agTestingQuest" class="container-fluid">
                    <div class="panel panel-default">
                        <div class="panel-heading">Вопрос №<span id="agTestingAnsrsCurAns"></span> из <span id="agTestingAnsrsTotal"></span></div>

                        <div class="panel-body" id="agTestingAnsrsAnsText"><p>
                                Текст вопроса
                            </p></div>
                        <div class="panel-footer">
                            <div id="agTestingAnswrs1" class="container-fluid">
                                <div class="col-xs-2">

                                </div>
                                <div class="col-xs-2 answersContainer"><input type="radio" name="optradio" id="agTestingAnswrRdo1">
                                    <label class="radio-inline" id="agTestingAnswrOpt1" for="agTestingAnswrRdo1">Option 1</label>
                                </div>
                                <div class="col-xs-1">
                                </div>
                                <div class="col-xs-2 answersContainer"><input type="radio" name="optradio"  id="agTestingAnswrRdo2">
                                    <label class="radio-inline" id="agTestingAnswrOpt2" for="agTestingAnswrRdo2">Option 2</label>
                                </div>
                                <div class="col-xs-1">

                                </div>
                                <div class="col-xs-2 answersContainer"><input type="radio" name="optradio"  id="agTestingAnswrRdo3">
                                    <label class="radio-inline" id="agTestingAnswrOpt3" for="agTestingAnswrRdo3">Option 3</label>
                                </div>
                                <div class="col-xs-2">

                                </div>

                            </div>

                            <div id="agTestingAnswrs2" class="container-fluid">
                                <div class="col-xs-2">

                                </div>
                                <div class="col-xs-2 answersContainer"><input type="radio" name="optradio"  id="agTestingAnswrRdo4">
                                    <label class="radio-inline" id="agTestingAnswrOpt4" for="agTestingAnswrRdo4">Option 4</label>
                                </div>
                                <div class="col-xs-1">

                                </div>
                                <div class="col-xs-2 answersContainer"><input type="radio" name="optradio"  id="agTestingAnswrRdo5">
                                    <label class="radio-inline" id="agTestingAnswrOpt5" for="agTestingAnswrRdo5">Option 5</label>

                                </div>
                                <div class="col-xs-1">

                                </div>
                                <div class="col-xs-2 answersContainer"><input type="radio" name="optradio"  id="agTestingAnswrRdo6">
                                    <label class="radio-inline" id="agTestingAnswrOpt6" for="agTestingAnswrRdo6">Option 6</label>

                                </div>
                                <div class="col-xs-2">

                                </div>

                            </div>

                            <div id="agTestingAnswrBtns" class="container-fluid text-center">
                                <div class="col-xs-3"></div>
                                <div class="col-xs-2 text-center">
                                    <button id="agTestingAnswrBtnsPrev" type="button" class="btn btn-default btn-lg" onclick="agClickPrevBtn()">
                                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                    </button>
                                </div>
                                <div class="col-xs-2 text-center">
                                    <button id="agTestingAnswrBtnsNext" type="button" class="btn btn-default btn-lg" onclick="agClickNextBtn()">
                                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                    </button>
                                </div>
                                <div class="col-xs-2 text-center">
                                    <button id="agTestingAnswrBtnsDone" type="button" class="btn btn-default btn-lg" onclick="agClickDoneBtn()">
                                        <span class="glyphicon glyphicon-ok-circle" aria-hidden="true"></span> Завершить
                                    </button>
                                </div>

                                <div class="col-xs-3"></div>
                            </div>
                        </div>
                    </div>

                </div>
                agTesting
            </div>
            agRightCol
        </div>
        agContentRow
    </div>
</div>

<div class="container-fluid" id="agBottomContainer">
    <div class="row">
        agBottomContainer
    </div>
</div>


<script src="./js/jquery.js"></script>
<script src="./js/bootstrap.js"></script>
<!-- <script src="./js/jquery.viewportchecker.min.js"></script> -->
<script src="./js/bootstrap-treeview.min.js"></script>
<script src="./js/ie10-viewport-bug-workaround.js"></script>
<script src="./js/courses.js"></script>

<!-- Magnific Popup core JS file -->
<script src="./js/jquery.magnific-popup.js"></script>

</body>
</html>
