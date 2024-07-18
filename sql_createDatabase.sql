CREATE DATABASE bazadanychfirma;
USE bazadanychfirma;


CREATE TABLE worker(
workerId int NOT NULL PRIMARY KEY auto_increment,
name CHAR(50) NOT NULL,
surname CHAR(50) NOT NULL,
age INT,
date_of_join date,
qualifications VARCHAR(100)
);


CREATE TABLE department(
departmentId int PRIMARY KEY auto_increment,
boss CHAR(200) 	NOT NULL  ,
phone BIGINT,
officeRoom INT,
section CHAR(100)
);

CREATE TABLE Department_Worker (
    departmentId INT,
    workerId INT,
    PRIMARY KEY (departmentId, workerId),
    FOREIGN KEY (departmentId) REFERENCES department(departmentId)
    ON DELETE CASCADE
    ON UPDATE CASCADE ,
    FOREIGN KEY (workerId) REFERENCES Worker(workerId)
    ON DELETE CASCADE
    ON UPDATE CASCADE 
);

CREATE TABLE workers_Data(
infoId int PRIMARY KEY NOT NULL auto_increment,
pesel CHAR(11),
phoneNr BIGINT,
insurance ENUM("Basic","Full","VIP") DEFAULT null,
salary INT,
workerId int,
FOREIGN KEY (workerId) REFERENCES worker(WorkerId)
ON DELETE CASCADE
ON UPDATE CASCADE 
);

CREATE TABLE clients(
clientId int PRIMARY KEY NOT NULL auto_increment,
phone_number CHAR(9),
post_code CHAR(7),
post char(50),
parcel_target CHAR(30),
smart BOOLEAN,
ifCompany BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE orders(
orderId int auto_increment PRIMARY KEY ,
dateOf DATE,
order_Status ENUM("DONE","IN PROGRESS","CANCELED")DEFAULT NULL,
price DECIMAL(8,2),
clientId int,
workerId int,
FOREIGN KEY (clientId) REFERENCES clients(clientId)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (workerId) REFERENCES worker(workerId)
ON DELETE CASCADE 
ON UPDATE CASCADE 
);

CREATE TABLE store(
 itemId INT  AUTO_INCREMENT PRIMARY  KEY  ,
 amount INT,
 price_for_1 decimal(7,2),
 name char(20),
 is_empty BOOLEAN 
);

CREATE TABLE one_order (
    itemId INT,
    orderId INT,
    amount INT ,
    price DECIMAL(10,2),
    FOREIGN KEY (itemId) REFERENCES store(itemId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (orderId) REFERENCES orders(orderId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);