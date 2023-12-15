--Zadanie 1

CREATE FUNCTION fib(n INT)
RETURNS BIGINT AS $$ --zwraca bigint
BEGIN --BEGIN i END zawieraha cialo funkcji
	IF n<=0 THEN
		RETURN 0;
	ELSEIF n=1 THEN
		RETURN 1;
	ELSE 
		RETURN fib(n-1) + fib(n-2);
	END IF;
END
$$ LANGUAGE plpgsql;

--SELECT fib(3); - wywolanie funkcji

CREATE OR REPLACE PROCEDURE fib_p(n INT)
LANGUAGE plpgsql
AS $$
DECLARE
	count INT :=1;
	res BIGINT;
BEGIN
	WHILE count <=n 
	LOOP
		res :=fib(count);
		RAISE NOTICE 'Agrument: % Fibonacci value: %', count, res;
		count:=count+1;
	END LOOP;
END;
$$;

CALL fib_p(10); --wywolanie procedury


--Zadanie 2

CREATE FUNCTION uppercase()
RETURNS TRIGGER AS $$
BEGIN 
	NEW.lastname :=UPPER(NEW.lastname);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER bef_insert
BEFORE INSERT ON person.person --uruchamiany przed wstawieniem rekordu 
FOR EACH ROW
EXECUTE FUNCTION uppercase();


--Zadanie 3
CREATE FUNCTION taxMonitoring()
RETURNS TRIGGER AS $$
DECLARE
	oldTax DECIMAL;
	newTax DECIMAL;
	change DECIMAL;
BEGIN
	oldTax :=OLD.TaxRate;
	newTax :=NEW.TaxRate;
	
	change :=ABS((newTax-oldTax)/oldTax)*100;
	
	IF change >30 THEN 
		RAISE EXCEPTION 'Blad: Zmiana wartosci w polu TaxRate przekracza 30%%';
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER taxRateMonitoring 
BEFORE UPDATE ON sales.salestaxrate
FOR EACH ROW
EXECUTE FUNCTION taxMonitoring();








