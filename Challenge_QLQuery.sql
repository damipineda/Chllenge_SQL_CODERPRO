/*Primera consulta Usuaios con mayor reputacion*/
SELECT TOP 200 DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC;

/*Segunda consulta propietario del post*/

SELECT TOP 200
Posts.Title, Users.DisplayName
FROM Posts
INNER JOIN Users ON Posts.OwnerUserId = Users.Id
WHERE Posts.OwnerUserId IS NOT NULL;

/*Tercera consulta promedios 200 tablas*/

SELECT TOP 200
u.DisplayName, AVG(p.Score) AS AvgScore
FROM Posts p
JOIN Users u ON p.OwnerUserId = u.Id
GROUP BY u.DisplayName;


/*Cuarta consulta Display name de usuarios que han realizado 100 comentarios*/

SELECT Top 200
DisplayName 
FROM Users
WHERE Id IN (
    SELECT UserId
    FROM Comments
    GROUP BY UserId
    HAVING COUNT(*) > 100
);

/*5 consulta actualizar la columna location de user, pasan de vacias a desconocido*/

UPDATE Users 
SET Location = 'Desconocido'
WHERE Location IS NULL OR Location = '';

Print 'Actualización realizada correctamente'; 

/* Para ver*/
SELECT TOP 200 Id, DisplayName, Location
From Users

WHERE Location = 'Desconocido';

/*6 consulta todos los comentarios realizados por usuarios con menos de 100 de reputación eliminados*/

DELETE Comments
FROM Comments
JOIN Users ON Comments.UserId = Users.Id
WHERE Users.Reputation < 100;
/*Muestra mensaje de confirmacion con numero de filas eliminadas*/
PRINT 'Numero de comentrios eliminados: ' + CAST (@@ROWCOUNT AS NVARCHAR(10));

/*7 consulta muestra el total de publicaciones, post, comentarios y medallas*/

SELECT TOP 200
	Users.DisplayName,
	(SELECT COUNT (*) FROM Posts WHERE OwnerUserId = Users.Id) As TotalPosts,
	(SELECT COUNT (*) FROM Comments WHERE UserId = Users.Id) As TotalComments,
	(SELECT COUNT (*) FROM Badges WHERE UserId = Users.Id) As TotalBadges
FROM
	Users
ORDER BY
	TotalPosts DESC, Users.DisplayNAme;

/* 8 Muestra las 10 publicaciones más populares basadas en la puntuación */

SELECT TOP 10 Title, Score
FROM Posts
WHERE
Title IS NOT NULl
ORDER BY Score DESC;
 
 /* 9 Muestra los 5 comentarios más recientes de la tabla */
SELECT TOP 5 Text, CreationDate
FROM Comments
ORDER BY CreationDate DESC;

