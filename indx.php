<?php if (Auth\User::isAuthorized()): ?>
    <?php require './course.php';?>
<?php else: ?>
    <?php require './login.php';?>
<?php endif; ?>