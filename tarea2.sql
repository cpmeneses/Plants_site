SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `tarea2` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `tarea2` ;

-- -----------------------------------------------------
-- Table `tarea2`.`region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tarea2`.`region` ;

CREATE TABLE IF NOT EXISTS `tarea2`.`region` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea2`.`comuna`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tarea2`.`comuna` ;

CREATE TABLE IF NOT EXISTS `tarea2`.`comuna` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) NOT NULL,
  `region_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comuna_region_idx` (`region_id` ASC),
  CONSTRAINT `fk_comuna_region`
    FOREIGN KEY (`region_id`)
    REFERENCES `tarea2`.`region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea2`.`tipo_planta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tarea2`.`tipo_planta` ;

CREATE TABLE IF NOT EXISTS `tarea2`.`tipo_planta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea2`.`planta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tarea2`.`planta` ;

CREATE TABLE IF NOT EXISTS `tarea2`.`planta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(80) NOT NULL,
  `tipo_planta` INT NOT NULL,
  `descripcion` VARCHAR(1000) NULL,
  `fecha_ingreso` DATETIME NOT NULL,
  `email_contacto` VARCHAR(100) NOT NULL,
  `fono_contacto` VARCHAR(20) NULL,
  `comuna_entrega` INT NOT NULL,
  `intercambio_por` VARCHAR(400) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tipo_animal_idx` (`tipo_planta` ASC),
  INDEX `fk_animal_comuna1_idx` (`comuna_entrega` ASC),
  CONSTRAINT `fk_tipo_animal`
    FOREIGN KEY (`tipo_planta`)
    REFERENCES `tarea2`.`tipo_planta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_comuna1`
    FOREIGN KEY (`comuna_entrega`)
    REFERENCES `tarea2`.`comuna` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea2`.`fotografia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tarea2`.`fotografia` ;

CREATE TABLE IF NOT EXISTS `tarea2`.`fotografia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ruta_archivo` VARCHAR(300) NOT NULL,
  `nombre_archivo` VARCHAR(300) NOT NULL,
  `planta` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fotografia_animal1_idx` (`planta` ASC),
  CONSTRAINT `fk_fotografia_animal1`
    FOREIGN KEY (`planta`)
    REFERENCES `tarea2`.`planta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea2`.`comentario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tarea2`.`comentario` ;

CREATE TABLE IF NOT EXISTS `tarea2`.`comentario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comentario` VARCHAR(500) NOT NULL,
  `nombre_comentarista` VARCHAR(200) NULL,
  `fecha` DATETIME NULL,
  `planta` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentario_animal1_idx` (`planta` ASC),
  CONSTRAINT `fk_comentario_animal1`
    FOREIGN KEY (`planta`)
    REFERENCES `tarea2`.`planta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `tarea2`.`tipo_planta`
-- -----------------------------------------------------
START TRANSACTION;
USE `tarea2`;
INSERT INTO `tarea2`.`tipo_planta` (`id`, `descripcion`) VALUES (1, 'arbol');
INSERT INTO `tarea2`.`tipo_planta` (`id`, `descripcion`) VALUES (2, 'arbusto');
INSERT INTO `tarea2`.`tipo_planta` (`id`, `descripcion`) VALUES (3, 'mata');
INSERT INTO `tarea2`.`tipo_planta` (`id`, `descripcion`) VALUES (4, 'hierba');
INSERT INTO `tarea2`.`tipo_planta` (`id`, `descripcion`) VALUES (5, 'otro');

COMMIT;



