<?php

class Connection {

    protected static $instance;

    private static $dsn = 'mysql:host=localhost;dbname=E-exam';

    private static $username = 'root';

    private static $password = '';

    private function __construct() {
        try {
            self::$instance = new PDO(self::$dsn, self::$username, self::$password);
          //  echo "ff";
        } catch (PDOException $e) {
            echo "MySql Connection Error: " . $e->getMessage();
        }
    }

    public static function getInstance() {
        if (!self::$instance) {
            new Connection();
        }

        return self::$instance;
    }

}

