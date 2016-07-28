<?php
/**
 * Created by PhpStorm.
 * User: AVGorbunov
 * Date: 28.07.2016
 * Time: 13:49
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

    <title>НОУ ДОПК "Школа безопасности". Форма подключения</title>

    <link rel="icon" type="image/png" href="/images/favicon-nrm.png"/>

    <!-- Bootstrap core CSS включен теперь в мой ЦСС - компилируется из бутстрапа -->
    <link href="./css/courses.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="./css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <link
        href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700|Open+Sans+Condensed:300,700&subset=latin,cyrillic'
        rel='stylesheet' type='text/css'>

    <link rel="stylesheet" type="text/css" href="./css/animate.css"/>
    <link href="./css/font-awesome.css" rel="stylesheet">

    <script src="https://www.google.com/recaptcha/api.js" async defer></script>

</head>
<body>


<form class="form-signin ajax" method="post" action="" id="loginform">
    <div class="main-error alert alert-error hide"></div>

    <h2 class="form-signin-heading">Введите ваш логин и пароль</h2>
    <input name="username" type="text" class="input-block-level agCheckValue"
           placeholder="Логин" autofocus>
    <input name="password" type="password" class="input-block-level agCheckValue" placeholder="Пароль">
    <!-- <label
    class="checkbox">
    <input name="remember-me" type="checkbox"
    value="remember-me" checked> Remember me
</label>  -->
    <input type="hidden" name="act" value="login">

    <!--

    <input type="hidden" name="XDEBUG_SESSION_START" value="<?php echo $_REQUEST['XDEBUG_SESSION_START'];?>">
    <input type="hidden" name="KEY" value="<?php echo $_REQUEST['KEY'];?>">
    -->

    <div class="alert alert-info" >
        <p>
            Нет данных для входа? <a href="http://www.sfts.ru" target="_blank">Заключите договор на обучение.</a>

    </div>

    <div class="g-recaptcha" data-sitekey="6LcnDSYTAAAAAAddH-u5a0-secthUO8VJUYYHWF2"></div>

    <button class="btn btn-large btn-primary" type1="submit1" >Вход</button>
</form>


<script src="./js/jquery.js"></script>
<script src="./js/bootstrap.js"></script>
<script src="./js/ie10-viewport-bug-workaround.js"></script>

<script src="./js/login.js"></script>

</body>
</html>