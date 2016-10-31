<!DOCTYPE html>
<HTML>
<HEAD>
	<TITLE> Cambie su planta </TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="funciones.css" type="text/css">
	<style>
	#map-canvas {
    	height: 300px; width:100%; margin: 0; padding: 0;
    }
	</style>

	<!--Funcion para iniciar el mapa-->
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEv3nlDR3lRwympRM7XeE98J_BZatCgP8">
	</script>
	
	<script>
	//Funcion para iniciar el mapa
	var map;
	var marker;
	function initMap() {
		map = new google.maps.Map(document.getElementById('map-canvas'),
			{
			center: {lat: -33.457383, lng: -70.664347},
			zoom: 15
			}
		);		
	}

	google.maps.event.addDomListener(window, 'load', initMap);

	//Funcion del geocoder
	var geocoder;
	function initGeo() {
		geocoder = new google.maps.Geocoder();
    }
    google.maps.event.addDomListener(window, 'load', initGeo);

	function initMark(place, n){
		//mejor que reciba n y con eso saco el resto
		var planta_nombre = getNombre(n);
    	var tipo_planta = getTipo(n);
    	var email = getMail(n);
    	var fono = getFono(n);
    	var comuna = getComuna(n);
    	var region = getRegion(n);
    	var id = getId(n);

		var marker = new google.maps.Marker(
			{
			position: place,
			map: map,
			title: planta_nombre+"\n"+tipo_planta
			}
		);

		var contentString =
		"<h1>"+planta_nombre+"</h1>"+
		"<p>"+"Tipo: "+tipo_planta+"</p>"+
		"<p>"+"Correo: "+email+"</p>"+
		"<p>"+"Telefono: "+fono+"</p>"+
		"<p>"+"Comuna: "+comuna+"</p>"+
		"<p>"+"Región: "+region+"</p>"+
		"<p><a href=awt3planta.php?id="+id+">Mas información</a></p>";



		var infowindow = new google.maps.InfoWindow({
			content: contentString
		});


		marker.addListener('click', function() {
			infowindow.open(map, marker);
  		});
	}

	function initMarkUser(place){
		var marker = new google.maps.Marker(
			{
			position: place,
			map: map,
			title: "Su ubicación",
			icon: {
				path: google.maps.SymbolPath.CIRCLE,
				strokeColor: "green",
				scale: 10
			}
			}
		);

		marker.addListener('click', function() {
			marker.setTitle('su ubicación obtenida automáticamente');
  		});
	}

    function resolveGeo(n){ //cambiar address por la direccion de la base de datos
    	var addressIn = getDirection(n);
    	var geocoder = new google.maps.Geocoder();
	//Aqui el alert
	
		geocoder.geocode( { address: addressIn}, function(results, geo_status) {
			console.log(geo_status); //DEBUG
			if (geo_status == google.maps.GeocoderStatus.OK) {
				initMark(results[0].geometry.location, n);
				//document.getElementById('resultado').innerHTML = JSON.stringify(results, null, " ");
			}
		});
    }

    function resolveGeos(){
    	resolveGeo(0);
    	resolveGeo(1);
    	resolveGeo(2);
    	resolveGeo(3);
    	resolveGeo(4);
    }

	if ("geolocation" in navigator) {
		/* geolocation is available */
		var gotPos = 0;
		var lat = 0;
		var lon = 0;
		navigator.geolocation.getCurrentPosition(function(position) {
			gotPos = 1;
			centerMap(position.coords.latitude, position.coords.longitude);
			lat = position.coords.latitude;
			lon = position.coords.longitude;
			place = {lat: lat, lng:lon};
			initMarkUser(place);
			ubicacionFail();
		});
	} else {
		/* geolocaiton IS NOT available */
		window.alert("No hay geolocation");
	}

	function centerMap(lat, lon){
		map.setCenter({lat: lat, lng: lon})
	}

	</script>
	

</HEAD>

