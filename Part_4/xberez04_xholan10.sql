-----------------------------------------------------------------------
--IDS (Database Systems) task 3.
--Authors: Berezovskaia Anastasiia (xberez04), Holáň Patrik (xholan10).
-----------------------------------------------------------------------

DROP TABLE complaint;
DROP TABLE productOrder;
DROP TABLE employee;
DROP TABLE customer;
DROP TABLE username;
DROP TABLE product;
DROP TABLE category;
DROP TABLE contains;

DROP MATERIALIZED VIEW customers_living_in_Brno;


CREATE TABLE username
(
    usernameID          INT GENERATED BY DEFAULT AS IDENTITY,
    name                VARCHAR2(255) NOT NULL,
    lastname            VARCHAR2(255) NOT NULL,
    phoneNumber         CHAR(13) NOT NULL,
    email               VARCHAR2(255) NOT NULL,
    address             VARCHAR2(255) NOT NULL,

    check (REGEXP_LIKE(phoneNumber, '^\+420\d{9}$'))
);

CREATE TABLE employee
(
    usernameID          INT NOT NULL,
    employeeID          INT GENERATED BY DEFAULT AS IDENTITY,
    dateOfBirth         DATE NOT NULL,
    --Rodné číslo.
    nationalIdNumber    INT NOT NULL,
    insurance           NUMBER(3) NOT NULL,
    startDate           DATE NOT NULL,
    finishDate          DATE,
    position            VARCHAR2(255) NOT NULL,
    salary              NUMBER(6) NOT NULL,
    accountNumber       VARCHAR2(18) NOT NULL,

    CHECK(MOD(nationalIdNumber, 11) = 0)     --if birth number is divisible by 11 -> it is valid.
);

CREATE TABLE customer
(
    usernameID          INT NOT NULL,
    customerID          INT GENERATED BY DEFAULT AS IDENTITY,
    login               VARCHAR2(255) NOT NULL,
    password            VARCHAR2(255) NOT NULL
);

CREATE TABLE complaint
(
    complaintNumber     INT GENERATED BY DEFAULT AS IDENTITY,
    productID           NUMBER(6) NOT NULL,
    description         VARCHAR2(255) NOT NULL,
    submissionDate      DATE NOT NULL,
    executionDate       DATE NOT NULL,
    state               VARCHAR2(255) NOT NULL,
    orderNumber         INT NOT NULL,
    employeeID          INT NOT NULL,
    customerID          INT NOT NULL
);

CREATE TABLE productOrder
(
    orderNumber         NUMBER GENERATED BY DEFAULT AS IDENTITY,
    orderDate           DATE NOT NULL,
    totalPrice          DECIMAL(8, 2) NOT NULL,
    address             VARCHAR2(255) NOT NULL,
    delivery            VARCHAR2(255) NOT NULL,
    payment             VARCHAR2(255) NOT NULL,
    productID           INT NOT NULL,
    employeeID          INT NOT NULL,
    customerID          INT NOT NULL
);

CREATE TABLE product
(
    productID          INT GENERATED BY DEFAULT AS IDENTITY,
    productName        VARCHAR2(255) NOT NULL,
    price              DECIMAL(8,2) NOT NULL,
    description        VARCHAR2(255) NOT NULL,
    inStock            NUMBER(6) NOT NULL,
    categoryID         INT NOT NULL
);

CREATE TABLE category
(
    categoryID        INT GENERATED BY DEFAULT AS IDENTITY,
    categoryName      VARCHAR2(255) NOT NULL
);


-- Link table contains -> product; product -> order.
CREATE TABLE contains
(
    orderNumber    NUMBER NOT NULL,
    productID      NUMBER NOT NULL,
    quantity       NUMBER NOT NULL
);


---------------------------------------------------------------------- PRIMARY KEYS --------------------------------------------------------------------------------------------
ALTER TABLE username ADD CONSTRAINT PK_username PRIMARY KEY(usernameID);
ALTER TABLE employee ADD CONSTRAINT PK_employee PRIMARY KEY(employeeID);
ALTER TABLE customer ADD CONSTRAINT PK_customer PRIMARY KEY(customerID);
ALTER TABLE complaint ADD CONSTRAINT PK_complaint PRIMARY KEY(complaintNumber);
ALTER TABLE productOrder ADD CONSTRAINT PK_productOrder PRIMARY KEY(orderNumber);
ALTER TABLE product ADD CONSTRAINT PK_product PRIMARY KEY(productID);
ALTER TABLE category ADD CONSTRAINT PK_category PRIMARY KEY(categoryID);


