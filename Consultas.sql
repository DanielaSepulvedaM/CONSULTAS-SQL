USE tienda 
CREATE TABLE fabricante
(
	codigo INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(100)
);
CREATE TABLE producto 
(
	codigo INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(100),
	precio DECIMAL,
	codigo_fabricante INT NOT NULL,
	FOREIGN KEY(codigo_fabricante) REFERENCES [dbo].[fabricante]([codigo])
);

USE tienda
INSERT INTO	fabricante (codigo, nombre) VALUES
(2,'Lenovo')
,(3, 'Hewlett-Packard')
,(4, 'Samsung')
,(5, 'Seagate')
,(6, 'Crucial')
,(7, 'Gigabyte')
,(8, 'Huawei')
,(9, 'xioami')

INSERT INTO producto(codigo, nombre, precio, codigo_fabricante) VALUES
(1,'Disco duro SATA3 1 TB', 86.99, 5)
,(2,'Memoria RAM DDR4 8GB', 120, 6)
,(3,'Disco SSD 1 TB', 150.99, 4)
,(4,'GeForce DTX 1050Ti', 185,7)
,(5,'GeForce GTX 1080 Xtreme', 755, 6)
,(6,'Monitor 24 LED Full HD', 202, 1)
,(7,'Monitor 27 LED Full HD', 245.99, 1)
,(8,'Portatil Yoga 520', 559, 2)
,(9,'Portatil Ideapd', 444, 2)
,(10,'Impresora HP Deskjet 3720', 59.99, 3)
,(11,'Impresora HP Laserjet Pro M26nw', 180, 3)

INSERT INTO producto(codigo, nombre, precio, codigo_fabricante) VALUES
(12,'Disco duro SAT3 1 TB', 86.88, 5)

/* 1. Lista el nombre de todos los productos que hay en la tabla producto.*/
SELECT nombre FROM producto

/* 2.Lista los nombres y los precios de todos los productos de la tabla producto.*/
SELECT nombre, precio FROM producto

/* 3. Lista todas las columnas de la tabla producto.*/
SELECT * FROM producto

/* 4.Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).*/
SELECT nombre, precio * 0.96 FROM producto
SELECT nombre, precio * 1.04 FROM producto

/* 5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares*/
SELECT 
	nombre AS [nombre de producto], 
	precio * 1.04 AS euros,
	precio * 0.96 AS dolares
FROM producto


/* 6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.*/
SELECT  
	UPPER(nombre) AS [nombre en mayuscula], 
	precio
FROM producto

/* 7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.*/
SELECT 
	LOWER(nombre) AS [nombre en minuscula], 
	precio
FROM producto

/* 8.Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.*/
SELECT 
	SUBSTRING(nombre,1,2) AS [primeros caracteres], 
	nombre
FROM fabricante

/* 9.Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.*/
SELECT 
	nombre, 
	precio,
	ROUND(precio,0)
FROM producto

ALTER TABLE producto ALTER COLUMN precio DECIMAL(18,2)

/* 10.Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.*/
/* 11.Lista el identificador de los fabricantes que tienen productos en la tabla producto.*/
SELECT f.codigo
FROM fabricante AS f
INNER JOIN producto AS p
ON f.codigo = p.codigo_fabricante;

/* 12.Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.*/
SELECT DISTINCT fab.codigo
FROM fabricante AS fab
INNER JOIN producto AS prod 
	ON fab.codigo = prod.codigo_fabricante;

/* 13.Lista los nombres de los fabricantes ordenados de forma ascendente*/
SELECT 
	nombre
FROM fabricante
ORDER BY nombre ASC

/* 14.Lista los nombres de los fabricantes ordenados de forma descendente.*/
SELECT 
	nombre	
FROM fabricante
ORDER BY nombre DESC

/* 15.Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.*/
SELECT 
	nombre,
	precio
FROM producto
ORDER BY 
	nombre ASC, 
	precio DESC

/* 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante. */
SELECT top(5) *
FROM fabricante

/* 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.*/
SELECT *
FROM fabricante
ORDER BY 
	codigo
OFFSET 3 ROWS
FETCH NEXT 2 ROWS ONLY;

/* 18.Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)*/
SELECT TOP(1)
	nombre,
	precio
FROM producto
ORDER BY precio ASC

/* 19.Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)*/
SELECT TOP(1)
	nombre,
	precio
FROM producto 
ORDER BY precio DESC

/* 20.Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.*/
SELECT 
	nombre
FROM producto
	WHERE codigo_fabricante = 2

/* 21.Lista el nombre de los productos que tienen un precio menor o igual a 120€.*/
SELECT 
	nombre
FROM producto
WHERE precio <= 120

/* 22.Lista el nombre de los productos que tienen un precio mayor o igual a 400€.*/
SELECT	
	nombre 
FROM producto
WHERE precio >= 400

/* 23.Lista el nombre de los productos que no tienen un precio mayor o igual a 400€. */
SELECT 
	nombre