START TRANSACTION;
USE `tarea2`;
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (1, 'Región de Tarapaca');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (2, 'Región de Antofagasta');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (3, 'Región de Atacama');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (4, 'Región de Coquimbo');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (5, 'Región de Valparaíso');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (6, 'Región del Libertador Bernardo Ohiggins');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (7, 'Región del Maule');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (8, 'Región del Bío-Bío');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (9, 'Región de la Araucanía');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (10, 'Región de los Lagos');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (11, 'Región Aisén del General Carlos Ibáñez del Campo');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (12, 'Región de Magallanes y la Antártica Chilena');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (13, 'Región Metropolitana de Santiago');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (14, 'Región de los Rios');
INSERT INTO `tarea2`.`region` (`id`, `nombre`) VALUES (15, 'Región Arica y Parinacota');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tarea2`.`comuna`
-- -----------------------------------------------------
START TRANSACTION;
USE `tarea2`;
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10301, 1, 'Camiña');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10302, 1, 'Huara');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10303, 1, 'Pozo Almonte');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10304, 1, 'Iquique');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10305, 1, 'Pica');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10306, 1, 'Colchane');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10307, 1, 'Alto Hospicio');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (20101, 2, 'Tocopilla');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (20102, 2, 'Maria Elena');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (20201, 2, 'Ollague');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (20202, 2, 'Calama');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (20203, 2, 'San Pedro Atacama');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (20301, 2, 'Sierra Gorda');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (20302, 2, 'Mejillones');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (20303, 2, 'Antofagasta');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (20304, 2, 'Taltal');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (30101, 3, 'Diego de Almagro');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (30102, 3, 'Chañaral');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (30201, 3, 'Caldera');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (30202, 3, 'Copiapo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (30203, 3, 'Tierra Amarilla');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (30301, 3, 'Huasco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (30302, 3, 'Freirina');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (30303, 3, 'Vallenar');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (30304, 3, 'Alto del Carmen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40101, 4, 'La Higuera');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40102, 4, 'La Serena');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40103, 4, 'Vicuña');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40104, 4, 'Paihuano');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40105, 4, 'Coquimbo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40106, 4, 'Andacollo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40201, 4, 'Rio Hurtado');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40202, 4, 'Ovalle');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40203, 4, 'Monte Patria');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40204, 4, 'Punitaqui');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40205, 4, 'Combarbala');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40301, 4, 'Mincha');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40302, 4, 'Illapel');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40303, 4, 'Salamanca');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (40304, 4, 'Los Vilos');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50101, 5, 'Petorca');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50102, 5, 'Cabildo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50103, 5, 'Papudo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50104, 5, 'La Ligua');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50105, 5, 'Zapallar');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50201, 5, 'Putaendo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50202, 5, 'Santa Maria');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50203, 5, 'San Felipe');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50204, 5, 'Pencahue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50205, 5, 'Catemu');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50206, 5, 'Llay Llay');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50301, 5, 'Nogales');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50302, 5, 'La Calera');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50303, 5, 'Hijuelas');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50304, 5, 'La Cruz');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50305, 5, 'Quillota');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50306, 5, 'Olmue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50307, 5, 'Limache');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50401, 5, 'Los Andes');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50402, 5, 'Rinconada');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50403, 5, 'Calle Larga');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50404, 5, 'San Esteban');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50501, 5, 'Puchuncavi');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50502, 5, 'Quintero');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50503, 5, 'Viña del Mar');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50504, 5, 'Villa Alemana');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50505, 5, 'Quilpue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50506, 5, 'Valparaiso');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50507, 5, 'Juan Fernandez');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50508, 5, 'Casablanca');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50509, 5, 'Concon');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50601, 5, 'Isla de Pascua');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50701, 5, 'Algarrobo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50702, 5, 'El Quisco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50703, 5, 'El Tabo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50704, 5, 'Cartagena');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50705, 5, 'San Antonio');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (50706, 5, 'Santo Domingo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60101, 6, 'Mostazal');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60102, 6, 'Codegua');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60103, 6, 'Graneros');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60104, 6, 'Machali');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60105, 6, 'Rancagua');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60106, 6, 'Olivar');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60107, 6, 'Doñihue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60108, 6, 'Requinoa');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60109, 6, 'Coinco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60110, 6, 'Coltauco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60111, 6, 'Quinta Tilcoco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60112, 6, 'Las Cabras');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60113, 6, 'Rengo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60114, 6, 'Peumo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60115, 6, 'Pichidegua');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60116, 6, 'Malloa');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60117, 6, 'San Vicente');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60201, 6, 'Navidad');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60202, 6, 'La Estrella');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60203, 6, 'Marchigue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60204, 6, 'Pichilemu');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60205, 6, 'Litueche');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60206, 6, 'Paredones');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60301, 6, 'San Fernando');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60302, 6, 'Peralillo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60303, 6, 'Placilla');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60304, 6, 'Chimbarongo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60305, 6, 'Palmilla');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60306, 6, 'Nancagua');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60307, 6, 'Santa Cruz');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60308, 6, 'Pumanque');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60309, 6, 'Chepica');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (60310, 6, 'Lolol');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70101, 7, 'Teno');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70102, 7, 'Romeral');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70103, 7, 'Rauco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70104, 7, 'Curico');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70105, 7, 'Sagrada Familia');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70106, 7, 'Hualañe');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70107, 7, 'Vichuquen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70108, 7, 'Molina');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70109, 7, 'Licanten');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70201, 7, 'Rio Claro');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70202, 7, 'Curepto');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70203, 7, 'Pelarco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70204, 7, 'Talca');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70205, 7, 'Pencahue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70206, 7, 'San Clemente');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70207, 7, 'Constitucion');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70208, 7, 'Maule');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70209, 7, 'Empedrado');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70210, 7, 'San Rafael');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70301, 7, 'San Javier');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70302, 7, 'Colbun');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70303, 7, 'Villa Alegre');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70304, 7, 'Yerbas Buenas');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70305, 7, 'Linares');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70306, 7, 'Longavi');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70307, 7, 'Retiro');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70308, 7, 'Parral');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70401, 7, 'Chanco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70402, 7, 'Pelluhue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (70403, 7, 'Cauquenes');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80101, 8, 'Cobquecura');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80102, 8, 'Ñiquen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80103, 8, 'San Fabian');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80104, 8, 'San Carlos');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80105, 8, 'Quirihue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80106, 8, 'Ninhue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80107, 8, 'Trehuaco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80108, 8, 'San Nicolas');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80109, 8, 'Coihueco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80110, 8, 'Chillan');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80111, 8, 'Portezuelo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80112, 8, 'Pinto');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80113, 8, 'Coelemu');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80114, 8, 'Bulnes');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80115, 8, 'San Ignacio');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80116, 8, 'Ranquil');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80117, 8, 'Quillon');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80118, 8, 'El Carmen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80119, 8, 'Pemuco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80120, 8, 'Yungay');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80121, 8, 'Chillan Viejo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80201, 8, 'Tome');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80202, 8, 'Florida');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80203, 8, 'Penco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80204, 8, 'Talcahuano');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80205, 8, 'Concepcion');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80206, 8, 'Hualqui');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80207, 8, 'Coronel');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80208, 8, 'Lota');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80209, 8, 'Santa Juana');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80210, 8, 'Chiguayante');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80211, 8, 'San Pedro de la Paz');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80212, 8, 'Hualpen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80301, 8, 'Cabrero');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80302, 8, 'Yumbel');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80303, 8, 'Tucapel');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80304, 8, 'Antuco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80305, 8, 'San Rosendo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80306, 8, 'Laja');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80307, 8, 'Quilleco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80308, 8, 'Los Angeles');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80309, 8, 'Nacimiento');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80310, 8, 'Negrete');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80311, 8, 'Santa Barbara');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80312, 8, 'Quilaco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80313, 8, 'Mulchen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80314, 8, 'Alto Bio Bio');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80401, 8, 'Arauco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80402, 8, 'Curanilahue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80403, 8, 'Los Alamos');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80404, 8, 'Lebu');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80405, 8, 'Cañete');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80406, 8, 'Contulmo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (80407, 8, 'Tirua');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90101, 9, 'Renaico');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90102, 9, 'Angol');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90103, 9, 'Collipulli');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90104, 9, 'Los Sauces');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90105, 9, 'Puren');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90106, 9, 'Ercilla');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90107, 9, 'Lumaco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90108, 9, 'Victoria');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90109, 9, 'Traiguen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90110, 9, 'Curacautin');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90111, 9, 'Lonquimay');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90201, 9, 'Perquenco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90202, 9, 'Galvarino');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90203, 9, 'Lautaro');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90204, 9, 'Vilcun');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90205, 9, 'Temuco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90206, 9, 'Carahue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90207, 9, 'Melipeuco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90208, 9, 'Nueva Imperial');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90209, 9, 'Puerto Saavedra');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90210, 9, 'Cunco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90211, 9, 'Freire');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90212, 9, 'Pitrufquen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90213, 9, 'Teodoro Schmidt');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90214, 9, 'Gorbea');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90215, 9, 'Pucon');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90216, 9, 'Villarrica');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90217, 9, 'Tolten');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90218, 9, 'Curarrehue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90219, 9, 'Loncoche');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90220, 9, 'Padre Las Casas');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (90221, 9, 'Cholchol');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100201, 10, 'San Pablo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100202, 10, 'San Juan');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100203, 10, 'Osorno');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100204, 10, 'Puyehue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100205, 10, 'Rio Negro');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100206, 10, 'Purranque');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100207, 10, 'Puerto Octay');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100301, 10, 'Frutillar');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100302, 10, 'Fresia');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100303, 10, 'Llanquihue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100304, 10, 'Puerto Varas');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100305, 10, 'Los Muermos');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100306, 10, 'Puerto Montt');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100307, 10, 'Maullin');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100308, 10, 'Calbuco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100309, 10, 'Cochamo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100401, 10, 'Ancud');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100402, 10, 'Quemchi');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100403, 10, 'Dalcahue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100404, 10, 'Curaco de Velez');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100405, 10, 'Castro');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100406, 10, 'Chonchi');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100407, 10, 'Queilen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100408, 10, 'Quellon');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100409, 10, 'Quinchao');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100410, 10, 'Puqueldon');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100501, 10, 'Chaiten');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100502, 10, 'Futaleufu');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100503, 10, 'Palena');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100504, 10, 'Hualaihue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110101, 11, 'Guaitecas');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110102, 11, 'Cisnes');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110103, 11, 'Aysen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110201, 11, 'Coyhaique');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110202, 11, 'Lago Verde');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110301, 11, 'Rio Ibañez');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110302, 11, 'Chile Chico');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110401, 11, 'Cochrane');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110402, 11, 'Tortel');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (110403, 11, 'OHigins');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120101, 12, 'Torres del Paine');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120102, 12, 'Puerto Natales');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120201, 12, 'Laguna Blanca');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120202, 12, 'San Gregorio');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120203, 12, 'Rio Verde');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120204, 12, 'Punta Arenas');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120301, 12, 'Porvenir');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120302, 12, 'Primavera');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120303, 12, 'Timaukel');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (120401, 12, 'Antartica');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130101, 13, 'Tiltil');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130102, 13, 'Colina');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130103, 13, 'Lampa');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130201, 13, 'Conchali');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130202, 13, 'Quilicura');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130203, 13, 'Renca');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130204, 13, 'Las Condes');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130205, 13, 'Pudahuel');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130206, 13, 'Quinta Normal');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130207, 13, 'Providencia');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130208, 13, 'Santiago');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130209, 13, 'La Reina');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130210, 13, 'Ñuñoa');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130211, 13, 'San Miguel');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130212, 13, 'Maipu');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130213, 13, 'La Cisterna');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130214, 13, 'La Florida');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130215, 13, 'La Granja');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130216, 13, 'Independencia');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130217, 13, 'Huechuraba');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130218, 13, 'Recoleta');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130219, 13, 'Vitacura');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130220, 13, 'Lo Barrenechea');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130221, 13, 'Macul');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130222, 13, 'Peñalolen');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130223, 13, 'San Joaquin');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130224, 13, 'La Pintana');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130225, 13, 'San Ramon');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130226, 13, 'El Bosque');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130227, 13, 'Pedro Aguirre Cerda');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130228, 13, 'Lo Espejo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130229, 13, 'Estacion Central');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130230, 13, 'Cerrillos');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130231, 13, 'Lo Prado');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130232, 13, 'Cerro Navia');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130301, 13, 'San Jose de Maipo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130302, 13, 'Puente Alto');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130303, 13, 'Pirque');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130401, 13, 'San Bernardo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130402, 13, 'Calera de Tango');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130403, 13, 'Buin');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130404, 13, 'Paine');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130501, 13, 'Peñaflor');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130502, 13, 'Talagante');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130503, 13, 'El Monte');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130504, 13, 'Isla de Maipo');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130601, 13, 'Curacavi');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130602, 13, 'Maria Pinto');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130603, 13, 'Melipilla');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130604, 13, 'San Pedro');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130605, 13, 'Alhue');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (130606, 13, 'Padre Hurtado');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100101, 14, 'Lanco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100102, 14, 'Mariquina');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100103, 14, 'Panguipulli');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100104, 14, 'Mafil');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100105, 14, 'Valdivia');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100106, 14, 'Los Lagos');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100107, 14, 'Corral');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100108, 14, 'Paillaco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100109, 14, 'Futrono');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100110, 14, 'Lago Ranco');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100111, 14, 'La Union');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (100112, 14, 'Rio Bueno');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10101, 15, 'Gral. Lagos');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10102, 15, 'Putre');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10201, 15, 'Arica');
INSERT INTO `tarea2`.`comuna` (`id`, `region_id`, `nombre`) VALUES (10202, 15, 'Camarones');

COMMIT;


