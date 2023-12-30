--Zadanie 1 


EXPLAIN ANALYZE
SELECT 
  c.customerid, 
  c.personid,
  c.storeid,
  c.territoryid,
  soh.salesorderid, 
  soh.orderdate, 
  soh.duedate, 
  soh.shipdate
FROM sales.customer c
INNER JOIN sales.salesorderheader soh ON c.customerid = soh.customerid
WHERE c.territoryid = 5;

CREATE INDEX idx_customerid ON sales.customer (customerid);
CREATE INDEX idx_territoryid ON sales.customer (territoryid);
CREATE INDEX idx_orderdate ON sales.salesorderheader (orderdate);


EXPLAIN ANALYZE
SELECT 
  c.customerid, 
  c.personid,
  c.storeid,
  c.territoryid,
  soh.salesorderid, 
  soh.orderdate, 
  soh.duedate, 
  soh.shipdate
FROM sales.customer c
INNER JOIN sales.salesorderheader soh ON c.customerid = soh.customerid
WHERE c.territoryid = 5;


--Zadanie 2
--a
BEGIN TRANSACTION;

UPDATE Production.Product
SET ListPrice = ListPrice * 1.1 --ListPrice to cena produktu
WHERE ProductID = 680;

COMMIT;

--b
BEGIN TRANSACTION;

--musimy tez usunac bo powiazane kluczmi obcymi 
DELETE FROM Production.ProductCostHistory
WHERE ProductID = 707;

DELETE FROM Production.Product
WHERE ProductID = 707;

ROLLBACK; 

--c
BEGIN TRANSACTION;

INSERT INTO production.product 
(
    productid,
    name, 
    productnumber, 
    makeflag, 
    finishedgoodsflag, 
    safetystocklevel, 
    reorderpoint, 
    standardcost, 
    listprice, 
    size, 
    sizeunitmeasurecode, 
    weightunitmeasurecode, 
    weight, 
    daystomanufacture, 
    productline, 
    class, 
    style, 
    productsubcategoryid, 
    productmodelid, 
    sellstartdate, 
    sellenddate, 
    discontinueddate
)
VALUES 
(
    DEFAULT,  --uzyje domyslnie nastepna wartosc
    'Nowy Produkt', 
    'XYZ123', 
    true, 
    true, 
    10, 
    5, 
    50.00, 
    100.00, 
    'XL', 
    'CM', 
    'KG', 
    2.5, 
    7, 
    'S', 
    'M', 
    'W', 
    1, 
    1, 
    NOW(), 
    NULL, 
    NULL
);

COMMIT;