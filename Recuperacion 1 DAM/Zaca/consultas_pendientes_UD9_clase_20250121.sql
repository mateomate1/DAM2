/* 12. Recupera la ciudad donde vive el cliente o clientes que menos dinero han gastado en el videoclub */

		-- Tallahassee
		
select ci.city
from city ci
INNER JOIN address a
on ci.city_id=a.city_id
INNER JOIN customer cu
ON a.address_id=cu.address_id
INNER JOIN payment pa
ON cu.customer_id=pa.customer_id
group by cu.customer_id
having sum(pa.amount) <= ALL (SELECT sum(p.amount) FROM PAYMENT p group by p.customer_id);


/* 13. Recupera las ciudades donde viven los 4 clientes que menos dinero han gastado en el videoclub */


		-- Tallahassee
		-- Fuzhou
		-- Bydgoszcz
		-- al-Qadarif

select ci.city, cu.first_name, cu.last_name , sum(pa.amount)
from city ci
INNER JOIN address a
on ci.city_id=a.city_id
INNER JOIN customer cu
ON a.address_id=cu.address_id
INNER JOIN payment pa
ON cu.customer_id=pa.customer_id
group by cu.customer_id
order by sum(pa.amount) ASC
LIMIT 4;