---------------------------------------------------------------------- FOREIGN KEYS --------------------------------------------------------------------------------------------
ALTER TABLE customer ADD CONSTRAINT FK_customer_username FOREIGN KEY(usernameID) REFERENCES username;
ALTER TABLE employee ADD CONSTRAINT FK_employee_username FOREIGN KEY(usernameID) REFERENCES username;
ALTER TABLE complaint ADD CONSTRAINT FK_complaint_employee FOREIGN KEY(employeeID) REFERENCES employee;
ALTER TABLE complaint ADD CONSTRAINT FK_complaint_customer FOREIGN KEY(customerID) REFERENCES customer;
ALTER TABLE productOrder ADD CONSTRAINT FK_productOrder_customer FOREIGN KEY(customerID) REFERENCES customer;
ALTER TABLE productOrder ADD CONSTRAINT FK_productOrder_employee FOREIGN KEY(employeeID) REFERENCES employee;
ALTER TABLE complaint ADD CONSTRAINT FK_complaint_productOrder FOREIGN KEY(orderNumber) REFERENCES productOrder;
ALTER TABLE productOrder ADD CONSTRAINT FK_productOrder_product FOREIGN KEY(productID) REFERENCES product;
ALTER TABLE product ADD CONSTRAINT FK_product_category FOREIGN KEY(categoryID) REFERENCES category;


---------------------------------------------------------------------- INSERT DATA ---------------------------------------------------------------------------------------------
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Jan', 'Novotný', '+420765455854', 'novotny@seznam.cz', 'Purkynova 587, 612 00 Brno');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Katerina', 'Veselá', '+420785442223', 'kate@seznam.cz', 'Olomoucká 998, 787 01 Šumperk');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('David', 'Horák', '+420458265452', 'davidhorak@centrum.cz', 'Mojmírova 144/14, 100 00 Praha');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Hana', 'Buchtíková', '+420785412564', 'buchtikova@gmail.com', 'Na Dolinách 555, 301 00 Plzeň');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Monika', 'Valášková', '+420854663247', 'valmon@gmail.com', 'Lumírova 478, 760 01 Zlín');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Josef', 'Dvořák', '+420754125445', 'josdvor@seznam.cz', 'Hradní 160, 690 02 Břeclav');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Jan', 'Palacký', '+420763455858', 'palac@gmail.com', 'Palackého třída 144, 612 00 Brno');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Tomáš', 'Srbský', '+420142547999', 'tomass@seznam.cz', 'Bratislavská 2A, 602 00 Brno');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Sofia', 'Logmanová', '+420333948260', 'sofialog@seznam.cz', 'Vodná 3, 638 00 Brno');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('František', 'Novák', '+420765454245', 'frant@gmail.com', 'Kolejní 2, 612 00 Brno');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Marek', 'Březina', '+420608517705', 'marbre@centrum.cz', 'Dyjská 468, 669 02 Znojmo');
INSERT INTO username (name, lastname, phoneNumber, email, address) VALUES ('Pavel', 'Plevák', '+420687774511', 'pleva@seznam.cz', 'Sadová 16, 678 01 Blansko');


INSERT INTO employee (usernameID, dateOfBirth, nationalIdNumber, insurance, startDate, finishDate, position, salary, accountNumber)
    VALUES (1, '05-08-1968', 6808051899, 211, '09-10-2010', null, 'prodavač', 24000, '217375089/0600');

INSERT INTO employee (usernameID, dateOfBirth, nationalIdNumber, insurance, startDate, finishDate, position, salary, accountNumber)
    VALUES (2, '08-04-1998', 9854089905, 201, '15-05-2019', null, 'účetní', 35000, '35-1319001257/0100');

