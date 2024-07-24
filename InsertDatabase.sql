use bazadanychfirma;

INSERT INTO worker (name, surname, age, date_of_join, qualifications) VALUES
('John', 'Doe', 30, '2020-01-01', 'Bachelor of Science'),
('Jane', 'Smith', 28, '2019-02-15', 'Master of Arts'),
('Mike', 'Johnson', 35, '2018-03-10', 'PhD'),
('Lisa', 'Brown', 40, '2017-04-20', 'Bachelor of Engineering'),
('Chris', 'Davis', 45, '2016-05-30', 'Master of Business Administration'),
('Chris', 'DaviWorkerIds', 45, '2016-05-30', 'Master of Business Administration'),
('Chris', 'Davis', 45, '2016-05-30', 'Master of Business Administration'),
('Karolina', 'Kau', 45, '2023-05-30', 'Master of Business Administration'),
('Kinga', 'Aut', 45, '2024-01-22', 'Master of Business Administration');
 
INSERT INTO department (departmentId, boss, phone, officeRoom,section) VALUES
(1, 'John Doe', 1234567890, 12,"Dostawa"),
(2, 'Kinga Aut', 2345678901, 43,"Księgowość"),
(3, 'Karolina Kau', 3456789012, 54,"Magazyn");



INSERT INTO Department_Worker (departmentId, workerId) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(2, 9);


INSERT INTO workers_Data (pesel, phoneNr, insurance, salary, workerId) VALUES
('53111722112', 1234567890, 'VIP', 500000, 1),
('54011916166', 2345678901, 'Basic', 6000, 2),
('73061326637', 3456789012, 'Basic', 7000, 3),
('45678901234', 4567890123, 'Full', 8000, 4),
('67040389735', 5678901234, 'Basic', 9000, 5),
('82053137728', 6789012345, 'BASIC', 4900, 6),
('64011348478', 537822111, 'Full', 91100, 7),
('78901234567', 537822111, 'VIP', 81100, 8),
('95070493315', 537822111, 'VIP', 41100, 9);

INSERT INTO clients (phone_number, post_code, post, parcel_target, smart, ifCompany) VALUES
('123456789', '23-301', '123 Main St', 'Janów Lubelski', TRUE, FALSE),
('123456789', '23-302', '456 Oak St', 'Godziszów', FALSE, FALSE),
('123456789', '23-300', '789 Pine St', 'Modliborzyce', TRUE, FALSE),
('123456789', '23-300', '101 Maple St', 'Modliborzyce', TRUE, FALSE),
('123456789', '23-300', '202 Birch St', 'Modliborzyce', FALSE, FALSE),
('123456789', '23-302', '303 Cedar St', 'Godziszów', TRUE, FALSE),
('123456789', '23-302', '404 Walnut St', 'Godziszów', FALSE, FALSE),
('123456789', '23-300', '505 Chestnut St', 'Godziszów', TRUE, FALSE),
('123456789', '23-300', '606 Redwood St', 'Modliborzyce', FALSE, FALSE),
('123456789', '23-300', '707 Elm St', 'Modliborzyce', FALSE, FALSE),
('123456789', '23-300', '702 Elm St', 'Modliborzyce', FALSE, FALSE),
('123456789', '23-300', '606 Redwood', 'Modliborzyce', FALSE, FALSE),
('123456789', '23-301', '701 Elm St', 'Janów Lubelski', TRUE, TRUE);


INSERT INTO orders(DateOf, Price, Order_Status, ClientId, WorkerId) VALUES
('2023-01-01', 1213.0, 'DONE',  1, 1),
('2023-02-01', 1233.0, 'IN PROGRESS',  1, 4),
('2023-03-01', 2230.0, 'CANCELED',  3, 2),
('2023-04-01', 200.0, 'DONE',  4, 3),
('2023-05-01', 30.0, 'IN PROGRESS', 5, 4),
('2023-01-01', 100.0, 'DONE',  1, 1),
('2023-02-01', 100.0, 'DONE', 1, 1),
('2023-03-01', 200.0, 'CANCELED',3, 2),
('2023-04-01', 2000.0, 'DONE',  4, 2),
('2023-05-01', 3000.0, 'IN PROGRESS',5, 4),
('2023-01-01', 1100.0, 'CANCELED',  1, 1),
('2023-02-01', 1900.0, 'IN PROGRESS',1, 1),
('2023-03-01', 200.0, 'CANCELED',  3, 4),
('2023-04-01', 250.0, 'CANCELED', 4, 4),
('2023-05-01', 399.0, 'CANCELED', 5, 4);


INSERT INTO store (amount, price_for_1,name, is_empty) VALUES
(150, 10.50,"Suszarki",FALSE),
(200, 15.75,"druty", FALSE),
(100, 12.00,"Siekiery", FALSE),
(50, 8.25,"Kurtki", FALSE),
(17500, 9.99,"Prezerwatywy", FALSE);

INSERT INTO one_order (itemId, orderId, amount, price) VALUES
(1, 1, 10, NULL),
(1, 2, 20, NULL),
(1, 3, 11, NULL),
(2, 4, 5, NULL),
(2, 5, 25, NULL),
(3, 6, 11, NULL),
(3, 7, 20, NULL),
(3, 8, 15, NULL),
(4, 9, 5, NULL),
(4, 10, 15, NULL),
(4, 11, 5, NULL),
(4, 12, 1, NULL),
(1, 13, 5, NULL),
(1, 14, 15, NULL),
(1, 14, 5, NULL),
(3, 1, 10, NULL),
(3, 2, 20, NULL),
(3, 3, 2, NULL);

#update ilosć x cena w one_order
UPDATE one_order as o 
INNER JOIN store AS s ON o.itemId = s.itemId
SET o.price = o.amount*s.price_for_1;

# update w zamoówienie sumowanie warotści z pojedyńczych zamóień produktów i zliczanie ich 
UPDATE orders as o 
INNER JOIN 
(SELECT one.orderId, SUM(one.price) as total  from one_order as one   GROUP BY orderId) as suma 
ON o.orderId  = suma.orderId
SET o.price =  suma.total;

# DROP TRIGGER IF EXISTS  bazadanychfirma.while_update_one_order_up_store;
 
 INSERT INTO one_order  (itemId, orderId, amount, price) VALUES
 (1, 5, 20, NULL);
 # ZWRACA WYJĄTEK  BO ZA DUŻO 
 INSERT INTO one_order  (itemId, orderId, amount, price) VALUES
 (1, 5, 140, NULL);