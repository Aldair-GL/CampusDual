-- DIFICULTAD MUY FÁCIL -- 
-- Ejercicio 1 --
--Devuelve todas las peliculas--

SELECT * FROM MOVIES;
SELECT MOVIE_NAME FROM MOVIES;

-- Ejercicio 2 --
--Devuelve todos los generos existentes --

SELECT * FROM GENRES;
SELECT GENRES_NAME FROM GENRES;

-- Ejercicio 3 --
--Devuelve una lista con todos los estudios de grabación que estén activos --

SELECT * FROM STUDIOS
WHERE STUDIO_ACTIVE=1;

-- En la columna STUDIO_ACTIVE 1 equivale a si, 0 equivale a no --

-- Ejercicio 4 --
--Devuelve una lista con los últomos 20 miembros en anotarse en la plataforma --

SELECT * FROM USERS
ORDER BY USER_JOIN_DATE DESC LIMIT 20;

-- DIFICULTAD FÁCIL --
--Ejercicio 5 --
--Devuelve las 20 duraciones de películas más frecuentes, ordenados de mayor a menor --

SELECT MOVIE_DURATION FROM MOVIES M
JOIN USER_MOVIE_ACCESS UM ON UM.MOVIE_ID=M.MOVIE_ID
GROUP BY MOVIE_DURATION
ORDER BY MOVIE_DURATION DESC LIMIT 20;

-- Ejercicio 6 --
--Devuelve las peliculas del 2000 en adelante que inicien por la letra A --

SELECT * FROM MOVIES
WHERE YEAR(MOVIE_RELEASE_DATE) > 2000 AND MOVIE_NAME LIKE 'A%';

-- Ejercicio 7 -- 
--Devuelve los actores nacidos en el mes de Junio --

SELECT * FROM ACTORS
WHERE MONTH(ACTOR_BIRTH_DATE)=06;

-- Ejercicio 8 --
--Devuelve los actores nacidos en cualquier mes salvo Junio, y que sigan vivos --

SELECT * FROM ACTORS
WHERE MONTH(ACTOR_BIRTH_DATE) NOT IN (06) AND ACTOR_DEAD_DATE IS NULL;

-- Ejercicio 9 --
--Devuelve el nombre y edad de todos los directores menores o iguales a 50 que sigan vivos --

SELECT DIRECTOR_NAME AS Nombre, YEAR(CURRENT_DATE) - YEAR(DIRECTOR_BIRTH_DATE) AS Edad
FROM DIRECTORS
WHERE DIRECTOR_DEAD_DATE IS NULL 
AND (YEAR(CURRENT_DATE) - YEAR(DIRECTOR_BIRTH_DATE)) >= 50;

  -- Ejercicio 10 --
  --Devuelve nombre y edad de todos los actores menores de 50 años que hayan fallecido --ç
  
SELECT ACTOR_NAME AS Nombre, YEAR(CURRENT_DATE) - YEAR(ACTOR_BIRTH_DATE) AS Edad
FROM ACTORS
WHERE ACTOR_DEAD_DATE IS NOT NULL
AND (YEAR(CURRENT_DATE)-YEAR(ACTOR_BIRTH_DATE))<50;

  -- Ejercicio 11 --
  --Devuelve el nombre de todos los directores menores o iguales de 40 años que esten vivos --

SELECT DIRECTOR_NAME AS Nombre
FROM DIRECTORS
WHERE (YEAR(CURRENT_DATE)-YEAR(DIRECTOR_BIRTH_DATE)) <= 40
AND DIRECTOR_DEAD_DATE IS NULL;

  -- Ejercicio 12 --
  --Indica la edad media de los directores vivos --

SELECT AVG(YEAR(CURRENT_DATE)-YEAR(DIRECTOR_BIRTH_DATE)) AS Edad_Promedio FROM DIRECTORS
WHERE DIRECTOR_DEAD_DATE IS NULL;

  -- Ejercicio 13 --
  --Indica la edad media de los actores fallecidos --

SELECT AVG(YEAR(CURRENT_DATE)-YEAR(ACTOR_BIRTH_DATE)) AS Edad_Promedio FROM ACTORS
WHERE ACTOR_DEAD_DATE IS NOT NULL;

--DIFICULTAD MEDIa --
-- Ejercicio 14 --
--Devuelve el nombre de todas las películas y el nombre del estudio que las ha realizado --

SELECT MOVIE_NAME AS Pelicula, STUDIO_NAME AS Estudio
FROM MOVIES M JOIN STUDIOS S ON S.STUDIO_ID=M.STUDIO_ID;

