<?php

namespace Auth;

class User
{
    private $id;
    private $username;
    private $db;
    private $user_id;
    private $user;

    /*
    private $db_host = "localhost";
    private $db_name = "testdb";
    private $db_user = "testdb";
    private $db_pass = "testdb";
    */

    private $is_authorized = false;

    public function __construct($username = null, $password = null)
    {
        $this->username = $username;
        //$this->connectDb($this->db_name, $this->db_user, $this->db_pass, $this->db_host);
    }

    public function __destruct()
    {
        $this->db = null;
    }

    public static function isAuthorized()
    {
        //echo 'isAuthorized '.$_SESSION.'<br>';
        if (!empty($_SESSION["user_id"])) {
            return (bool) $_SESSION["user_id"];
        }
        return false;
    }

    public function readFromDB() {
        try {
            $db = connectDB();
            $query = "select id,login,pwd1,courseID, testID from agpupils where
            id = ? limit 1";
            $sth = $db->prepare($query);

            $sth->bind_param('s', $_SESSION["user_id"]);

            $sth->execute( );

            $result = $sth->get_result();

            $this->user = $result->fetch_assoc();

        } catch (Exception $e){
            throw $e;
        }
        if ($this->user) {
            return true;
        } else {
            return false;
        }
    }
    public function getCourseID (){
        if ($this->user) {
            return $this->user['courseID'];
        } else {
            return false;
        }
    }
    public function getTestID (){
        if ($this->user) {
            return $this->user['testID'];
        } else {
            return false;
        }
    }
    public function authorize($username, $password, $remember=false)
    {
        try {
            $db = connectDB();
            $query = "select id,login, pwd1 from agpupils where
            login = ? and pwd1 = ? limit 1";
            $sth = $db->prepare($query);

            $sth->bind_param('ss', $username, $password );

            $sth->execute( );

            $result = $sth->get_result();

            $this->user = $result->fetch_assoc();

        } catch (Exception $e){

        }

    	/*
        $query = "select id, username from users where
            username = :username and password = :password limit 1";
        $sth = $this->db->prepare($query);
        $salt = $this->getSalt($username);

        if (!$salt) {
            return false;
        }

        $hashes = $this->passwordHash($password, $salt);
        $sth->execute(
            array(
                ":username" => $username,
                ":password" => $hashes['hash'],
            )
        );
        $this->user = $sth->fetch();
        */
        if (! ($this->user )) {
            $this->is_authorized = false;
        } else {
            /*
        	$this->user['id'] = '111';
        	$this->user['username'] = '111';
            */
        	 
            $this->is_authorized = true;
            $this->user_id = $this->user['id'];
            $this->saveSession($remember);
        }

        return $this->is_authorized;
    }

    public function logout()
    {
        if (!empty($_SESSION["user_id"])) {
            unset($_SESSION["user_id"]);
        }
    }

    private function saveSession($remember = true, $http_only = true, $days = 7)
    {
        $_SESSION["user_id"] = $this->user_id;

        if ($remember || true) {
            // Save session id in cookies
            $sid = session_id();

            $expire = time() + 1/24* 24 * 3600;
            $domain = ""; // default domain
            $secure = false;
            $path = "/";
            $http_only = false;

            $cookie = setcookie("sid", $sid, $expire, $path, $domain, $secure, $http_only);
        }
    }

    /*
    private function create($username, $password) {
        $user_exists = $this->getSalt($username);

        if ($user_exists) {
            throw new \Exception("User exists: " . $username, 1);
        }

        $query = "insert into users (username, password, salt)
            values (:username, :password, :salt)";
        $hashes = $this->passwordHash($password);
        $sth = $this->db->prepare($query);

        try {
            $this->db->beginTransaction();
            $result = $sth->execute(
                array(
                    ':username' => $username,
                    ':password' => $hashes['hash'],
                    ':salt' => $hashes['salt'],
                )
            );
            $this->db->commit();
        } catch (\PDOException $e) {
            $this->db->rollback();
            echo "Database error: " . $e->getMessage();
            die();
        }

        if (!$result) {
            $info = $sth->errorInfo();
            printf("Database error %d %s", $info[1], $info[2]);
            die();
        } 

        return $result;
    }

    public function connectdb($db_name, $db_user, $db_pass, $db_host = "localhost")
    {
    	return $this;
    	try {
            $this->db = new \pdo("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
        } catch (\pdoexception $e) {
            echo "database error: " . $e->getmessage();
            die();
        }
        $this->db->query('set names utf8');

        return $this;
    }
    private function passwordHash($password, $salt = null, $iterations = 10)
    {
        $salt || $salt = uniqid();
        $hash = md5(md5($password . md5(sha1($salt))));

        for ($i = 0; $i < $iterations; ++$i) {
            $hash = md5(md5(sha1($hash)));
        }

        return array('hash' => $hash, 'salt' => $salt);
    }

    public function getSalt($username) {
        $query = "select salt from users where username = :username limit 1";
        $sth = $this->db->prepare($query);
        $sth->execute(
            array(
                ":username" => $username
            )
        );
        $row = $sth->fetch();
        if (!$row) {
            return false;
        }
        return $row["salt"];
    }
    */
}
