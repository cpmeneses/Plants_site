<!DOCTYPE html>
<HTML>
<HEAD>
	<TITLE> Cambia tu planta </TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="funciones.css" type="text/css">
</HEAD>
<BODY>
	<?php
		include_once('dbconfig.php');
		$db = DbConfig::getConnection();
	
		// Check connection
		if ($db->connect_error){
			die("Connection failed: " . $db->connect_error);
		}
	?>

	<H1> Ingrese la información de su planta </H1>
	<form enctype="multipart/form-data" name="forma" method="POST" id="id_formulario" onSubmit="return validar();" action="awt3principal.php">
		<label>Nombre planta:</label><input type="text" name="nombre-planta" id="nombre_planta" size="40" maxlength="80">
		<br/>
	
		Tipo:
		<br>
        	<select name="tipo-planta" id="tipo_planta" onchange="agregarOtro();">
        		<option value=1>árbol
        		<option value=2>arbusto
        		<option value=3>mata
			<option value=4>hierba
			<option value=5>otro
        	</select>
		<br>

        	<input type="text" name="otro-planta" id="otro_planta" size="40" maxlength="100" class="elemento-escondido">
		<br>

        	Descripción:
		<br>
        	<textarea name="descripcion-planta" id="descripcion_planta" rows="8" cols="30" maxlength="1000"></textarea>
		<br>

		<br>
		Fotos:
		<br>
		<input type="file" name="foto-planta1" id="f1" size="5">
		<button type="button" onclick="agregarUpload();">Agregar otra fotografía</button>
		<br>
		<input type="file" name="foto-planta2" id="f2" size="5" class="elemento-escondido">
		<br>
		<input type="file" name="foto-planta3" id="f3" size="5" class="elemento-escondido">
		<br>
		<input type="file" name="foto-planta4" id="f4" size="5" class="elemento-escondido">
		<br>
		<input type="file" name="foto-planta5" id="f5" size="5" class="elemento-escondido">
		<br>

		<br>
		Intercambio Por:
		<br>
        	<textarea name="intercambio-por" id="intercambio_por" rows="5" cols="30" maxlength="400"></textarea>
		<br>

		Email contacto:
		<br>
        	<input type="text" name="email-contacto" id="email_contacto" size="40" maxlength="100">
		<br>

		Fono contacto:
		<br>
        	<input type="text" name="fono-contacto" id="fono_contacto" size="20" maxlength="20">
		<br>

		Región entrega:
		<br>
        	<select name="region-entrega" id="region_entrega" onChange="updatecomunas(this.selectedIndex);">
        	<option value=1>Región de Tarapacá</option>
        	<option value=2>Región de Antofagasta</option>
			<option value=3>Región de Atacama</option>
			<option value=4>Región de Coquimbo</option>
			<option value=5>Región de Valparaíso</option>
			<option value=6>Región del Libertador General Bernardo O'Higgins</option>
			<option value=7>Región del Maule</option>
			<option value=8>Región del BioBío</option>
			<option value=9>Región de la Araucanía</option>
			<option value=10>Región de los Lagos</option>
			<option value=11>Región de Aisén del General Carlos Ibañez del Campo</option>
			<option value=12>Región de Magallanes y de la Antártica Chilena</option>
			<option value=13>Región Metropolitana de Santiago</option>
			<option value=14>Región de los Ríos</option>
			<option value=15>Región de Arica</option>
        	</select>
		<br>

		Comuna entrega:
		<br>
        	<select name="comuna-entrega" id="comuna_entrega">
        		<option value=10304>Iquique</option>
        		<option value=10307>Alto Hospicio</option>
        		<option value=10303>Pozo Almonte</option>
				<option value=10301>Camiña</option>
				<option value=10306>Colchane</option>
				<option value=10302>Huara</option>
				<option value=10305>Pica</option>
        	</select>
		<br>

		<!-- Boton submit -->
		<br>
		<button type="submit">Ingresar esta planta</button>
		<br>
	</form>

	<script>
		var listaregiones = document.getElementById("region_entrega");
		var listacomunas = document.getElementById("comuna_entrega");
		var mail = document.forma.email_contacto;
		var re = /a/;

		var comunas = new Array();
		var comunas_valores = new Array();
		
		//1 Tarapaca
		comunas[0] = ["Iquique","Alto Hospicio","Pozo Almonte","Camiña","Colchane","Huara","Pica"];
		comunas_valores[0] = [10304,10307,10303,10301,10306,10302,10305];
		//2 Antofagasta
		comunas[1] = ["Tocopilla","María Elena","Ollagüe","Calama","San Pedro de Atacama","Sierra Gorda","Mejillones","Antofagasta","Taltal"];
		comunas_valores[1] = [20101,20102,20201,20202,20203,20301,20302,20303,20304];
		//3 Atacama
		comunas[2] = ["Diego de Almagro","Chañaral","Caldera","Copiapó","Tierra Amarilla","Huasco","Freirina","Vallenar","Alto del Carmen"];
		comunas_valores[2] = [30101, 30102, 30201, 30202, 30203, 30301, 30302, 30303, 30304];
		//4
		comunas[3] = ["La Higuera","La Serena","Vicuña","Paihuano","Coquimbo","Andacollo","Río Hurtado","Ovalle","Monte Patria","Punitaqui","Combarbalá","Mincha","Illapel","Salamanca","Los Vilos"];
		comunas_valores[3] = [40101, 40102, 40103, 40104, 40105, 40106, 40201, 40202, 40203, 40204, 40205, 40301, 40302, 40303, 40304];
		//5
		comunas[4] = ["Petorca","Cabildo","Papudo","La Ligua","Zapallar","Putaendo","Santa María","San Felipe","Pencahue","Catemu","Llay Llay","Nogales","La Calera","Hijuelas","La Cruz","Quillota","Olmue","Limache","Los Andes", "Rinconada", "Calle Larga", "San Esteban", "Puchuncavi", "Quintero", "Viña del Mar", "Villa Alemana", "Quilpue", "Valparaiso", "Juan Fernandez", "Casablanca", "Concon", "Isla de Pascua", "Algarrobo", "El Quisco", "El Tabo", "Cartagena", "San Antonio", "Santo Domingo"];
		comunas_valores[4] = [50101, 50102, 50103, 50104, 50105, 50201, 50202, 50203, 50204, 50205, 50206, 50301, 50302, 50303, 50304, 50305, 50306, 50307, 50401, 50402, 50403, 50404, 50501, 50502, 50503, 50504, 50505, 50506, 50507, 50508, 50509, 50601, 50701, 50702, 50703, 50704, 50705, 50706];
		//6
		comunas[5] = ["Mostazal", "Codegua", "Graneros", "Machali", "Rancagua", "Olivar", "Doñihue", "Requinoa", "Coinco", "Coltauco", "Quinta Tilcoco", "Las Cabras", "Rengo", "Peumo", "Pichidegua", "Malloa", "San Vicente", "Navidad", "La Estrella", "Marchigue", "Pichilemu", "Litueche", "Paredones", "San Fernando", "Peralillo", "Placilla", "Chimbarongo", "Palmilla", "Nancagua", "Santa Cruz", "Pumanque", "Chepica", "Lolol"];
		comunas_valores[5] = [60101, 60102, 60103, 60104, 60105, 60106, 60107, 60108, 60109, 60110, 60111, 60112, 60113, 60114, 60115, 60116, 60117, 60201, 60202, 60203, 60204, 60205, 60206, 60301, 60302, 60303, 60304, 60305, 60306, 60307, 60308, 60309, 60310];
		//7
		comunas[6] = ["Teno", "Romeral", "Rauco", "Curico", "Sagrada Familia", "Hualañe", "Vichuquen", "Molina", "Licanten", "Rio Claro", "Curepto", "Pelarco", "Talca", "Pencahue", "San Clemente", "Constitucion", "Maule", "Empedrado", "San Rafael", "San Javier", "Colbun", "Villa Alegre", "Yerbas Buenas", "Linares", "Longavi", "Retiro", "Parral", "Chanco", "Pelluhue", "Cauquenes"];
		comunas_valores[6] = [70101, 70102, 70103, 70104, 70105, 70106, 70107, 70108, 70109, 70201, 70202, 70203, 70204, 70205, 70206, 70207, 70208, 70209, 70210, 70301, 70302, 70303, 70304, 70305, 70306, 70307, 70308, 70401, 70402, 70403];
		//8
		comunas[7] = ["Cobquecura", "Ñiquen", "San Fabian", "San Carlos", "Quirihue", "Ninhue", "Trehuaco", "San Nicolas", "Coihueco", "Chillan", "Portezuelo", "Pinto", "Coelemu", "Bulnes", "San Ignacio", "Ranquil", "Quillon", "El Carmen", "Pemuco", "Yungay", "Chillan Viejo", "Tome", "Florida", "Penco", "Talcahuano", "Concepcion", "Hualqui", "Coronel", "Lota", "Santa Juana", "Chiguayante", "San Pedro de la Paz", "Hualpen", "Cabrero", "Yumbel", "Tucapel", "Antuco", "San Rosendo", "Laja", "Quilleco", "Los Angeles", "Nacimiento", "Negrete", "Santa Barbara", "Quilaco", "Mulchen", "Alto Bio Bio", "Arauco", "Curanilahue", "Los Alamos", "Lebu", "Cañete", "Contulmo", "Tirua"];
		comunas_valores[7] = [80101, 80102, 80103, 80104, 80105, 80106, 80107, 80108, 80109, 80110, 80111, 80112, 80113, 80114, 80115, 80116, 80117, 80118, 80119, 80120, 80121, 80201, 80202, 80203, 80204, 80205, 80206, 80207, 80208, 80209, 80210, 80211, 80212, 80301, 80302, 80303, 80304, 80305, 80306, 80307, 80308, 80309, 80310, 80311, 80312, 80313, 80314, 80401, 80402, 80403, 80404, 80405, 80406, 80407];
		//9
		comunas[8] = ["Renaico", "Angol", "Collipulli", "Los Sauces", "Puren", "Ercilla", "Lumaco", "Victoria", "Traiguen", "Curacautin", "Lonquimay", "Perquenco", "Galvarino", "Lautaro", "Vilcun", "Temuco", "Carahue", "Melipeuco", "Nueva Imperial", "Puerto Saavedra", "Cunco", "Freire", "Pitrufquen", "Teodoro Schmidt", "Gorbea", "Pucon", "Villarica", "Tolten", "Curarrehue", "Loncoche", "Paadre Las Casas", "Cholchol"];
		comunas_valores[8] = [90101, 90102, 90103, 90104, 90105, 90106, 90107, 90108, 90109, 90110, 90111, 90201, 90202, 90203, 90204, 90205, 90206, 90207, 90208, 90209, 90210, 90211, 90212, 90213, 90214, 90215, 90216, 90217, 90218, 90219, 90220, 90221];
		//10
		comunas[9] = ["San Pablo", "San Juan", "Osorno", "Puyehue", "Rio Negro", "Purranque", "Puerto Octay", "Frutillar", "Fresia", "Llanquihue", "Puerto Varas", "Los Muermos", "Puerto Montt", "Maullin", "Calbuco", "Cochamo", "Ancud", "Quemchi", "Dalcahue", "Curaco de Velez", "Castro", "Chonchi", "Queilen", "Quellon", "Quinchao", "Puqueldon", "Chaiten", "Futaleufu", "Palena", "Hualaihue"];
		comunas_valores[9] = [100201, 100202, 100203, 100204, 100205, 100206, 100207, 100301, 100302, 100303, 100304, 100305, 100306, 100307, 100308, 100309, 100401, 100402, 100403, 100404, 100405, 100406, 100407, 100408, 100409, 100410, 100501, 100502, 100503, 100504];
		//11
		comunas[10] = ["Guaitecas", "Cisnes", "Aysen", "Coyhaique", "Lago Verde", "Rio Ibáñez", "Chile Chico", "Cochrane", "Tortel", "OHigins"];
		comunas_valores[10] = [110101, 110102, 110103, 110201, 110202, 110301, 110302, 110401, 110402, 110403];
		//12
		comunas[11] = ["Torres del Paine", "Puerto Natales", "Laguna Blanca", "San Gregorio", "Rio Verde", "Punta Arenas", "Porvenir", "Primavera", "Timaukel", "Antartica"];
		comunas_valores[11] = [120101, 120102, 120201, 120202, 120203, 120204, 120301, 120302, 120303, 120401];
		//13
		comunas[12] = ["Tiltil", "Colina", "Lampa", "Conchali", "Quilicura", "Renca", "Las Condes", "Pudahuel", "Quinta Normal", "Providencia", "Santiago", "La Reina", "Ñuñoa", "San Miguel", "Maipu", "La Cisterna", "La Florida", "La Granja", "Independencia", "Huechuraba", "Recoleta", "Vitacura", "Lo Barnechea", "Macul", "Peñalolen", "San Joaquin", "La Pintana", "San Ramon", "El Bosque", " Pedro Aguirre Cerda", "Lo Espejo", "Estacion Central", "Cerrillos", "Lo Prado", "Cerro Navia", "San Jose de Maipo", "Puente Alto", "Pirque", "San Bernardo", "Calera de Tango", "Buin", "Paine", "Peñaflor", "Talagante", "El Monte", "Isla de Maipo", "Curacavi", "Maria Pinto", "Melipilla", "San Pedro", "Alhue", "Padre Hurtado"];
		comunas_valores[12] = [130101, 130102, 130103, 130201, 130202, 130203, 130204, 130205, 130206, 130207, 130208, 130209, 130210, 130211, 130212, 130213, 130214, 130215, 130216, 130217, 130218, 130219, 130220, 130221, 130222, 130223, 130224, 130225, 130226, 130227, 130228, 130229, 130230, 130231, 130232, 130301, 130302, 130303, 130401, 130402, 130403, 130404, 130501, 130502, 130503, 130504, 130601, 130602, 130603, 130604, 130605, 130606];
		//14
		comunas[13] = ["Lanco", "Mariquina", "Panguipulli", "Mafil", "Valdivia", "Los Lagos", "Corral", "Paillaco", "Futrono", "Lago Ranco", "La Union", "Rio Bueno"];
		comunas_valores[13] = [100101,100102,100103,100104,100105,100106,100107,100108,100109,100110,100111,100112];
		//Arica y Parinacota 15
		comunas[14] = ["Arica","Camarones","Putre","General Lagos"];
		comunas_valores[14] = [10201,10202,10102,10101];


		function updatecomunas(n){
			listacomunas.options.length = 0;
			if(n>=0){
				for(i=0; i<comunas[n].length; i++){
					listacomunas.options[i]= new Option(comunas[n][i]);
					listacomunas.options[i].value = comunas_valores[n][i];
				}
			}
		}

		function validar(){
			errores = [];
			errores = validarPlanta(errores);
			errores = validarCorreo(errores);
			errores = validarTelefono(errores);
			errores = validarOtro(errores);
			errores = validarFoto(errores);
			if (errores.length==0){
				return true;
			}
			else{
				var str = "";
				for(i=0; i<errores.length; i++){
					str = str+errores[i]+"\n";
				}
				alert(str);
				return false;
			}
			return false;
		}

		function validarPlanta(errores){
			var ER = /[a-zA-Z]+/;
			var planta = document.getElementById("nombre_planta").value;
			if(!ER.test(planta)){
				errores[errores.length] = "Nombre de planta no valido";
			}
			return errores;
		}
		function validarCorreo(errores){
			var ER = /[^@]+@[^@]+\.[a-zA-Z]{2,6}/;
			var correo = document.getElementById("email_contacto").value;
			if(!ER.test(correo)){
				errores[errores.length] = "Dirección de correo electrónico no válida";
			}
			return errores;
		}
		function validarTelefono(errores){
			var ER = /^[1]{0}$|^[0-9]{8,9}$/;
			var fono = document.getElementById("fono_contacto").value;
			if(!ER.test(fono)){
				errores[errores.length] = "Telefono de contacto no valido"
			}
			return errores;
		}
		function validarFoto(errores){
			var ER = /.jpg$|.png$/;
			var foto = document.getElementById("f1").value;
			if(!ER.test(foto)){
				errores[errores.length] = "La primera foto no es .jpg ni png"
			}
			return errores;
		}
		function validarOtro(errores){
			var ER = /^[a-zA-Z][a-zA-Z ]*$/;
			var planta = document.getElementById("tipo_planta").value;
			var otro = document.getElementById("otro_planta").value;
			if(!ER.test(otro) && planta == 1010){
				errores[errores.length] = "Tipo de planta no valido"
			}
			return errores;
		}


		function agregarOtro(){
			var oculto = document.getElementById("otro_planta").className;
			var planta = document.getElementById("tipo_planta").value;
			if(planta == 5 && oculto == "elemento-escondido"){
				toggleElement('otro_planta');
				return;
			}
			if(planta != 5 && oculto != "elemento-escondido"){
				toggleElement('otro_planta');
				return;
			}
		}
		
		function agregarUpload(){
			if(document.getElementById("f5").className=="elemento-escondido" && document.getElementById("f4").className!="elemento-escondido"){
				toggleElement('f5');
			}
			if(document.getElementById("f4").className=="elemento-escondido" && document.getElementById("f3").className!="elemento-escondido"){
				toggleElement('f4');
			}
			if(document.getElementById("f3").className=="elemento-escondido" && document.getElementById("f2").className!="elemento-escondido"){
				toggleElement('f3');
			}
			if(document.getElementById("f2").className=="elemento-escondido"){
				toggleElement('f2');
			}
			
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