INSERT INTO employee (usernameID, dateOfBirth, nationalIdNumber, insurance, startDate, finishDate, position, salary, accountNumber)
    VALUES (3, '30-07-1977', 7707303978, 211, '10-10-2020', null, 'prodavač', 26000, '300200232/0800');
    
INSERT INTO employee (usernameID, dateOfBirth, nationalIdNumber, insurance, startDate, finishDate, position, salary, accountNumber)
    VALUES (11, '07-10-1980', 8010073236, 209, '18-06-2018', '15-08-2020', 'skladník', 29500, '900500642/0800');
    
INSERT INTO employee (usernameID, dateOfBirth, nationalIdNumber, insurance, startDate, finishDate, position, salary, accountNumber)
    VALUES (12, '19-08-1979', 7908191192, 205, '06-06-2017', '10-07-2020', 'skladník', 28000, '185464512/0600');


INSERT INTO category (categoryName) VALUES ('Chytré hodinky');
INSERT INTO category (categoryName) VALUES ('Mobilní telefony');
INSERT INTO category (categoryName) VALUES ('Počítače a notebooky');
INSERT INTO category (categoryName) VALUES ('Televize');
INSERT INTO category (categoryName) VALUES ('Monitory');


INSERT INTO product (productName, price, description, inStock, categoryID) 
    VALUES ('Xiaomi Redmi Note 11 128GB šedá', 5799.90, '6.43" AMOLED 2400 x 1080, 90HZ, procesor Qualcomm Snapdragon 680 8 jádrový, RAM 4 GB', 20, 2);
    
INSERT INTO product (productName, price, description, inStock, categoryID) 
    VALUES ('27" MSI Optix MAG272CQR', 8990.40, 'LCD monitor prohnutý, Quad HD 2560 × 1440, VA, 16:9, 1 ms, 165Hz', 10, 5);
    
INSERT INTO product (productName, price, description, inStock, categoryID) 
    VALUES ('Lenovo Legion 5-17ACH6H Phantom Blue', 35989.50, 'Herní notebook - AMD Ryzen 7 5800H, 17.3" IPS antireflexní 1920 × 1080 144Hz, RAM 16GB DDR4', 14, 3);
    
INSERT INTO product (productName, price, description, inStock, categoryID) 
    VALUES ('65" LG 65UP7700', 14990.50, 'Televize SMART LED, 164cm, 4K Ultra HD, 50Hz, Direct LED, HDR10, HLG, DVB-T2/S2/C, H.265/HEVC, 2× HDMI, 1× USB', 15, 4); 
    
INSERT INTO product (productName, price, description, inStock, categoryID) 
    VALUES ('Samsung Galaxy Watch 4 Classic 46mm černé', 9990.90, 'Chytré hodinky s ovládáním v češtině, GPS, NFC platby skrze Google Pay', 30, 1);

INSERT INTO product (productName, price, description, inStock, categoryID) 
    VALUES ('iPhone 13 Pro 128GB grafitově šedá', 28990.90, '6,1" OLED 2532 × 1170, 120Hz, procesor Apple A15 Bionic 6jádrový, RAM 6 GB', 25, 2);

INSERT INTO product (productName, price, description, inStock, categoryID) 
    VALUES ('Lenovo IdeaPad 5 Pro 16ACH6 Cloud Grey kovový', 23690.50, 'AMD Ryzen 7 5800H, 16" IPS antireflexní 2560 × 1600 , RAM 16GB DDR4', 5, 3);

INSERT INTO product (productName, price, description, inStock, categoryID) 
    VALUES ('HP 250 G8 Dark Ash', 9990.90, 'Intel Core i3 1115G4 Tiger Lake, 15.6" VA antireflexní 1920 × 1080, RAM 8GB DDR4', 12, 3);
    
INSERT INTO product (productName, price, description, inStock, categoryID) 
    VALUES ('Samsung Galaxy A53 5G 128GB černá', 11499.40, '6,5" AMOLED 2400 × 1080, 120Hz, procesor Samsung Exynos 1280 8jádrový, RAM 6 GB', 20, 2);
    
    
