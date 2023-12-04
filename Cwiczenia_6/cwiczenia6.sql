--Zadanie 1
--a
ALTER TABLE rozliczenia.pracownicy
ALTER COLUMN telefon TYPE VARCHAR(20);

UPDATE rozliczenia.pracownicy
SET telefon = '(+48)' || telefon
WHERE telefon IS NOT NULL;

--b
--SUBSTR(tekst,poczstek,dlugosc)
UPDATE rozliczenia.pracownicy
SET telefon = SUBSTR(telefon,1,3) || '-' || SUBSTR(telefon,4,3) || '-' || SUBSTR(telefon,7,3)
WHERE telefon IS NOT NULL

--c
SELECT * FROM rozliczenia.pracownicy
WHERE LENGTH(nazwisko) = (SELECT MAX(LENGTH(NAZWISKO)) FROM rozliczenia.pracownicy);

--d
SELECT ksiegowosc.wynagrodzenie.id_pracownika, 
	ksiegowosc.pracownicy.imie, 
	ksiegowosc.pracownicy.nazwisko, 
	md5(ksiegowosc.pensja.kwota::text) AS kod_pensja
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika

--e
SELECT ksiegowosc.pracownicy.id_pracownika,
	ksiegowosc.pracownicy.imie,
	ksiegowosc.pracownicy.nazwisko,
	ksiegowosc.pensja.kwota AS pensja,
	ksiegowosc.premia.kwota AS premia
FROM ksiegowosc.wynagrodzenie

LEFT JOIN 
	ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN
	ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
JOIN
	ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika;

--f
SELECT
CONCAT( 'Pracownik ', pracownicy.imie, ' ', pracownicy.nazwisko, 
	  ' w dniu ', wynagrodzenie.data,' otrzymal pensje calkowita na kwote ',
	  (premia.kwota+pensja.kwota), ' gdzie wynagrodzenie zasadnicze wynosilo: ', pensja.kwota,
	  'premia: ', premia.kwota, ' zl') AS raport
FROM
    ksiegowosc.wynagrodzenie
JOIN
    ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
JOIN
    ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
JOIN
    ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii;

--Zadanie 2
CREATE SCHEMA zad2a

CREATE TABLE zad2a.pracownicy (
	IDPracownika INT PRIMARY KEY,
	NazwaLekarza VARCHAR(100) NOT NULL
)

CREATE TABLE zad2a.pacjenci (
	IDPacjenta INT PRIMARY KEY,
	NazwaPacjenta VARCHAR(100) NOT NULL
)

CREATE TABLE zad2a.zabiegi (
	IDZabiegu INT PRIMARY KEY,
	NazwaZabiegu VARCHAR(100) NOT NULL
)

CREATE TABLE zad2a.wizyty (
	DataGodzinaWizyty VARCHAR(200) PRIMARY KEY,
    IDPracownika INT NOT NULL,
    IDPacjenta INT NOT NULL,
	IDZabiegu INT NOT NULL,
    FOREIGN KEY (IDPracownika) REFERENCES zad2a.pracownicy(IDPracownika),
    FOREIGN KEY (IDZabiegu) REFERENCES zad2a.zabiegi(IDZabiegu),
    FOREIGN KEY (IDPacjenta) REFERENCES zad2a.pacjenci(IDPacjenta)
)

--------------------------

CREATE SCHEMA zad2b

CREATE TABLE zad2b.dostawca1 (
	Dostawca1 VARCHAR(100) PRIMARY KEY,
	AdresDostawcy1 VARCHAR(200) NOT NULL
)

CREATE TABLE zad2b.dostawca2 (
	Dostawca2 VARCHAR(100) PRIMARY KEY,
	AdresDostawcy2 VARCHAR(200) NOT NULL
)

CREATE TABLE zad2b.produkty (
	NazwaProduktu VARCHAR(100) PRIMARY KEY,
	Dostawca1 VARCHAR(100),
	Dostawca2 VARCHAR(100),
	Cena DOUBLE PRECISION NOT NULL,
	FOREIGN KEY (Dostawca1) REFERENCES zad2b.dostawca1(Dostawca1),
	FOREIGN KEY (Dostawca2) REFERENCES zad2b.dostawca2(Dostawca2)
)