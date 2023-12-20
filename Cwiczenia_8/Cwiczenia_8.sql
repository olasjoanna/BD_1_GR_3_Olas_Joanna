--Common Table Expression (CTE) to tymczasowa, nazwana tabela utworzona w obrębie 
--jednego zapytania SQL. CTE umożliwia nazwanie podzapytania i odwoływanie się do niego 
--w ramach większego zapytania. Jest to przydatne narzędzie, zwłaszcza gdy potrzebujesz 
--wielokrotnie używać tego samego podzapytania w głównym zapytaniu.

-- tworzenie CTE, które znajduje najwyższą stawkę w historii płac pracownika
WITH MaxSalaryCTE AS (
    SELECT
        e.BusinessEntityID,
        p.FirstName,
        p.LastName,
        MAX(e.Rate) AS MaxRate
    FROM
        humanresources.EmployeePayHistory e
    JOIN
        person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    GROUP BY
        e.BusinessEntityID, p.FirstName, p.LastName
)

-- tworzenie tabeli tymczasowej TempEmployeeInfo i wstawiamy dane
SELECT
    BusinessEntityID AS EmployeeID,
    FirstName,
    LastName,
    MaxRate AS HighestSalary
INTO
    TempEmployeeInfo
FROM
    MaxSalaryCTE;
	
--Zadanie 2	
WITH CustomerSalesInfo AS (
    SELECT
        c.customerid,
        c.territoryid,
        s.businessentityid
    FROM
        sales.customer c
    JOIN
        sales.salesperson s ON c.TerritoryID = s.TerritoryID
)

-- rozszerzanie CTE, dodajemy imię i nazwisko salesperson z tabeli person.person
, ExtendedCustomerSalesInfo AS (
    SELECT
        csi.customerid,
        csi.territoryid,
        p.FirstName,
        p.LastName
    FROM
        CustomerSalesInfo csi
    JOIN
        person.person p ON csi.businessentityid = p.BusinessEntityID
)

--sprawdzenie wyniku
SELECT
    ecsi.customerid,
    ecsi.territoryid,
    ecsi.FirstName,
    ecsi.LastName
FROM
    ExtendedCustomerSalesInfo ecsi;