INSERT INTO customer (usernameID, login, password) VALUES (4, 'xbucht12', 'mypasswd15#');
INSERT INTO customer (usernameID, login, password) VALUES (5, 'xvalas01', 'xsd44asd');
INSERT INTO customer (usernameID, login, password) VALUES (6, 'xdvora05', '15sdf546');
INSERT INTO customer (usernameID, login, password) VALUES (7, 'xpalac05', '15sd=!pf@f');
INSERT INTO customer (usernameID, login, password) VALUES (8, 'xsrbsk53', 'hJDak-)23');
INSERT INTO customer (usernameID, login, password) VALUES (9, 'xlogma00', '9302-5BBwejf');
INSERT INTO customer (usernameID, login, password) VALUES (10, 'xnovot19', 'gfgh!5BBfgdsf');

    
INSERT INTO productOrder (orderDate, totalPrice, address, delivery, payment, productID, employeeID, customerID) 
    VALUES ('25-06-2021', 29090.50, 'Hradní 160, 690 02 Břeclav', 'Česká pošta', 'kartou', 6, 3, 3);  
    
INSERT INTO productOrder (orderDate, totalPrice, address, delivery, payment, productID, employeeID, customerID) 
    VALUES ('28-1-2018', 9090.00, 'Kolejní 2, 612 00 Brno', 'PPL', 'při převzetí', 2, 1, 7);   
    
INSERT INTO productOrder (orderDate, totalPrice, address, delivery, payment, productID, employeeID, customerID) 
    VALUES ('14-9-2015', 15090.90, 'Vodná 3, 638 00 Brno', 'Česká pošta', 'při převzetí', 4, 1, 6);
    
INSERT INTO productOrder (orderDate, totalPrice, address, delivery, payment, productID, employeeID, customerID) 
    VALUES ('18-6-2021', 36089.50, 'Bratislavská 2A, 602 00 Brno', 'DHL', 'kartou', 3, 3, 5);
    
INSERT INTO productOrder (orderDate, totalPrice, address, delivery, payment, productID, employeeID, customerID) 
    VALUES ('02-03-2021', 11599.40, 'Lumírova 478, 760 01 Zlín', 'PPL', 'bankovním převodem', 9, 3, 2);
    
INSERT INTO productOrder (orderDate, totalPrice, address, delivery, payment, productID, employeeID, customerID) 
    VALUES ('04-08-2019', 10090.90, 'Na Dolinách 555, 301 00 Plzeň', 'DHL', 'kartou', 8, 1, 1);
    
INSERT INTO productOrder (orderDate, totalPrice, address, delivery, payment, productID, employeeID, customerID) 
    VALUES ('18-11-2018', 29090.50, 'Vodná 3, 638 00 Brno', 'PPL', 'kartou', 6, 1, 6);
    
    
INSERT INTO complaint (productID, description, submissionDate, executionDate, state, orderNumber, employeeID, customerID) 
    VALUES (6, 'zařízení nelze zapnout', '01-07-2021', '01-08-2021', 'vyřízeno', 1, 1, 3);
    
INSERT INTO complaint (productID, description, submissionDate, executionDate, state, orderNumber, employeeID, customerID) 
    VALUES (4, 've středu obrazovky se objevil svislý pruh', '16-07-2016', '16-08-2016', 'vyřízeno', 3, 3, 6);
    
INSERT INTO complaint (productID, description, submissionDate, executionDate, state, orderNumber, employeeID, customerID) 
    VALUES (8, 'nefunkční webkamera', '05-08-2019', '05-09-2019', 'vyřízeno', 6, 3, 1);
    
INSERT INTO complaint (productID, description, submissionDate, executionDate, state, orderNumber, employeeID, customerID) 
    VALUES (6, 'zařízení se nenabíjí', '05-09-2021', '05-10-2021', 'vyřízeno', 7, 3, 6);
    
    
INSERT INTO contains VALUES (1, 6, 1);
INSERT INTO contains VALUES (2, 2, 1);
INSERT INTO contains VALUES (3, 4, 1);
INSERT INTO contains VALUES (4, 3, 1);
INSERT INTO contains VALUES (5, 9, 1);
INSERT INTO contains VALUES (6, 8, 1);
INSERT INTO contains VALUES (7, 6, 1);