-- Ejercicio 15 --
--Devuelve los miembros que accedieron al menos a 1 pelicula entre 2010 y 2015 --

SELECT DISTINCT USER_NAME AS Usuario 
FROM USERS U JOIN USER_MOVIE_ACCESS UA ON U.USER_ID=UA.USER_ID
WHERE YEAR(ACCESS_DATE) BETWEEN 2010 AND 2015;

-- Ejercicio 16 --
--Devuelve cuantas peliculas hay en cada pais --

SELECT NATIONALITY_NAME AS Pais, COUNT(MOVIE_ID) AS Peliculas_Cantidad 
FROM MOVIES M JOIN NATIONALITIES N ON M.NATIONALITY_ID=N.NATIONALITY_ID
GROUP BY NATIONALITY_NAME;

-- Ejercicio 17 --
--Devuelve todas las peliculas que hay del genero documental --

SELECT MOVIE_NAME AS Titulo
FROM MOVIES M JOIN GENRES G ON G.GENRE_ID=M.GENRE_ID
WHERE GENRE_NAME='Documentary';

-- Ejercicio 18 --
--Devuelve las peliculas creadas por directores nacidos a partir de 1980 y que sigan vivos --

SELECT MOVIE_NAME AS Pelicula
FROM MOVIES M JOIN DIRECTORS D ON M.DIRECTOR_ID=D.DIRECTOR_ID
WHERE YEAR(DIRECTOR_BIRTH_DATE) >= 1980 
AND DIRECTOR_DEAD_DATE IS NULL;

-- Ejercicio 19 --
--Indica si hay alguna coincidencia de nacimiento de ciudad (y si las hay, indicarlas) entre los miembros de la plataforma y los directores --

SELECT * FROM USERS;

SELECT * FROM DIRECTORS;

SELECT DISTINCT 
  D.DIRECTOR_BIRTH_PLACE AS Ciudad_Director, 
  U.USER_TOWN AS Ciudad_Usuario
FROM DIRECTORS D
JOIN USERS U 
  ON TRIM(UPPER(D.DIRECTOR_BIRTH_PLACE)) = TRIM(UPPER(U.USER_TOWN));

-- No he encontrado ninguna coincidencia entre las ciudades donde viven los usuarios y las ciudades donde nacieron los directores

-- Ejercicio 20 --
--Devuelve el nombre y el año de todas las películas que han sido producidas por un estudio que actualmente no esté activo --

SELECT MOVIE_NAME AS Nombre, MOVIE_RELEASE_DATE AS Fecha_Estreno
FROM MOVIES M JOIN STUDIOS S ON M.STUDIO_ID=S.STUDIO_ID
WHERE STUDIO_ACTIVE=1;

-- Ejercicio 21 --
--Devuelve una lista de las últimas 10 películas a las que se ha accedido --

SELECT 
  M.MOVIE_ID,
  M.MOVIE_NAME,
  MAX(UA.ACCESS_DATE) AS Ultimo_Acceso
FROM MOVIES M
JOIN USER_MOVIE_ACCESS UA ON M.MOVIE_ID = UA.MOVIE_ID
GROUP BY M.MOVIE_ID, M.MOVIE_NAME
ORDER BY Ultimo_Acceso DESC
LIMIT 10;

-- Ejercicio 22 --
--Indica cuántas películas ha realizado cada director antes de cumplir 41 años --

SELECT DIRECTOR_NAME AS Director ,COUNT(MOVIE_ID) AS Numero_Peliculas FROM MOVIES M JOIN DIRECTORS D
ON M.DIRECTOR_ID=D.DIRECTOR_ID
WHERE (YEAR(CURDATE())-YEAR(DIRECTOR_BIRTH_DATE))<=41 AND (YEAR(DIRECTOR_BIRTH_DATE)-YEAR(MOVIE_RELEASE_DATE)) < 41
GROUP BY D.DIRECTOR_NAME;

-- Ejercicio 23 --
--Indica cuál es la media de duración de las películas de cada director --

SELECT DIRECTOR_NAME AS Director, AVG(MOVIE_DURATION) AS Duracion_Media FROM MOVIES M JOIN DIRECTORS D
ON D.DIRECTOR_ID=M.DIRECTOR_ID
GROUP BY DIRECTOR_NAME;

-- Ejercicio 24 --
--Indica cuál es la el nombre y la duración mínima de las películas a las que se ha accedido en los últimos 2 años por los miembros del plataforma --
-- (La “fecha de ejecución” de esta consulta es el 25-01-2019) --

SELECT 
  M.MOVIE_NAME AS Nombre, 
  MIN(M.MOVIE_DURATION) AS Duracion_Minima
