<!DOCTYPE html>
<HTML>
	<?php
		//Hacer la conexion
		include_once('dbconfig.php');
		$db = DbConfig::getConnection();
		// Check connection
		if ($db->connect_error){
			die("Connection failed: " . $db->connect_error);
		}

		//Si nos dieron datos, insertamos
		if(isset($_POST['nombre_comentario']) && isset($_POST['caja_comentario']) && isset($_GET['id'])){
		$sql = sprintf(
			"INSERT INTO comentario (comentario, nombre_comentarista, fecha, planta) VALUES ('%s','%s','%s',%s);",htmlspecialchars($_POST['caja_comentario']), htmlspecialchars($_POST['nombre_comentario']), date("Y-m-d H:i:s"), htmlspecialchars($_GET['id'])
			);
		if(!$db->query($sql)){ //Se ejecuta la query y se verifica si fue exitosa
			echo "Table insert failed: (" . $db->errno . ") " . $db->error ."<br/>";
			return;
		}
		}

		//Obtener informacion
		$infosql = sprintf(
			"SELECT PL.id, PL.nombre AS pl_nombre, TP.descripcion AS tp_descripcion, PL.descripcion as pl_descripcion, PL.fecha_ingreso, PL.email_contacto, PL.fono_contacto, CO.nombre AS co_nombre, PL.intercambio_por FROM planta PL, tipo_planta TP, comuna CO WHERE PL.id=%s AND TP.id=PL.tipo_planta AND PL.comuna_entrega=CO.id;", $_GET['id']
		);

		if(!($result = $db->query($infosql))){ //Se ejecuta la query y se verifica si fue exitosa
			echo "Table insert failed: (" . $db->errno . ") " . $db->error ."<br/>";
			return;
		}
		$res = array();
		$res[] = $result->fetch_assoc();
	?>
<HEAD>
	<TITLE><?php print sprintf("%s", $res[0]['pl_nombre'])?></TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<link rel="stylesheet" href="funciones.css" type="text/css">
</HEAD>
<BODY>

	
	<pre>
	</pre>

	<H1><?php print sprintf("%s", $res[0]['pl_nombre'])?></H1>
	Tipo: <?php print sprintf("%s", $res[0]['tp_descripcion'])?>
	<br>
	Descripción: <?php print sprintf("%s", $res[0]['pl_descripcion'])?>
	<br>
	Comuna entrega: <?php print sprintf("%s", $res[0]['co_nombre'])?>
	<br>
	Nombre contacto: Nombre contacto
	<br>
	Fotografías:
	<br>

	<!-- Lista de fotos subidas-->
	<?php
		//Obtener fotografias
		$fotosql = sprintf(
			"SELECT id, ruta_archivo, nombre_archivo, planta FROM fotografia WHERE planta=%s;", $_GET['id']
		);

		if(!($result = $db->query($fotosql))){ //Se ejecuta la query y se verifica si fue exitosa
			echo "Table insert failed: (" . $db->errno . ") " . $db->error ."<br/>";
			return;
		}
		$res = array();
		$cuenta = 0;
		while ($row = $result->fetch_assoc()) {
		$res[] = $row;
		$cuenta = $cuenta + 1;
		}

		foreach($res as $value){
			?>
			<br>
			<img src=<?php print sprintf("%s", $value['ruta_archivo'])?> alt="limon1" height="120" width="120" onclick="imagenCrecer('limon1','001')">
			<br>
			<a class="elemento-escondido" id="001">Limonero. Árboles de macetero que dan limones. Providencia</a>
			<br>
			<?php
		}
	?>

	<br>
	N°Fotos: <?php print sprintf("%s", $cuenta)?>
	<br>
	<br>

	<!-- Comentarios -->
	<?php 
		$sqlcom = sprintf("SELECT id, comentario, nombre_comentarista, fecha, planta FROM comentario WHERE planta='%s' ORDER BY fecha DESC",$_GET['id']);
		$result = $db->query($sqlcom);
		$res = array();
		while ($row = $result->fetch_assoc()) {
			$res[] = $row;
		}
	?>

	<table style="width:100%">
		<tr>
			<td>Nombre del comentarista</td>
			<td>Fecha</td>
			<td>Contenido del Comentario</td>
		</tr>

	<?php
			if(count($res) > 0)
			foreach($res as $value){
				?>
				<tr>
				<td>
				<a>
				<?php print sprintf("%s", $value['nombre_comentarista'])?>
				</a>
				</td>
				<td>
				<a>
				<?php print sprintf("%s", $value['fecha'])?>
				</a>
				</td>
				<td>
				<a>
				<?php print sprintf("%s", $value['comentario'])?>
				</a>
				</td>
				</tr>
				<?php
			}
			else{
				?> <td>No hay comentarios todavía. ¡Se el primero!</td><?php
			}
			?>
	</table>

	<!-- Mostrar formulario de comentario -->
	<br>
	<button type="button" onclick="initComentario();">Agregar Nuevo Comentario</button>
	<br>

	<!-- Ingresar comentario -->
	<form name="forma" method="POST" id="id_formulario" action="#">	
		<a class="elemento-escondido" id="nom">Nombre:</a>
		<br>
		<input type="text" name="nombre_comentario" id="nombre_comentario" size="40" maxlength="40" class="elemento-escondido">

		<br>
		<a class="elemento-escondido" id="com">Comentario:</a>
		<br>
		<textarea name="caja_comentario" id="caja_comentario" class="elemento-escondido" rows="8" cols="80" maxlength="500"></textarea>

		<br>
		<button type="submit" id="boton_agregar" onclick="alert('Comentario agregado!')" class="elemento-escondido">
		Agregar Comentario</button>
	</form>


	<!-- Cancelar comentario -->
	<button type="button" id="boton_cancelar" onclick="alert('Comentario cancelado')" class="elemento-escondido">Cancelar</button>

	<!-- Botón retorno -->
	<form action="awt3principal.php">
		<input type="submit" value="Volver a la página principal">
	</form>

	<script>

		function imagenCrecer(idimagen,idtexto){
			var imagen = document.getElementById(idimagen);
			imagen.style.height = '600px';
			imagen.style.width = '800px';
			linea = document.getElementById(idtexto);
			if (linea.className == "elemento-escondido"){
				toggleElement(idtexto);
			}
		}

		function initComentario(){
			toggleElement("nom");
			toggleElement("nombre_comentario");
			toggleElement("com");
			toggleElement("caja_comentario");
			toggleElement("boton_agregar");
			toggleElement("boton_cancelar");
		}

		function toggleElement(elto){
			elto = document.getElementById(elto);
			if(elto.className == "elemento-escondido"){
				elto.className = "";
			}
			else{
				elto.className = "elemento-escondido";
			}
		} 
	</script>
</BODY>
</HTML>