--------------------------------------------------------------------------- STATEMENTS -----------------------------------------------------------------------------------------
SELECT SUM(inStock) PC_in_stock FROM category c NATURAL JOIN product WHERE c.categoryname = 'Počítače a notebooky'; 
            -- lists the total number of goods from the category "Pocitace a notebooky" in stock

SELECT login FROM customer NATURAL JOIN productOrder WHERE payment = 'kartou' AND orderDate BETWEEN TO_DATE('01-01-2021') AND TO_DATE('31-12-2021');
            -- lists logins of customers who paid for order by card in 2021

SELECT lastname, name, count(*) complaints_finished FROM username NATURAL JOIN employee NATURAL JOIN complaint GROUP BY lastname, name; 
            -- lists names of employees who made some complaint and lists the number of complaints that each employee made
            
SELECT categoryname, SUM(inStock) in_stock FROM category NATURAL JOIN product GROUP BY categoryname ORDER BY SUM(inStock) DESC;
            -- lists the total number of products in stock in each category, sorted from the largest number to the smallest in stock
            
SELECT productID, productName FROM product WHERE NOT EXISTS (SELECT * FROM complaint where product.productID = complaint.productID); 
            -- lists the product ID and its name that has never been complained

SELECT lastname, name, email FROM username NATURAL JOIN customer WHERE customerID IN (SELECT customerID FROM productOrder WHERE totalPrice > 15000.00); 
            -- lists the lastname, name and email of customers who ordered goods for more than 15 000

            
--------------------------------------------------------- LAST PART ----------------------------------------------------------------------------------------------
SET SERVEROUTPUT ON;

----------------------------------------------------------------------------------------------
--TRIGGER on INSERT/UPDATE query. Controls login format in 'customer' table.

CREATE OR REPLACE TRIGGER customer_login_check
BEFORE INSERT OR UPDATE OF login ON customer
FOR EACH ROW
BEGIN
    IF (LENGTH(:NEW.login) != 8) THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error - invalid number of characters.');
    END IF;
    IF NOT REGEXP_LIKE(:new.login, '^x[a-z]{5}') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error - invalid xlogin format.');
    END IF;
    IF NOT REGEXP_LIKE(:new.login, '^x[a-z]{5}[0-9]{2}$') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Error - invalid number format.');
    END IF;
END;
/

---------------------------------------------------------------------------------------------
--TRIGGER on INSERT/UPDATE query. Prints out info about price changes.

CREATE OR REPLACE TRIGGER price_changes
BEFORE INSERT OR UPDATE OF price ON product
FOR EACH ROW
DECLARE
    difference INT;
    priceIncrease INT;
    priceDecrease INT;
BEGIN
    difference := :NEW.price - :OLD.price;
    priceIncrease := (:NEW.price / :OLD.price * 100) - 100;
    priceDecrease := (:OLD.price / :NEW.price * 100) - 100;
    dbms_output.put_line(:OLD.productName);
    dbms_output.put_line('Old price: ' || :OLD.price);
    dbms_output.put_line('New price: ' || :NEW.price);
    dbms_output.put_line('Price difference: ' || ABS(difference));
    IF(:OLD.price > :NEW.price) THEN
        dbms_output.put_line(priceDecrease || ' % discount');
    END IF;
    IF(:OLD.price < :NEW.price) THEN
        dbms_output.put_line('Price increased by ' || priceIncrease || ' %');
    END IF;
END;
/

UPDATE product
    SET price = 5799.90
WHERE productID = 1;

--------------------------------------------------------------------------------------------
--Procedure (using CURSOR) for counting percentage of fired employees from 'employee' table.

CREATE OR REPLACE PROCEDURE percentage_fired
    IS
        emp employee%ROWTYPE;
        totalNumberOfEmployees INT;
        totalNumberOfFired INT;
        CURSOR cursor_employee is select * from employee;
        begin
            totalNumberOfEmployees := 0;
            totalNumberOfFired := 0;
            OPEN
                cursor_employee;
                LOOP
                    FETCH cursor_employee into emp;
                    EXIT WHEN cursor_employee%NOTFOUND;
                    totalNumberOfEmployees := totalNumberOfEmployees + 1;
                    IF (emp.finishDate is not null) THEN
                        totalNumberOfFired := totalNumberOfFired + 1;
                    END IF;
                END LOOP;
                IF totalNumberOfEmployees = 0 THEN
                    RAISE ZERO_DIVIDE;
                END IF;
            CLOSE cursor_employee;
            dbms_output.put_line('Percentage of fired employees is ' || totalNumberOfFired / totalNumberOfEmployees * 100 ||'.');
            EXCEPTION
                WHEN zero_divide THEN
                    dbms_output.put_line('Can´t count percentage.');
                WHEN OTHERS THEN
                    dbms_output.put_line('Error');