FROM MOVIES M 
JOIN USER_MOVIE_ACCESS UM ON M.MOVIE_ID = UM.MOVIE_ID
WHERE (YEAR(DATE '2019-01-25') - YEAR(UM.ACCESS_DATE)) <= 2
GROUP BY M.MOVIE_NAME;

-- Ejercicio 25 --
--Indica el número de películas que hayan hecho los directores durante las décadas de los 60, 70 y 80 que contengan la palabra “The” en cualquier parte del título --

SELECT DIRECTOR_NAME AS Director, Count(MOVIE_ID) AS Numero_Peliculas
FROM MOVIES M JOIN DIRECTORS D ON D.DIRECTOR_ID=M.DIRECTOR_ID
WHERE MOVIE_RELEASE_DATE BETWEEN (DATE '1960-01-01') AND (DATE '1990-12-31') AND MOVIE_NAME LIKE 'The%'
GROUP BY DIRECTOR_NAME;

--DIFICULTAD DIFÍCIL--
-- Ejercicio 26 --
--Lista nombre, nacionalidad y director de todas las películas --

SELECT MOVIE_NAME AS Nombre_Pelicula, NATIONALITY_NAME AS Nacionalidad_Pelicula, DIRECTOR_NAME AS Director_Pelicula
FROM MOVIES M JOIN DIRECTORS D ON M.DIRECTOR_ID=D.DIRECTOR_ID
JOIN NATIONALITIES N ON N.NATIONALITY_ID=M.NATIONALITY_ID;

-- Ejercicio 27 --
--Muestra las películas con los actores que han participado en cada una de ellas --

SELECT MOVIE_NAME AS Pelicula, ACTOR_NAME AS Actor
FROM MOVIES_ACTORS MA JOIN MOVIES M ON MA.MOVIE_ID=M.MOVIE_ID
JOIN ACTORS A ON MA.ACTOR_ID=A.ACTOR_ID;

-- Ejercicio 28 --
--Indica cual es el nombre del director del que más películas se ha accedido --

SELECT D.DIRECTOR_NAME AS Director, COUNT(ACCESS_ID) AS Cantidad_Accesos FROM MOVIES M 
JOIN DIRECTORS D ON D.DIRECTOR_ID=M.DIRECTOR_ID
JOIN USER_MOVIE_ACCESS UM ON M.MOVIE_ID=UM.MOVIE_ID
GROUP BY DIRECTOR_NAME
ORDER BY COUNT(ACCESS_ID) DESC LIMIT 1;

-- Ejercicio 29 --
--Indica cuantos premios han ganado cada uno de los estudios con las películas que han creado --

SELECT STUDIO_NAME AS Estudio_Nombre, COUNT(AWARD_ID) AS Cantidad_Premios
FROM MOVIES M JOIN AWARDS AW ON AW.MOVIE_ID=M.MOVIE_ID
JOIN STUDIOS S ON S.STUDIO_ID=M.STUDIO_ID
GROUP BY STUDIO_NAME;

-- Ejercicio 30 --
--Indica el número de premios a los que estuvo nominado un actor, pero que no ha conseguido --
--(Si una película está nominada a un premio, su actor también lo está) --

SELECT ACTOR_NAME AS Actor, COUNT(AWARD_ALMOST_WIN) AS Premios_Solo_Nominados
FROM MOVIES M 
JOIN AWARDS AW ON AW.MOVIE_ID=M.MOVIE_ID
JOIN MOVIES_ACTORS MA ON MA.MOVIE_ID=M.MOVIE_ID
JOIN ACTORS A ON A.ACTOR_ID=MA.ACTOR_ID
GROUP BY ACTOR_NAME;

-- Ejercicio 31 --
--Indica cuantos actores y directores hicieron películas para los estudios no activos --

SELECT COUNT(ACTOR_ID) AS Cantidad_Actores, COUNT(DIRECTOR_ID) AS Cantidad_Directores
FROM MOVIES M
JOIN DIRECTORS D ON D.DIRECTOR_ID=M.DIRECTOR_ID
JOIN MOVIES_ACTORS MA ON MA.MOVIE_ID=M.MOVIE_ID
JOIN ACTORS A ON MA.ACTOR_ID=A.ACTOR_ID
JOIN STUDIOS S ON S.STUDIO_ID=M.STUDIO_ID
WHERE STUDIO_ACTIVE=0;

-- Ejercicio 32 --
--Indica el nombre, ciudad, y teléfono de todos los miembros de la plataforma -- 
--que hayan accedido películas que hayan sido nominadas a más de 150 premios y ganaran menos de 50 --

