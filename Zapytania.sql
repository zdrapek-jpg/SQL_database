use  bazadanychfirma;
#1. Wybrać zamówienia których wartość przekracza średnią wszystkich zamówień i posortować malejąco według daty.
#2. Wybrać pracownika w powiązaniu z jego danymi
#3. Wybrać liczbę zamówień dokonanych przez każdego klienta.
#4. Wybrać pracowników obsługujących co najmniej 2 zamówienia.
#5. Wybrać pracownika który jest najdłużej w firmie.
#6. Wyświetlić liczbę zamówień pogrupowaną po statusie.
#7 dla każdego pracownika  f. agregujące 
#a) Imię i nazwisko pracownika ( w jednej kolumnie)
#b) Liczba zamówień obsłużonych przez pracownika
#c) Najdroższe zamówienie zrealizowane w aktualnym roku
#d) Staż w firmie w miesiącach
#e) Sumaryczna wartość zamówień w tysiącach
#f) Czy pracownik należy do więcej niż jednego działu
# 1
SELECT o.*, srednia.aver
FROM orders AS o
JOIN (SELECT AVG(price) AS aver FROM orders) AS srednia
ON o.price > srednia.aver
order by DateOf desc ;
# 2 
SELECT * FROM worker as w  
INNER JOIN workers_data as d ON w.workerId = d.workerId;
# 3 
Select c.*, COUNT(o.ClientId) as zamowienia from  clients AS c 
INNER JOIN orders AS o ON c.clientId = o.clientId
Group by  o.clientId order by zamowienia DESC;
# 4
SELECT w.*, COUNT(o.workerId) AS zliczanie FROM orders AS o 
INNER JOIN  worker AS w ON o.workerId=w.workerId
GROUP BY o.workerId
HAVING COUNT(o.workerId)>1
order by o.workerId ;
# 5
SELECT * FROM worker
order by date_of_join asc limit 1;
# 6
SELECT order_status,COUNT(order_status)  AS ilosc from orders 
group by order_status
order by ilosc ;
# 7  a,b d
 SELECT 
 t.ile_zamowien,
TIMESTAMPDIFF(month, o.dateOf,NOW()) AS data_months,
concat(w.name, ' ', w.surname ) as CALY,  d.*
 FROM worker AS w 
 INNER JOIN workers_data as d ON w.workerId =d.workerId
 left JOIN 
 (SELECT workerId, Count(orderId) as ile_zamowien
 FROM orders 
 group by workerId  ) as t ON  w.workerId = t.workerId
 INNER JOIN orders AS o ON o.workerId = t.workerId
 order by CALY;


SELECT 
  CONCAT(w.name, ' ', w.surname) AS full_name,  -- a) Imię i nazwisko pracownika ( w jednej kolumnie)
  COUNT(o.orderId) AS num_orders,  -- b) Liczba zamówień obsłużonych przez pracownika
  TIMESTAMPDIFF(MONTH, w.date_of_join, NOW()) AS tenure_months,  -- d) Staż w firmie w miesiącach
  SUM(o.price) / 1000 AS total_order_value_k  -- e) Sumaryczna wartość zamówień w tysiącach
  
FROM worker AS w
INNER JOIN workers_data AS d ON w.workerId = d.workerId
LEFT JOIN orders AS o ON w.workerId = o.workerId
GROUP BY w.workerId 
ORDER BY full_name;

 
 