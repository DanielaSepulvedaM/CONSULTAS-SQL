/*Consultas multitabla (Composición interna)*/

/* 1.Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.*/
SELECT prod.nombre,
	   prod.precio,
	   fab.nombre
FROM producto AS prod
LEFT JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
	 
/* 2.Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
     Ordene el resultado por el nombre del fabricante, por orden alfabético.*/
SELECT prod.nombre,
		prod.precio,
		fab.nombre
FROM producto AS prod
LEFT JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
ORDER BY fab.nombre DESC

/* 3.Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, 
	 de todos los productos de la base de datos.*/
SELECT prod.codigo,
		prod.nombre, 
		fab.codigo AS codigoFabricante,
		fab.nombre AS nombreFabricante
FROM producto AS prod
LEFT JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo

/* 4.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato*/
SELECT TOP(1)
		prod.nombre,
		prod.precio,
		fab.nombre AS nombreFabricante
FROM producto AS prod
LEFT JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
ORDER BY prod.precio ASC 

/* 5.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.*/
SELECT TOP(1)
	prod.nombre,
	prod.precio,
	fab.nombre AS [nombre fabricante]
FROM producto AS prod
LEFT JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
ORDER BY prod.precio DESC

/*6.Devuelve una lista de todos los productos del fabricante Lenovo.*/
SELECT *
FROM producto AS prod
LEFT JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
WHERE fab.nombre = 'lenovo'

/*7.Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€. */
SELECT *
FROM producto AS prod
LEFT JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
WHERE prod.precio > 200

/*8.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. 
	Sin utilizar el operador IN.*/
SELECT * 
FROM producto AS prod
RIGHT JOIN fabricante AS fab
ON fab.codigo = codigo_fabricante
WHERE fab.nombre = 'Asus' 
	OR fab.nombre = 'Hewlett-Packard'  
	OR fab.nombre = 'Seagate'

/*9.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. 
	Utilizando el operador IN.*/
SELECT *
FROM producto AS prod
RIGHT JOIN fabricante AS fab
ON fab.codigo = prod.codigo_fabricante
WHERE fab.nombre IN ('Asus','Hewlett-Packard','Seagate')

/*10.Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes 
	cuyo nombre termine por la vocal e*/
SELECT prod.nombre,
		prod.precio,
		fab.nombre
FROM producto AS prod
LEFT JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
WHERE RIGHT(fab.nombre,1) = 'e'

/*11.Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante 
	contenga el carácter w en su nombre.*/
SELECT prod.nombre,
	   prod.codigo,
	   fab.nombre
FROM producto AS prod
LEFT JOIN fabricante AS fab
ON prod.codigo_fabricante = fab.codigo
WHERE fab.nombre LIKE '%w%'

/*12.Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los 
	productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por 
	el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)*/
SELECT 
	prod.nombre,
	prod.precio,
	fab.nombre AS nombreFabricante
FROM producto AS prod
LEFT JOIN fabricante AS fab
	ON prod.codigo_fabricante = fab.codigo
WHERE prod.precio >= 180
ORDER BY prod.precio DESC,
	     prod.nombre ASC

/*13.devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes 
	que tienen productos asociados en la base de datos.*/
SELECT fab.codigo,
		fab.nombre
FROM fabricante AS fab
WHERE EXISTS
	(SELECT NULL 
	 FROM producto
	 WHERE codigo_fabricante = fab.codigo)
--INNER JOIN producto AS prod
--ON prod.codigo_fabricante = fab.codigo

                              /***CONSULTAS MULTITABLA (COMPOSICIÓN EXTERNA)***/


/*1.Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
	El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.*/
SELECT *
FROM fabricante AS fab
LEFT JOIN producto AS prod
ON fab.codigo = prod.codigo_fabricante

/*2.Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.*/
SELECT  *
FROM fabricante AS fab
LEFT JOIN producto AS prod
ON prod.codigo_fabricante = fab.codigo
WHERE prod.codigo_fabricante IS NULL

/*3.¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.*/
