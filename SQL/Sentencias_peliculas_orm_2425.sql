USE peliculas_orm_2425;
SELECT * FROM actores,direcciones
WHERE cod_direccion = cod_dir;

delete from actores where cod_act>4;
delete from direcciones where cod_dir >4;

INSERT INTO direcciones(calle,numero) values ('calle one',9);
SELECT * FROM direcciones;
SELECT * FROM actores;
SELECT * FROM directores;
SELECT * FROM peliculas p, directores d
where p.cod_dire=d.cod_director;

SELECT * 
FROM actores a, direcciones d
WHERE a.cod_direccion = d.cod_dir;

select a.nombre, d.calle, d.numero, 
CASE WHEN i.es_protagonista IS FALSE THEN 'NO' ELSE 'SI' 
END AS protagonista, p.titulo
from actores a 
INNER JOIN direcciones d ON a.cod_direccion=d.cod_dir 
INNER JOIN protagonistas i ON a.cod_act = i.cod_actor
INNER JOIN peliculas p ON i.cod_pelicula = p.cod_peli; 

select a.nombre, d.calle, d.numero, p.titulo
from actores a 
INNER JOIN direcciones d ON a.cod_direccion=d.cod_dir 
INNER JOIN interpretes i ON a.cod_act = i.cod_actor
INNER JOIN peliculas p ON i.cod_pelicula = p.cod_peli; 

delete from protagonistas where cod_pelicula <> 1;
delete from actores where cod_act > 4;
delete from peliculas where cod_peli>1;