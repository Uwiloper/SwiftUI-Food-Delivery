-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-uwil.alwaysdata.net
-- Generation Time: Dec 24, 2025 at 04:51 AM
-- Server version: 10.11.14-MariaDB
-- PHP Version: 8.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uwil_eatoo`
--

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categorias`
--

INSERT INTO `categorias` (`idcategoria`, `nombre`, `descripcion`, `foto`) VALUES
(1, 'Comida Rapida', 'Platos rápidos y comunes en cadenas', 'fotos/categoriasfotos/ComRap.jpg'),
(2, 'Pizzas', 'Pizzas y sus variantes', 'fotos/categoriasfotos/Piz.jpg'),
(3, 'Pollos', 'Pollo a la brasa y especialidades', 'fotos/categoriasfotos/Pol.jpg'),
(4, 'Mexicana', 'Tacos, burritos y similares', 'fotos/categoriasfotos/Mex.jpg'),
(5, 'Japonesa', 'Sushi y comida japonesa', 'fotos/categoriasfotos/Jap.jpg'),
(6, 'Ensaladas', 'Ensaladas frescas', 'fotos/categoriasfotos/Ens.jpg'),
(7, 'Sandwiches', 'Sandwiches y sándwiches', 'fotos/categoriasfotos/San.jpg'),
(8, 'Pastas', 'Pastas y lasañas', 'fotos/categoriasfotos/Pas.jpg'),
(9, 'China/Peruana', 'Chaufa y platos orientales-peruanos', 'fotos/categoriasfotos/ChiPer.jpg'),
(10, 'Mariscos', 'Ceviches y mariscos', 'fotos/categoriasfotos/Mar.jpg'),
(11, 'Postres', 'Postres y helados', 'fotos/categoriasfotos/Pos.jpg'),
(12, 'Snacks', 'Empanadas, bocaditos y snacks', 'fotos/categoriasfotos/Sna.jpg'),
(13, 'Bebidas', 'Bebidas frías y calientes', 'fotos/categoriasfotos/Beb.jpg'),
(14, 'Desayunos', 'Platos de desayuno', 'fotos/categoriasfotos/Des.jpg'),
(15, 'Latina', 'Platos latinoamericanos', 'fotos/categoriasfotos/Lat.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `iddetalle` int(11) NOT NULL,
  `idpedido` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT 1,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`iddetalle`, `idpedido`, `idproducto`, `cantidad`, `subtotal`) VALUES
(1, 1, 3, 1, 15.00),
(2, 1, 5, 2, 23.50),
(3, 2, 2, 1, 18.90),
(4, 2, 4, 2, 38.00),
(5, 3, 1, 2, 24.00),
(6, 4, 6, 1, 22.30),
(7, 4, 8, 2, 20.00);

-- --------------------------------------------------------

--
-- Table structure for table `pedidos`
--

