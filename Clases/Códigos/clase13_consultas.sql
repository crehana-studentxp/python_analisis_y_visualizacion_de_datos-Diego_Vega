---Primeras consultas

SELECT * FROM data_TV;


SELECT * FROM data_TV ORDER BY first_air_date ASC; 
SELECT * FROM data_TV ORDER BY first_air_date DESC; 

SELECT count(name_show) FROM data_TV;
SELECT sum(vote_count) FROM data_TV;




SELECT length(origin_country),
	   IIF(origin_country IN ('character(0)'),NULL,IIF(length(origin_country) > 2,SUBSTR(origin_country,4,2),origin_country))new_origin_country,
       origin_country
FROM data_TV
ORDER BY 1 DESC;

SELECT IIF(first_air_date IN ('NA'),NULL,first_air_date)new_first_air_date,
	   first_air_date 
FROM data_TV 
ORDER BY 1 ASC;

SELECT IIF(vote_average IN ('NA'),0,vote_average),
	   vote_average
FROM data_TV
ORDER BY 1 ASC;

---consulta final
SELECT IIF(first_air_date IN ('NA'),NULL,first_air_date)new_first_air_date,
	   IIF(origin_country IN ('character(0)'),NULL,IIF(length(origin_country) > 2,SUBSTR(origin_country,4,2),origin_country))new_origin_country,
       IIF(vote_average IN ('NA'),0,vote_average)new_vote_average,
       original_language,
       name_show,
       popularity,
       vote_count,
       overview  
	   
FROM data_TV;


---Duplicados
SELECT count(name_show) FROM data_TV;
SELECT count(DISTINCT name_show) FROM data_TV;

SELECT * FROM data_TV WHERE name_show IN ('Dexter');
SELECT * FROM data_TV WHERE name_show IN ('Catch-22');

---todos los duplicados por nombre
SELECT *
FROM (SELECT *,ROW_NUMBER() OVER(PARTITION BY name_show ) AS fila FROM data_TV)
WHERE fila > 1
ORDER BY name_show ASC;