--tworzenie tabel
CREATE TABLE IF NOT EXISTS rozliczenia.godziny
(
    id_godziny integer NOT NULL,
    data date NOT NULL,
    "liczba godzin" integer,
    id_pracownika integer NOT NULL,
    CONSTRAINT godziny_pkey PRIMARY KEY (id_godziny),
    CONSTRAINT fk_godziny_pracownicy FOREIGN KEY (id_pracownika)
        REFERENCES rozliczenia.pracownicy (id_pracownika) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS rozliczenia.godziny
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS rozliczenia.pensje
(
    id_pensji integer NOT NULL,
    stanowisko character varying COLLATE pg_catalog."default" NOT NULL,
    kwota_brutto double precision,
    id_premii integer NOT NULL,
    kwota_netto double precision,
    CONSTRAINT pensje_pkey PRIMARY KEY (id_pensji),
    CONSTRAINT fk_pensje_premie FOREIGN KEY (id_premii)
        REFERENCES rozliczenia.premie (id_premii) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS rozliczenia.pensje
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS rozliczenia.pracownicy
(
    id_pracownika integer NOT NULL,
    imie character varying COLLATE pg_catalog."default" NOT NULL,
    nazwisko character varying COLLATE pg_catalog."default" NOT NULL,
    adres character varying COLLATE pg_catalog."default" NOT NULL,
    telefon integer NOT NULL,
    CONSTRAINT "pracownicy _pkey" PRIMARY KEY (id_pracownika)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS rozliczenia.pracownicy
    OWNER to postgres;



CREATE TABLE IF NOT EXISTS rozliczenia.premie
(
    id_premii integer NOT NULL,
    rodzaj character varying COLLATE pg_catalog."default" NOT NULL,
    kwota double precision,
    CONSTRAINT premie_pkey PRIMARY KEY (id_premii)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS rozliczenia.premie
    OWNER to postgres;

--klucze obce
ALTER TABLE ksiegowosc.godziny
ADD CONSTRAINT fk_pracownik_w_godziny
FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy (id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk_pracownik_w_wynagrodzenie
FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie 
ADD CONSTRAINT fk_pensja_w_wynagrodzenia
FOREIGN KEY (id_pensji)
REFERENCES ksiegowosc.pensja (id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk_premia_w_wynagrodzenia
FOREIGN KEY (id_premii)
REFERENCES ksiegowosc.premia (id_premii);


--komentarze

COMMENT ON TABLE ksiegowosc.pracownicy IS 'Dane osobowe pracownika';
COMMENT ON TABLE ksiegowosc.godziny IS 'Godziny przepracowane danego dnia przez pracownika';
COMMENT ON TABLE ksiegowosc.pensja IS 'Wartosc pensji na danym stanowisku';
COMMENT ON TABLE ksiegowosc.premia IS 'Wartosci poszczegolnych rodzajow premii';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Wartosc wynagrodzenia pracownika - pensja i premia';


--wprowadzenie rekordów
INSERT INTO ksiegowosc.pracownicy VALUES ('1', 'Antoni', 'Kowal', 'ul. Słoneczna 45 Kraków', '647383759'),
('2', 'Zuzanna', 'Kwiatkowska', 'ul.Krakowska 366 Warszawa', '894794861'),
('3', 'Weronika', 'Wolek', 'ul. Widokowa 44 Poznań', '927737462'),
('4', 'Michał', 'Lubuski', 'ul. Szeroka 1 Łódź', '745283983'),
('5', 'Roman', 'Konik', 'ul. Polna 4a Krakow', '777333555'),
('6', 'Krzysztof', 'Dobrzyński', 'ul. Czarna 55 Jasło', '863524837' ),
('7', 'Tomasz', 'Fredro', 'ul. Warszawska 75 Kraków', '836777452'),
('8', 'Robert', 'Maklowicz', 'ul. Cicha 22 Bydgoszcz', '837295999'),
('9', 'Urszula', 'Jaśmin', 'ul. Młyńska 122 Lublin', '826363555'),
('10', 'Barbara', 'Górska', 'ul. Sienna 77 Kraków', '229047539');



INSERT INTO ksiegowosc.godziny VALUES 
('1', '25.03.2023', '8', '4'),
('2', '25.03.2023', '8', '8'),
('3', '25.03.2023', '6', '10'),
('4', '27.03.2023', '10', '10'),
('5', '27.03.2023', '7', '1'),
('6', '27.03.2023', '8', '3'),
('7', '27.03.2023', '7', '9'),
('8', '28.03.2023', '8', '2'),
('9', '28.03.2023', '9', '5'),
('10', '28.03.2023', '8', '7');

SELECT * FROM ksiegowosc.godziny;

INSERT INTO ksiegowosc.premia VALUES
('1', 'uznaniowa', '254.86'),
('2', 'frekwencyjna', '350'),
('3', 'regulaminowa', '700'),
('4', 'rocznicowa', '203.09'),
('5', 'motywacyjna', '884.09' ),
('6', 'zespołowa', '100'),
('7', 'indywidualna', '300'),
('8', 'zadaniowa', '200'),
('9', 'prowizyjna', '372.75'),
('10', 'jakościowa', '429.30');

SELECT * FROM ksiegowosc.premia;

INSERT INTO ksiegowosc.pensja VALUES
('1', 'kierownik', '2837.00'),
('2', 'asystent', '1526.33'),
('3', 'ksiegowy', '2736.63'),
( '4', 'kierownik', '1836.22' ),
('5', 'kierownik', '3928.24'),
('6', 'manager', '6183.28'),
('7', 'kierowca', '2469.24'),
('8', 'ksiegowy', '2948.88'),
('9', 'asystent', '2837.95'),
('10', 'asystent','2468.38');

INSERT INTO ksiegowosc.wynagrodzenie VALUES
('1', '1.04.2023', '1', '3', '2'),
('2', '1.04.2023', '6', '3', '10'),
('3', '1.04.2023', '8', '9', '9'),
('4', '1.04.2023', '9', '2', '1'),
('5', '1.04.2023', '10', '10', '9'),
('6', '2.04.2023', '2', '4', '5'),
('7', '2.04.2023', '3', '7', '3'),
('8', '2.04.2023', '4', '9', '2'),
('9', '2.04.2023', '5', '5', '7'),
('10', '2.04.2023', '7', '4', '1');

--5a
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--5b
SELECT ksiegowosc.wynagrodzenie.id_pracownika,ksiegowosc.pensja.kwota, ksiegowosc.premia.kwota
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premia.id_premii
WHERE (ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota) > 1000;

--5c
SELECT ksiegowosc.wynagrodzenie.id_pracownika,ksiegowosc.pensja.kwota, ksiegowosc.premia.kwota
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premia.id_premii
WHERE (ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota) > 2000 AND ksiegowosc.premia.kwota = 0;

--5d
SELECT * FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

--5e
SELECT * FROM ksiegowosc.pracownicy 
WHERE imie LIKE '%a' AND nazwisko LIKE '%n%';

--5f
SELECT ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, GREATEST(SUM(ksiegowosc.godziny.liczba_godzin)-160, 0) AS liczba_nadgodzin
FROM ksiegowosc.godziny
JOIN ksiegowosc.pracownicy ON ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika
GROUP BY ksiegowosc.pracownicy.id_pracownika;

--5g
SELECT ksiegowosc.pracownicy.imie,ksiegowosc.pracownicy.nazwisko
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
WHERE ksiegowosc.pensja.kwota>=1500 AND ksiegowosc.pensja.kwota<=3000;

--5h - nie wiem jak dolaczyc tabelę z premia
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko
FROM ksiegowosc.godziny
JOIN ksiegowosc.pracownicy ON ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika
WHERE SUM(ksiegowosc.godziny.liczba_godzin) > 160 AND 
GROUP BY ksiegowosc.pracownicy.id_pracownika;

--5i 
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.kwota
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
ORDER BY ksiegowosc.pensja.kwota  

--5j
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.kwota, ksiegowosc.premia.kwota
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premia.id_premii
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
ORDER BY ksiegowosc.pensja.kwota DESC, ksiegowosc.premia.kwota DESC

--5k ?????
--zlicza pracownikow
SELECT COUNT (1) AS liczba_pracownikow_na_stanowisku, ksiegowosc.pensja.stanowisko
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
GROUP BY ksiegowosc.pensja.stanowisko

--grupuje pracownikow
SELECT COUNT (1) AS liczba_pracownikow_na_stanowisku, ksiegowosc.pensja.stanowisko, ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
GROUP BY ksiegowosc.pensja.stanowisko, ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko

--5l
SELECT AVG(ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota) AS suma_wynagrodzen,
MAX(ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota) AS max_placa_kierownik,
MIN(ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota) AS min_placa_kierownik
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii= ksiegowosc.premia.id_premii
WHERE ksiegowosc.pensja.stanowisko = 'kierownik';

--5m
SELECT SUM(ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii= ksiegowosc.premia.id_premii;

--5n
SELECT ksiegowosc.pensja.stanowisko, SUM(ksiegowosc.pensja.kwota+ksiegowosc.premia.kwota) AS suma_wynagrodzen_na_stanowisku 
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii= ksiegowosc.premia.id_premii
GROUP BY ksiegowosc.pensja.stanowisko


--5o
SELECT ksiegowosc.pensja.stanowisko, COUNT(ksiegowosc.premia.id_premii) AS ilosc_przyznanych_premi_na_stanowisku
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii= ksiegowosc.premia.id_premii
GROUP BY ksiegowosc.pensja.stanowisko


--5p