CREATE TABLE `pedidos` (
  `idpedido` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(50) DEFAULT 'Simulado',
  `estado` varchar(20) DEFAULT 'Simulado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pedidos`
--

INSERT INTO `pedidos` (`idpedido`, `idusuario`, `fecha`, `total`, `metodo_pago`, `estado`) VALUES
(1, 1, '2025-11-10 12:45:00', 38.50, 'Tarjeta', 'Simulado'),
(2, 2, '2025-11-10 13:20:00', 56.90, 'Efectivo', 'Simulado'),
(3, 3, '2025-11-11 09:15:00', 24.00, 'Tarjeta', 'Simulado'),
(4, 4, '2025-11-11 18:10:00', 42.30, 'Yape', 'Simulado');

-- --------------------------------------------------------

--
-- Table structure for table `productos`
--

CREATE TABLE `productos` (
  `idproducto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL DEFAULT 0.00,
  `idcategoria` int(11) DEFAULT NULL,
  `idrestaurante` int(11) DEFAULT NULL,
  `imagengrande` varchar(255) DEFAULT NULL,
  `imagenchica` varchar(255) DEFAULT NULL,
  `foto_original` varchar(255) DEFAULT NULL,
  `calificacion` decimal(3,2) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`idproducto`, `nombre`, `descripcion`, `precio`, `idcategoria`, `idrestaurante`, `imagengrande`, `imagenchica`, `foto_original`, `calificacion`, `created_at`, `updated_at`) VALUES
(1, 'Hamburguesa Clasica', 'Pan, carne, lechuga y tomate', 12.50, 1, 1, 'fotos/imggrande/hamcla.jpg', 'fotos/imgchica/hamcla.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(2, 'Pizza Pepperoni', 'Masa, queso mozzarella y pepperoni', 25.00, 2, 2, 'fotos/imggrande/pizpep.jpg', 'fotos/imgchica/pizpep.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(3, 'Pollo a la Brasa', '1/4 de pollo con papas fritas y ensalada', 18.00, 3, 3, 'fotos/imggrande/polbra.jpg', 'fotos/imgchica/polbra.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(4, 'Taco de Carne', 'Tortilla con carne sazonada', 10.00, 4, 4, 'fotos/imggrande/taccar.jpg', 'fotos/imgchica/taccar.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(5, 'Sushi Roll Clasico', 'Roll relleno de salmón y aguacate', 22.00, 5, 5, 'fotos/imggrande/suscla.jpg', 'fotos/imgchica/suscla.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(6, 'Ensalada Cesar', 'Lechuga, pollo, parmesano y aderezo', 15.00, 6, 6, 'fotos/imggrande/ensces.jpg', 'fotos/imgchica/ensces.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(7, 'Sandwich de Pavo', 'Pan integral con pavo y verduras', 11.50, 7, 7, 'fotos/imggrande/sanpav.jpg', 'fotos/imgchica/sanpav.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(8, 'Lasana de Carne', 'Pasta con salsa bolognesa y queso', 20.00, 8, 8, 'fotos/imggrande/lascarn.jpg', 'fotos/imgchica/lascarn.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(9, 'Chaufa de Pollo', 'Arroz frito estilo oriental con pollo', 16.00, 9, 9, 'fotos/imggrande/chapol.jpg', 'fotos/imgchica/chapol.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(10, 'Ceviche Mixto', 'Pescado, mariscos y limón', 24.00, 10, 10, 'fotos/imggrande/cevmixt.jpg', 'fotos/imgchica/cevmixt.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(11, 'Helado de Vainilla', 'Helado artesanal sabor vainilla', 8.00, 11, 11, 'fotos/imggrande/helvai.jpg', 'fotos/imgchica/helvai.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(12, 'Brownie con Helado', 'Brownie caliente con bola de helado', 12.00, 11, 12, 'fotos/imggrande/brohel.jpg', 'fotos/imgchica/brohel.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(13, 'Empanada de Carne', 'Masa rellena de carne sazonada', 6.00, 12, 13, 'fotos/imggrande/empcar.jpg', 'fotos/imgchica/empcar.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(14, 'Cafe Americano', 'Taza de café negro filtrado', 7.50, 13, 14, 'fotos/imggrande/cafame.jpg', 'fotos/imgchica/cafame.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(15, 'Jugo de Naranja', 'Jugo natural recién exprimido', 9.00, 13, 15, 'fotos/imggrande/jugnar.jpg', 'fotos/imgchica/jugnar.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(16, 'Panqueques con Miel', 'Panqueques acompañados de miel de maple', 13.00, 14, 16, 'fotos/imggrande/panmie.jpg', 'fotos/imgchica/panmie.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(17, 'Hot Dog Clasico', 'Pan con salchicha, ketchup y mostaza', 9.00, 1, 17, 'fotos/imggrande/hotcla.jpg', 'fotos/imgchica/hotcla.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(18, 'Pizza Hawaiana', 'Pizza con piña, jamón y queso', 26.00, 2, 18, 'fotos/imggrande/pizhawa.jpg', 'fotos/imgchica/pizhawa.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(19, 'Arepa Rellena', 'Arepa con queso y jamón', 10.00, 15, 19, 'fotos/imggrande/arerel.jpg', 'fotos/imgchica/arerel.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(20, 'Batido de Fresa', 'Batido natural de fresa con leche', 12.00, 13, 20, 'fotos/imggrande/batfre.jpg', 'fotos/imgchica/batfre.jpg', NULL, NULL, '2025-10-05 11:31:22', NULL),
(21, 'Cheeseburger Doble', 'Pan, doble carne y queso cheddar', 14.50, 1, 1, 'fotos/imggrande/chedob.jpg', 'fotos/imgchica/chedob.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(22, 'Pizza Vegetariana', 'Masa, queso y vegetales frescos', 23.00, 2, 2, 'fotos/imggrande/pizveg.jpg', 'fotos/imgchica/pizveg.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(23, 'Pollo Broaster', 'Piezas crujientes con papas fritas', 17.00, 3, 3, 'fotos/imggrande/polbro.jpg', 'fotos/imgchica/polbro.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(24, 'Burrito de Pollo', 'Tortilla rellena con pollo y frijoles', 12.00, 4, 4, 'fotos/imggrande/burpol.jpg', 'fotos/imgchica/burpol.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(25, 'Sushi Acevichado', 'Rollo con salsa acevichada', 24.00, 5, 5, 'fotos/imggrande/susace.jpg', 'fotos/imgchica/susace.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(26, 'Ensalada Tropical', 'Frutas mixtas con aderezo dulce', 13.00, 6, 6, 'fotos/imggrande/enstrop.jpg', 'fotos/imgchica/enstrop.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(27, 'Sandwich de Pollo', 'Pan con pollo y verduras', 10.50, 7, 7, 'fotos/imggrande/sanpol.jpg', 'fotos/imgchica/sanpol.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(28, 'Pasta Alfredo', 'Fettuccine con salsa blanca', 19.00, 8, 8, 'fotos/imggrande/pasalf.jpg', 'fotos/imgchica/pasalf.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(29, 'Chaufa de Mariscos', 'Arroz frito con mariscos mixtos', 20.00, 9, 9, 'fotos/imggrande/chamar.jpg', 'fotos/imgchica/chamar.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(30, 'Arroz con Mariscos', 'Arroz amarillo con mariscos frescos', 22.00, 10, 10, 'fotos/imggrande/arzmar.jpg', 'fotos/imgchica/arzmar.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(31, 'Torta de Chocolate', 'Bizcocho con cobertura de cacao', 11.00, 11, 12, 'fotos/imggrande/torchoc.jpg', 'fotos/imgchica/torchoc.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(32, 'Galleta de Avena', 'Galleta artesanal con pasas', 6.50, 12, 13, 'fotos/imggrande/galave.jpg', 'fotos/imgchica/galave.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(33, 'Te Helado', 'Bebida fría sabor limón', 8.50, 13, 14, 'fotos/imggrande/tehel.jpg', 'fotos/imgchica/tehel.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(34, 'Cafe Latte', 'Cafe con leche espumosa', 9.00, 13, 16, 'fotos/imggrande/caflat.jpg', 'fotos/imgchica/caflat.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(35, 'Huevos Revueltos', 'Huevos batidos con mantequilla', 10.00, 14, 16, 'fotos/imggrande/huerev.jpg', 'fotos/imgchica/huerev.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(36, 'Tamal Criollo', 'Tamal de maíz relleno de cerdo', 9.00, 15, 19, 'fotos/imggrande/tamcri.jpg', 'fotos/imgchica/tamcri.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(37, 'Hamburguesa BBQ', 'Carne, queso y salsa barbacoa', 15.00, 1, 17, 'fotos/imggrande/hambbq.jpg', 'fotos/imgchica/hambbq.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(38, 'Pizza Suprema', 'Pizza con carnes y vegetales', 27.00, 2, 18, 'fotos/imggrande/pizsup.jpg', 'fotos/imgchica/pizsup.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(39, 'Alitas Picantes', 'Alitas fritas con salsa picante', 16.00, 3, 3, 'fotos/imggrande/alipic.jpg', 'fotos/imgchica/alipic.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(40, 'Nachos con Queso', 'Nachos con queso derretido', 12.00, 4, 4, 'fotos/imggrande/nacque.jpg', 'fotos/imgchica/nacque.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(41, 'Sushi Tempura', 'Rollo empanizado con salsa especial', 23.50, 5, 5, 'fotos/imggrande/sustem.jpg', 'fotos/imgchica/sustem.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(42, 'Ensalada de Quinoa', 'Quinoa con verduras frescas', 14.50, 6, 6, 'fotos/imggrande/ensqui.jpg', 'fotos/imgchica/ensqui.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(43, 'Club Sandwich', 'Triple pan con pollo y jamón', 13.00, 7, 7, 'fotos/imggrande/clusan.jpg', 'fotos/imgchica/clusan.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(44, 'Spaghetti Bolognesa', 'Pasta con carne molida y salsa roja', 18.00, 8, 8, 'fotos/imggrande/spabol.jpg', 'fotos/imgchica/spabol.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(45, 'Aeropuerto', 'Chaufa con tallarín saltado', 19.50, 9, 9, 'fotos/imggrande/aer.jpg', 'fotos/imgchica/aer.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(46, 'Jalea Mixta', 'Mariscos fritos con yuca y zarza', 25.00, 10, 10, 'fotos/imggrande/jalmix.jpg', 'fotos/imgchica/jalmix.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(47, 'Cheesecake de Fresa', 'Tarta de queso con salsa de fresa', 14.00, 11, 12, 'fotos/imggrande/chefre.jpg', 'fotos/imgchica/chefre.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(48, 'Churros con Chocolate', 'Churros rellenos con chocolate', 9.50, 12, 13, 'fotos/imggrande/chuchoc.jpg', 'fotos/imgchica/chuchoc.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(49, 'Limonada Frozen', 'Bebida fría de limón natural', 8.00, 13, 15, 'fotos/imggrande/limfro.jpg', 'fotos/imgchica/limfro.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL),
(50, 'Tostadas Francesas', 'Pan dulce con miel y canela', 11.50, 14, 16, 'fotos/imggrande/tosfra.jpg', 'fotos/imgchica/tosfra.jpg', NULL, NULL, '2025-10-20 01:33:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `restaurantes`
--

CREATE TABLE `restaurantes` (
  `idrestaurante` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `latitud` varchar(25) NOT NULL,
  `longitud` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `restaurantes`
--

INSERT INTO `restaurantes` (`idrestaurante`, `nombre`, `direccion`, `telefono`, `foto`, `latitud`, `longitud`) VALUES
(1, 'Burger King', 'Av. Javier Prado 1234, San Isidro', '(01) 245-7789', 'fotos/restaurantesfotos/BurKin.jpg', '-12.1245', '-77.0250'),
(2, 'Pizza Hut', 'Av. La Marina 456, Pueblo Libre', '(01) 612-3344', 'fotos/restaurantesfotos/PizHut.jpg', '-12.1262', '-77.0243'),
(3, 'Norkys', 'Av. Benavides 890, Miraflores', '(01) 543-2201', 'fotos/restaurantesfotos/Nor.jpg', '-12.1259', '-77.0237'),
(4, 'Tacomania', 'Av. Arenales 456, Lince', '(01) 477-9966', 'fotos/restaurantesfotos/Tac.jpg', '-12.1240', '-77.0261'),
(5, 'Sushi House', 'Calle Los Sauces 321, Surco', '(01) 227-1144', 'fotos/restaurantesfotos/SusHou.jpg', '-12.1267', '-77.0255'),
(6, 'La Saladera', 'Av. Los Álamos 250, Surquillo', '(01) 568-2203', 'fotos/restaurantesfotos/LaSal.jpg', '-12.1252', '-77.0270'),
(7, 'Subway', 'Av. Arequipa 789, San Isidro', '(01) 600-9977', 'fotos/restaurantesfotos/Sub.jpg', '-12.1238', '-77.0253'),
(8, 'Don Mario', 'Jr. Callao 120, Lima Centro', '(01) 220-4455', 'fotos/restaurantesfotos/DonMar.jpg', '-12.1260', '-77.0268'),
(9, 'Chifa Kam', 'Av. Universitaria 2400, San Miguel', '(01) 334-8899', 'fotos/restaurantesfotos/ChiKam.jpg', '-12.1256', '-77.0239'),
(10, 'Punto Marino', 'Av. Angamos 560, Miraflores', '(01) 700-8877', 'fotos/restaurantesfotos/PunMar.jpg', '-12.1247', '-77.0241'),
(11, 'Heladeria 4D', 'Av. Larco 875, Miraflores', '(01) 241-9966', 'fotos/restaurantesfotos/Hel4D.jpg', '-12.1258', '-77.0258'),
(12, 'ChocoLovers', 'Calle Las Flores 223, San Borja', '(01) 450-1122', 'fotos/restaurantesfotos/Cho.jpg', '-12.1263', '-77.0262'),
(13, 'La Empanaderia', 'Av. Caminos del Inca 999, Surco', '(01) 775-3344', 'fotos/restaurantesfotos/LaEmp.jpg', '-12.1239', '-77.0245'),
(14, 'Starbucks', 'Av. Primavera 123, San Borja', '(01) 709-7788', 'fotos/restaurantesfotos/Sta.jpg', '-12.1244', '-77.0266'),
(15, 'Frutix', 'Av. Brasil 1540, Jesús María', '(01) 623-5544', 'fotos/restaurantesfotos/Fru.jpg', '-12.1261', '-77.0238'),
(16, 'Cafe Mornings', 'Av. Dos de Mayo 345, Miraflores', '(01) 799-8899', 'fotos/restaurantesfotos/CafMor.jpg', '-12.1248', '-77.0259'),
(17, 'Bembos', 'Av. Wilson 765, Lima', '(01) 433-2121', 'fotos/restaurantesfotos/Bem.jpg', '-12.1257', '-77.0271'),
(18, 'Papa Johns', 'Av. San Luis 543, San Borja', '(01) 622-9988', 'fotos/restaurantesfotos/PapJoh.jpg', '-12.1264', '-77.0252'),
(19, 'Arepas House', 'Av. San Felipe 300, Jesús María', '(01) 678-1122', 'fotos/restaurantesfotos/AreHou.jpg', '-12.1237', '-77.0240'),
(20, 'Smoothie Bar', 'Av. Salaverry 1300, San Isidro', '(01) 554-3366', 'fotos/restaurantesfotos/SmoBar.jpg', '-12.1249', '-77.0236');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `clave` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT 'fotos/nofoto.jpg',
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`idusuario`, `usuario`, `nombre`, `apellido`, `correo`, `telefono`, `clave`, `foto`, `fecha_registro`) VALUES
(1, 'Wilmer Angel', 'Wilmer', 'Carrasco', 'wilmer@example.com', '992594145', 'wilmerc', 'fotos/usuariosfotos/wilmerc.jpg', '2025-09-15 01:56:05'),
(2, 'anita', 'Ana Maria', 'Lopez', 'anamarlo@gmail.com', '992 4751 233', 'anal', 'fotos/usuariosfotos/anita.jpg', '2025-09-15 01:56:05'),
(3, 'josep', 'Jose', 'Perez', 'jose@example.com', '912345678', 'josep', 'fotos/usuariosfotos/josep.jpg', '2025-09-15 01:56:05'),
(4, 'mariaq', 'Maria', 'Quispe', 'maria@example.com', '956785429', 'mariaq', 'fotos/usuariosfotos/mariaq.jpg', '2025-09-15 01:56:05'),
(5, 'carloss', 'Carlos', 'Sanchez', 'carlos@example.com', '987654322', 'carloss', 'fotos/usuariosfotos/carloss.jpg', '2025-09-15 01:56:05'),
(6, 'luisg', 'Luis', 'Gomez', 'luis@example.com', '999996654', 'luisg', 'fotos/usuariosfotos/luisg.jpg', '2025-09-15 01:56:05'),
(7, 'sofiar', 'Sofia', 'Ramirez', 'sofia@example.com', '974532357', 'sofiar', 'fotos/usuariosfotos/sofiar.jpg', '2025-09-15 01:56:05'),
(9, 'juanl', 'Juan', 'Lopez', 'juan@example.com', '998789879', 'juanl', 'fotos/usuariosfotos/juanl.jpg', '2025-09-15 01:56:05'),
(10, 'danielm', 'Daniel', 'Martinez', 'daniel@example.com', '912465789', 'danielm', 'fotos/usuariosfotos/danielm.jpg', '2025-09-15 01:56:05'),
(11, 'andreac', 'Andrea', 'Castro', 'andrea@example.com', '999999999', 'andreac', 'fotos/usuariosfotos/andreac.jpg', '2025-09-15 01:56:05'),
(12, 'fernandov', 'Fernando', 'Vargas', 'fernando@example.com', '956321789', 'fernandov', 'fotos/usuariosfotos/fernandov.jpg', '2025-09-15 01:56:05'),
(13, 'pablom', 'Pablo', 'Mendoza', 'pablo@example.com', '973526178', 'pablom', 'fotos/usuariosfotos/pablom.jpg', '2025-09-15 01:56:05'),
(14, 'patricial', 'Patricia', 'Lozano', 'patricia@example.com', '983547818', 'patricial', 'fotos/usuariosfotos/patricial.jpg', '2025-09-15 01:56:05'),
(15, 'ricardot', 'Ricardo', 'Torres', 'ricardo@example.com', '999888777', 'ricardot', 'fotos/usuariosfotos/ricardot.jpg', '2025-09-15 01:56:05'),
(16, 'monicad', 'Monica', 'Diaz', 'monica@example.com', '999666555', 'monicad', 'fotos/usuariosfotos/monicad.jpg', '2025-09-15 01:56:05'),
(18, 'laurag', 'Laura', 'Gutierrez', 'laura@example.com', '999222111', 'laurag', 'fotos/usuariosfotos/laurag.jpg', '2025-09-15 01:56:05'),
(19, 'cristianh', 'Cristian', 'Huaman', 'cristian@example.com', '989898989', 'cristianh', 'fotos/usuariosfotos/cristianh.jpg', '2025-09-15 01:56:05'),
(20, 'valerial', 'Valeria', 'Leon', 'valeria@example.com', '999988887', 'valerial', 'fotos/usuariosfotos/valerial.jpg', '2025-09-15 01:56:05'),
(25, 'LeoC', 'Leonardo', 'Cardenas', 'Leoc@outlook.com', '997 425 333', 'leoc', 'fotos/nofoto.jpg', '2025-12-15 19:08:46');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idpedido` (`idpedido`),
  ADD KEY `idproducto` (`idproducto`);

--
-- Indexes for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`idpedido`),
  ADD KEY `idusuario` (`idusuario`);

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idproducto`),
  ADD KEY `fk_prod_categoria` (`idcategoria`),
  ADD KEY `fk_prod_restaurante` (`idrestaurante`);

--
-- Indexes for table `restaurantes`
--
ALTER TABLE `restaurantes`
  ADD PRIMARY KEY (`idrestaurante`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `idpedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `restaurantes`
--
ALTER TABLE `restaurantes`
  MODIFY `idrestaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`idpedido`) REFERENCES `pedidos` (`idpedido`),
  ADD CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`idproducto`);

--
-- Constraints for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`);

--
-- Constraints for table `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_prod_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categorias` (`idcategoria`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prod_restaurante` FOREIGN KEY (`idrestaurante`) REFERENCES `restaurantes` (`idrestaurante`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
