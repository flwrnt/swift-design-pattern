<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="content-type" content="application/json">
        <title>notifications</title>
    </head>
    <body>
<?php
    $server = '127.0.0.1';
    $user = 'root';
    $password = '';
    $bdd = 'notifications';
    
    try {
        $pdo = new PDO('mysql:host=' . $server . ';dbname=' . $bdd . ';charset=utf8', $user, $password,
                       array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'UTF8\''));
        
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
    } catch (PDOException $e) {
        var_dump($e); die();
    }
    
    $id = 0;
    if (isset($_POST) && !empty($_POST)) {
        if (isset($_POST['last_id']) && !empty($_POST['last_id'])) {
            if (is_numeric($_POST['last_id'])) {
                $id = $_POST['last_id'];
            }
            else {
                echo "error: id is not numeric";		}
        }
    }
    
    $req = $pdo->query('SELECT * FROM notification where id > ' . $id);
    $notifications = $req->fetchAll(PDO::FETCH_OBJ);
    
    $result = array();
    foreach ($notifications as $notif) {
        $attr = get_object_vars($notif);
        
        foreach ($attr as $key => $value) {
            if (is_null($value)) $attr[$key] = "";
        }
        array_push($result, $attr);
    }
    
    echo json_encode($result);
?>
    </body>
</html>
