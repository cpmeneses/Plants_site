<?php
/* Clase que crea una coneción a la base de datos
* Ejemplo de uso: 
$db = DbConfig::getConnection();
$sql = "SELECT id, nombre FROM region"
$result = $db->query($sql); 
$res = array();
while ($row = $result->fetch_assoc()) {
	$res[] = $row;
}
$db->close();
Resultados están en arreglo $res
*/
class DbConfig{
	private static $db_name = "tarea2";//Base de datos de la app
	private static $db_user = "root";//Usuario MySQL
	private static $db_pass = "";//Password
	private static $db_host = "localhost";//Servidor donde esta alojado, puede ser 'localhost' o una IP (externa o interna).
	
	public static function getConnection(){
		//Estamos asumiendo el puerto por defecto 8889.
		//Cambiamos a 3306
		$mysqli = new mysqli(self::$db_host, self::$db_user, self::$db_pass, self::$db_name, 3306);
		$mysqli->set_charset("utf8"); //Muy importante!!
		return $mysqli;
	}
}
?>