FROM producto
WHERE precio < 400

/* 24.Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.*/
SELECT *
FROM producto
WHERE precio >= 80 AND precio <= 300 

/* 25.Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN*/
SELECT *
FROM producto
WHERE precio BETWEEN 80 AND 300

/* 26.Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.*/
SELECT *
FROM producto
WHERE precio > 200 AND codigo = 6

/* 27.Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.*/
SELECT *
FROM producto
WHERE codigo = 1 OR
	  codigo = 3 OR
	  codigo = 5

/* 28.Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.*/
SELECT *
FROM producto
WHERE codigo IN (1,3,5)

/*29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). 
	  Cree un alias para la columna que contiene el precio que se llame céntimos.*/
SELECT nombre,
	   precio * 100 AS centimos
FROM producto

/* 30.Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.*/
SELECT nombre 	   
FROM fabricante
WHERE LEFT(LOWER(nombre),1) = 'S'

/* 31.Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT nombre
FROM fabricante
WHERE RIGHT(nombre,1) = 'e'

/* 32.Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE '%w%'

/* 33.Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres*/
SELECT nombre		
FROM fabricante
WHERE LEN(nombre) = 4

/* 34.Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.*/
SELECT nombre
FROM producto 
WHERE nombre LIKE '%Portatil%'

/* 35.Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €. */
SELECT nombre,
	   precio
FROM producto
WHERE nombre LIKE '%monitor%' OR
	  precio < 215

/* 36.Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. 
	  Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).*/
SELECT nombre,
	   precio
FROM producto
WHERE precio >= 180
ORDER BY precio DESC, nombre ASC

								/***CONSULTAS RESUMEN***/
/*1.Calcula el número total de productos que hay en la tabla productos*/
SELECT COUNT(*) 
FROM producto

/*2.Calcula el número total de fabricantes que hay en la tabla fabricante.*/
SELECT COUNT(*)
FROM fabricante

/*3. Calcula el número de valores distintos de identificador de fabricante aparecen en la tabla productos.*/
SELECT COUNT(*) FROM 
	(
	SELECT DISTINCT codigo_fabricante 
	FROM fabricante AS fab
	INNER JOIN producto AS prod
	ON prod.codigo_fabricante = fab.codigo
	) subConsulta 

/*4.Calcula la media del precio de todos los productos.*/
SELECT AVG(ALL precio) FROM producto

/*5.Calcula el precio más barato de todos los productos.*/
SELECT MIN(precio) FROM producto

/*6.Calcula el precio más caro de todos los productos. */
SELECT MAX(precio) FROM producto

/*7.Lista el nombre y el precio del producto más barato. */
SELECT TOP(1) nombre,
		precio
FROM producto
ORDER BY precio ASC

/*8.Lista el nombre y el precio del producto más caro.*/
SELECT TOP(1)nombre,
		precio
FROM producto
ORDER BY precio ASC

/*9.Calcula la suma de los precios de todos los productos.*/
SELECT  SUM(precio)
FROM producto

/*10.Calcula el número de productos que tiene el fabricante Asus.*/
SELECT COUNT(*)
FROM producto AS prod
INNER JOIN fabricante AS fab
ON fab.codigo = prod.codigo_fabricante
WHERE fab.nombre = 'Asus'

/*11.Calcula la media del precio de todos los productos del fabricante Asus.*/
SELECT AVG(precio)
FROM producto AS prod
INNER JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
WHERE fab.nombre = 'Asus'

/*12.Calcula el precio más barato de todos los productos del fabricante Asus.*/
SELECT top 1 *
FROM producto AS prod 
INNER JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
WHERE fab.nombre = 'Asus'
ORDER BY prod.precio ASC

/*13.Calcula el precio más caro de todos los productos del fabricante Asus*/
SELECT TOP 1 *
FROM producto AS prod
INNER JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
WHERE fab.nombre = 'Asus'
ORDER BY prod.precio DESC

/*14.Calcula la suma de todos los productos del fabricante Asus*/
SELECT SUM(precio)
FROM producto AS prod
INNER JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
WHERE fab.nombre = 'Asus'

/*15.Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial*/
SELECT MAX(precio) AS [precio Maximo],
		MIN(precio) AS [precio Minimo], 
		AVG(precio) AS [precio Medio], 
		COUNT(precio) AS total
FROM producto AS prod
INNER JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
WHERE fab.nombre = 'crucial'

/*16.Muestra el número total de productos que tiene cada uno de los fabricantes. 
	El listado también debe incluir los fabricantes que no tienen ningún producto. 
	El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. 
	Ordene el resultado descendentemente por el número de productos.*/
SELECT fab.nombre AS [nombre fabricante], 
		COUNT(prod.codigo) AS [cantidad producto]
FROM fabricante AS fab
JOIN producto AS prod
ON prod.codigo_fabricante = fab.codigo
GROUP BY fab.nombre
ORDER BY [cantidad producto] DESC









/*17.Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. 
	El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.*/