END;
/    
   
EXEC percentage_fired;

------------------------------------------------------------------------------------------
--Procedure (using CURSOR) for counting an average age of employees from 'employee' table.

CREATE OR REPLACE PROCEDURE avgAgeEmployees AS
    emp employee%rowtype;
    ageTotal INT;
    employeeTotal INT;
    yearofBirth INT;
    currentYear INT;
    age INT;
    CURSOR employee_cursor IS SELECT * FROM employee;
    BEGIN
        ageTotal := 0;
        employeeTotal := 0;
        OPEN employee_cursor;
        LOOP
            FETCH employee_cursor INTO emp;
            EXIT WHEN employee_cursor%NOTFOUND;
            employeeTotal := employeeTotal + 1;
            yearofBirth := to_number(to_char(emp.dateOfBirth, 'YYYY'));
            currentYear := to_number(to_char(sysdate, 'YYYY'));
            IF (currentYear > yearofBirth) THEN
                age := currentYear - yearofBirth;
            END IF;
            IF (currentYear < yearofBirth) THEN
                RAISE_APPLICATION_ERROR(-20000, 'Year of birth can not be bigger than current year.');
            END IF;
            ageTotal := ageTotal + age;
        END LOOP;
        IF employeeTotal = 0 then
            RAISE ZERO_DIVIDE;
        END IF;
        dbms_output.put_line('Average age of employees is ' || ageTotal  / employeeTotal || '.');
        CLOSE employee_cursor;
        EXCEPTION
            WHEN ZERO_DIVIDE THEN
                 RAISE_APPLICATION_ERROR(-20000, 'Can not count average age.');
            WHEN OTHERS THEN
                 raise_application_error(-20001, 'Unexpected error.');
END;
/
    
EXEC avgAgeEmployees;    
    
--------------------------------------------------------------------------------------------
-- EXPLAIN PLAN pro: - listing names of products that were complained
--                   - number of how many times products were complained
-- uses joining two tables ('complaint', 'product') by productID

EXPLAIN PLAN FOR
    SELECT p.productName, count(*) AS complaintsTotal
    FROM complaint c, product p
    WHERE c.productID = p.productID
    GROUP BY c.productID, p.productName;
SELECT * FROM TABLE(dbms_xplan.display());


CREATE INDEX productID_idx ON complaint(productID);

EXPLAIN PLAN FOR
    SELECT p.productName, count(*) AS complaintsTotal
    FROM complaint c, product p
    WHERE c.productID = p.productID
    GROUP BY c.productID, p.productName;
SELECT * FROM TABLE(dbms_xplan.display());

--------------------------------------------------------------------------------------------
--VIEW on customers from Brno from 'username' and 'customer' tables.
--VIEW is performed by the second member of the team (xberez04).

CREATE MATERIALIZED VIEW customers_living_in_Brno AS
    SELECT  lastname,
            name,
            address 
    FROM xholan10.username NATURAL JOIN xholan10.customer WHERE address LIKE '% Brno'
    ORDER BY lastname, name;
    
SELECT * FROM customers_living_in_Brno;

--------------------------------------------------------------------------------------------
--Privilegues(access rights) to another member of the team.

GRANT ALL ON complaint TO xberez04;
GRANT ALL ON productOrder TO xberez04;
GRANT ALL ON employee TO xberez04;
GRANT ALL ON customer TO xberez04;
GRANT ALL ON username TO xberez04;
GRANT ALL ON product TO xberez04;
GRANT ALL ON category TO xberez04;
GRANT ALL ON contains TO xberez04;

GRANT EXECUTE ON avgAgeEmployees TO xberez04;
GRANT EXECUTE ON percentage_fired TO xberez04;