SELECT USER_NAME AS Usuario_Nombre, USER_TOWN AS Usuario_Ciudad, USER_PHONE AS Usuario_Telefono
FROM MOVIES M 
JOIN USER_MOVIE_ACCESS UM ON M.MOVIE_ID=UM.MOVIE_ID
JOIN USERS U ON UM.USER_ID=U.USER_ID
JOIN AWARDS A ON A.MOVIE_ID=M.MOVIE_ID
WHERE AWARD_NOMINATION > 150 AND AWARD_WIN < 50;

-- Ejercicio 33 --
--Comprueba si hay errores en la BD entre las películas y directores --
--(un director muerto en el 76 no puede dirigir una película en el 88) --

SELECT DIRECTOR_NAME AS Director, YEAR(DIRECTOR_DEAD_DATE) AS Anub_Mortalis, YEAR(MOVIE_RELEASE_DATE) AS Anub_Movialis
FROM MOVIES M JOIN DIRECTORS D ON D.DIRECTOR_ID=M.DIRECTOR_ID
WHERE (YEAR(DIRECTOR_DEAD_DATE) - YEAR(MOVIE_RELEASE_DATE) ) < 0;

-- Al parecer si hay algunos directores que figuran en la BD como que dirigieron algunas peliculas despues de muertos, zombies sin duda --

-- Ejercicio 34 --
--Utilizando la información de la sentencia anterior, modifica la fecha de defunción --
-- a un año más tarde del estreno de la película (mediante sentencia SQL) --

UPDATE DIRECTORS
SET DIRECTOR_DEAD_DATE = '2003-05-25' WHERE DIRECTOR_ID=27; 

--DIFICULTAD BERSERK--
--Ejercicio 35 --
--Indica cuál es el género favorito de cada uno de los directores cuando dirigen una película --

SELECT DIRECTOR_NAME AS Director, COUNT(GENRE_ID) AS Cantidad, GENRE_NAME AS Nombre FROM MOVIES M
JOIN GENRES G ON G.GENRE_ID=M.GENRE_ID JOIN DIRECTORS D ON D.DIRECTOR_ID=M.DIRECTOR_ID
GROUP BY GENRE_NAME, DIRECTOR_NAME;


-- Ejercio 36 --
--Indica cuál es la nacionalidad favorita de cada uno de los estudios en la producción de las películas --

SELECT 
  S.STUDIO_NAME AS Estudio_que_la_Prefiere,
  N.NATIONALITY_NAME AS Nacionalidad_Favorita,
  COUNT(*) AS Veces
FROM MOVIES M
JOIN STUDIOS S ON M.STUDIO_ID = S.STUDIO_ID
JOIN NATIONALITIES N ON M.NATIONALITY_ID = N.NATIONALITY_ID
GROUP BY S.STUDIO_ID, S.STUDIO_NAME, N.NATIONALITY_NAME
HAVING COUNT(*) = (
  SELECT MAX(CANT)
  FROM (
    SELECT COUNT(*) AS CANT
    FROM MOVIES M2
    WHERE M2.STUDIO_ID = S.STUDIO_ID
    GROUP BY M2.NATIONALITY_ID
  )
);

-- Ejercico 37 --
--Indica cuál fue la primera película a la que accedieron los miembros de la plataforma --
--cuyos teléfonos tengan como último dígito el ID de alguna nacionalidad --

SELECT DISTINCT USER_NAME Usuario, MOVIE_NAME Pelicula FROM MOVIES M1 
JOIN USER_MOVIE_ACCESS UM1 ON M1.MOVIE_ID=UM1.MOVIE_ID
JOIN USERS U1 ON U1.USER_ID=UM1.USER_ID
WHERE USER_PHONE IN (SELECT DISTINCT USER_PHONE AS Telefono FROM MOVIES M 
JOIN USER_MOVIE_ACCESS UM ON M.MOVIE_ID=UM.MOVIE_ID
JOIN USERS U ON U.USER_ID=UM.USER_ID
JOIN NATIONALITIES N ON N.NATIONALITY_ID=M.NATIONALITY_ID
WHERE RIGHT(U.USER_PHONE, 1) IN (
SELECT CAST(N.NATIONALITY_ID AS VARCHAR) FROM NATIONALITIES N
)) AND UM1.ACCESS_DATE =(SELECT MIN(UM2.ACCESS_DATE) FROM USER_MOVIE_ACCESS UM2 WHERE UM2.USER_ID=U1.USER_ID)
GROUP BY MOVIE_NAME, USER_NAME
ORDER BY USER_NAME ASC;