<BODY onLoad="resolveGeos()">

	<?php

	//Hacer la conexion
	include_once('dbconfig.php');
	$db = DbConfig::getConnection();
	// Check connection
	if ($db->connect_error){
		die("Connection failed: " . $db->connect_error);
	}

	//Si nos dieron datos, insertamos

	if(isset($_POST['nombre-planta']) && isset($_POST['tipo-planta']) && isset($_POST['descripcion-planta']) && isset($_POST['email-contacto']) && isset($_POST['fono-contacto']) && isset($_POST['comuna-entrega']) && isset($_FILES['foto-planta1'])){

		//Tipo de planta
		if($_POST['tipo-planta'] == "5"){
			$sql_revisar_otro = sprintf(
				"SELECT descripcion, id
				FROM tipo_planta
				WHERE descripcion = '%s'", $_POST['otro-planta']
			);
			$result = $db->query($sql_revisar_otro);
			$res = array();
			$res[] = $result->fetch_assoc();
			print_r($res);
			$found = 0;
			foreach($res as $value){
				if($value['descripcion']==htmlspecialchars($_POST['otro-planta'])){
					$tipo_planta_final = $value['id'];
					$found = 1;
				}
			}
			if($found == 0){
				$sql_ingresar_otro = sprintf("INSERT INTO tipo_planta (descripcion) VALUES ('%s')", $_POST['otro-planta']);
				$result = $db->query($sql_ingresar_otro);
				$tipo_planta_final = $db->insert_id;
			}
		}
		else{
			$tipo_planta_final = htmlspecialchars($_POST['tipo-planta']);
		}

		//Ingresar informacion de la planta
		$sql = sprintf(
			"INSERT INTO planta (nombre, tipo_planta, descripcion, fecha_ingreso, email_contacto, fono_contacto, comuna_entrega, intercambio_por)
			VALUES ('%s',%d,'%s','%s','%s','%s',%d,'%s');",htmlspecialchars($_POST['nombre-planta']), $tipo_planta_final, htmlspecialchars($_POST['descripcion-planta']), date("Y-m-d H:i:s"), htmlspecialchars($_POST['email-contacto']), htmlspecialchars($_POST['fono-contacto']), htmlspecialchars($_POST['comuna-entrega']), htmlspecialchars($_POST['intercambio-por'])
			);
		if(!$db->query($sql)){ //Se ejecuta la query y se verifica si fue exitosa
			echo "Table insert failed: (" . $db->errno . ") " . $db->error ."<br/>";
		}

		//Ingresar fotos
		$planta = $db->insert_id;
		$fotofolder = "imagenes/";
		$fotofile = time().basename($_FILES['foto-planta1']['name']);
		$fotofull = $fotofolder.$fotofile;

		move_uploaded_file($_FILES['foto-planta1']['tmp_name'], $fotofull);

		$sqlfoto = sprintf(
			"INSERT INTO fotografia (ruta_archivo,nombre_archivo,planta)
			VALUES ('%s','%s',%d);", "imagenes/".$fotofile, $fotofile, $db->insert_id
			);
		if(!$db->query($sqlfoto)){ //Se ejecuta la query y se verifica si fue exitosa
			echo "Table insert failed: (" . $db->errno . ") " . $db->error ."<br/>";
			return;
		}

		if(isset($_FILES['foto-planta2'])){
			$fotofile = time().basename($_FILES['foto-planta2']['name']);
			$fotofull = $fotofolder.$fotofile;

			move_uploaded_file($_FILES['foto-planta2']['tmp_name'], $fotofull);

			$sqlfoto = sprintf(
			"INSERT INTO fotografia (ruta_archivo,nombre_archivo,planta)
			VALUES ('%s','%s',%d);", "imagenes/".$fotofile, $fotofile, $planta
			);
			if(!$db->query($sqlfoto)){ //Se ejecuta la query y se verifica si fue exitosa
			echo "Table insert failed: (" . $db->errno . ") " . $db->error ."<br/>";
			return;
			}
		}

		if(isset($_FILES['foto-planta3'])){
			$fotofile = time().basename($_FILES['foto-planta3']['name']);
			$fotofull = $fotofolder.$fotofile;

			move_uploaded_file($_FILES['foto-planta3']['tmp_name'], $fotofull);

			$sqlfoto = sprintf(
			"INSERT INTO fotografia (ruta_archivo,nombre_archivo,planta)
			VALUES ('%s','%s',%d);", "imagenes/".$fotofile, $fotofile, $planta
			);
			if(!$db->query($sqlfoto)){ //Se ejecuta la query y se verifica si fue exitosa
			echo "Table insert failed: (" . $db->errno . ") " . $db->error ."<br/>";
			return;
			}
		}

		if(isset($_FILES['foto-planta4'])){
			$fotofile = time().basename($_FILES['foto-planta4']['name']);
			$fotofull = $fotofolder.$fotofile;

			move_uploaded_file($_FILES['foto-planta4']['tmp_name'], $fotofull);

			$sqlfoto = sprintf(
			"INSERT INTO fotografia (ruta_archivo,nombre_archivo,planta)
			VALUES ('%s','%s',%d);", "imagenes/".$fotofile, $fotofile, $planta
			);
			if(!$db->query($sqlfoto)){ //Se ejecuta la query y se verifica si fue exitosa
			echo "Table insert failed: (" . $db->errno . ") " . $db->error ."<br/>";
			return;
			}
		}

		if(isset($_FILES['foto-planta5'])){
			$fotofile = time().basename($_FILES['foto-planta5']['name']);
			$fotofull = $fotofolder.$fotofile;

			move_uploaded_file($_FILES['foto-planta5']['tmp_name'], $fotofull);

			$sqlfoto = sprintf(
			"INSERT INTO fotografia (ruta_archivo,nombre_archivo,planta)
			VALUES ('%s','%s',%d);", "imagenes/".$fotofile, $fotofile, $planta
			);
			if(!$db->query($sqlfoto)){ //Se ejecuta la query y se verifica si fue exitosa
			echo "Table insert failed: (" . $db->errno . ") " . $db->error ."<br/>";
			return;
			}
		}
	}
	?>

	<a class="" id="fail_ubicacion">no pudimos determinar su ubicacion!</a>
	<h1>Cambie su planta</h1>

	<!-- Mapa -->
	<div id="map-canvas"></div>
	<!-- Fin del Mapa-->


	<form action="awt3ingresar.php">
		<input type="submit" value="Agregar Planta">
	</form>
	<?php
	//Ver en que pagina de elementos estamos
	if (isset($_GET['pl_ind'])){
		$plantas_indice = 'pl_ind';
	}
	else{
		$plantas_indice = 0;
	}

	//Consulta de elementos en base de datos
	$sql = sprintf("SELECT PL.id AS pl_id,
		PL.nombre AS pl_nombre,
		TP.descripcion AS tp_descripcion,
		PL.descripcion AS pl_descripcion,
		PL.fecha_ingreso,
		PL.email_contacto AS pl_email,
		PL.fono_contacto AS pl_fono,
		CO.nombre AS co_nombre,
		PL.intercambio_por,
		RE.nombre AS re_nombre
		FROM planta PL, tipo_planta TP, comuna CO, region RE
		WHERE TP.id=PL.tipo_planta
		AND PL.comuna_entrega=CO.id
		AND RE.id=CO.region_id
		ORDER BY PL.fecha_ingreso
		DESC LIMIT %s, %s", $plantas_indice, $plantas_indice+5
		);
	$result = $db->query($sql);
	$res = array();
	while ($row = $result->fetch_assoc()) {
		$res[] = $row;
	}

	//Guardar para mostrar en el mapa
	$directions = $res;
	?>

	<table style="width:100%">
		<tr>
			<td>Nombre planta</td>
			<td>Tipo</td>
			<td>Descripción</td>
			<td>Comuna entrega</td>
			<td>Nombre contacto</td>
			<td>N° Fotos</td>
		</tr>
	<?php
			if(count($res) > 0)
			foreach($res as $value){
				?>
				<tr>
				<td>
				<a href=<?php echo "awt3planta.php?id=".$value['pl_id']?>>
				<?php print sprintf("%s", $value['pl_nombre'])?>
				</a>
				</td>
				<td>
				<a>
				<?php print sprintf("%s", $value['tp_descripcion'])?>
				</a>
				</td>
				<td>
				<a>
				<?php print sprintf("%s", $value['pl_descripcion'])?>
				</a>
				</td>
				<td>
				<a>
				<?php print sprintf("%s", $value['co_nombre'])?>
				</a>
				</td>
				<td>
				<a>
				<?php print sprintf("%s", 'nombre contacto')?>
				</a>
				</td>
				<td>
				<a>
				<?php print sprintf("%s", '5')?>
				</a>
				</td>
				</tr>
				<?php
			}
			else{
				?> <td>Ninguna planta todavía. ¡Ingrese la suya! </td><?php
			}
			?>
	</table>
	<!-- Avanzar indice de plantas en tabla -->
	<?php if(isset($_GET['plind'])){
		$pl_ind_actual = $_GET['plind'];
	}
	else{
		$pl_ind_actual = 0;
	}
	?>

	<form action=<?php echo "awt3principal.php?plind=".$pl_ind_actual ?>>
		<input type="submit" value="Avanzar comentarios">
	</form>

	<!-- Obtener el string de direccion-->
	<script>
		function getDirection(n){
			<?php 
			$i = 0;
			foreach ($directions as $direction) {
				echo "if(n==".$i."){return '".$direction['co_nombre'].", ".$direction['re_nombre'].", Chile'} ";
				$i+=1;
			}
			?>
		}

		function getNombre(n){
			<?php 
			$i = 0;
			foreach ($directions as $direction) {
				echo "if(n==".$i."){return '".$direction['pl_nombre']."'} ";
				$i+=1;
			}
			?>
		}

		function getTipo(n){
			<?php 
			$i = 0;
			foreach ($directions as $direction) {
				echo "if(n==".$i."){return '".$direction['tp_descripcion']."'} ";
				$i+=1;
			}
			?>
		}

		function getMail(n){
			<?php 
			$i = 0;
			foreach ($directions as $direction) {
				echo "if(n==".$i."){return '".$direction['pl_email']."'} ";
				$i+=1;
			}
			?>
		}

		function getFono(n){
			<?php 
			$i = 0;
			foreach ($directions as $direction) {
				echo "if(n==".$i."){return '".$direction['pl_fono']."'} ";
				$i+=1;
			}
			?>
		}

		function getComuna(n){
			<?php 
			$i = 0;
			foreach ($directions as $direction) {
				echo "if(n==".$i."){return '".$direction['co_nombre']."'} ";
				$i+=1;
			}
			?>
		}

		function getRegion(n){
			<?php 
			$i = 0;
			foreach ($directions as $direction) {
				echo "if(n==".$i."){return '".$direction['re_nombre']."'} ";
				$i+=1;
			}
			?>
		}

		function getId(n){
			<?php 
			$i = 0;
			foreach ($directions as $direction) {
				echo "if(n==".$i."){return '".$direction['pl_id']."'} ";
				$i+=1;
			}
			?>
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

		function ubicacionFail(){
			toggleElement("fail_ubicacion");
		}
	</script>

</BODY>
</HTML>
