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


ALTER TABLE rozliczenia.godziny
ADD CONSTRAINT fk_godziny_pracownicy
FOREIGN KEY (id_pracownika)
REFERENCES rozliczenia.pracownicy (id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD CONSTRAINT fk_pensje_premie
FOREIGN KEY (id_premii)
REFERENCES rozliczenia.premie (id_premii);

INSERT INTO rozliczenia.pracownicy VALUES ('1', 'Antoni', 'Kowal', 'ul. Słoneczna 45 Kraków', '647383759'),
('2', 'Zuzanna', 'Kwiatkowska', 'ul.Krakowska 366 Warszawa', '894794861'),
('3', 'Weronika', 'Wolek', 'ul. Widokowa 44 Poznań', '927737462'),
('4', 'Michał', 'Lubuski', 'ul. Szeroka 1 Łódź', '745283983'),
('5', 'Roman', 'Konik', 'ul. Polna 4a Krakow', '777333555'),
('6', 'Krzysztof', 'Dobrzyński', 'ul. Czarna 55 Jasło', '863524837' ),
('7', 'Tomasz', 'Fredro', 'ul. Warszawska 75 Kraków', '836777452'),
('8', 'Robert', 'Maklowicz', 'ul. Cicha 22 Bydgoszcz', '837295999'),
('9', 'Urszula', 'Jaśmin', 'ul. Młyńska 122 Lublin', '826363555'),
('10', 'Barbara', 'Górska', 'ul. Sienna 77 Kraków', '229047539');

SELECT * FROM rozliczenia.pracownicy;

INSERT INTO rozliczenia.godziny VALUES 
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

SELECT * FROM rozliczenia.godziny

INSERT INTO rozliczenia.premie VALUES
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

SELECT * FROM rozliczenia.premie

INSERT INTO rozliczenia.pensje VALUES
('1', 'kierownik', '2837.00', '3' ),
('2', 'asystent', '1526.33', '2'),
('3', 'ksiegowy', '2736.63', '2'),
( '4', 'kierownik', '1836.22', '3' ),
('5', 'kierownik', '3928.24', '10'),
('6', 'manager', '6183.28', '6'),
('7', 'kierowca', '2469.24', '7'),
('8', 'ksiegowy', '2948.88', '10'),
('9', 'asystent', '2837.95', '6'),
('10', 'asystent','2468.38', '6');

SELECT * FROM rozliczenia.pensje

SELECT nazwisko, adres FROM rozliczenia.pracownicy

SELECT data, DATE_PART('dow', data) AS dzien_tyg, DATE_PART('MONTH', data) AS miesiac FROM rozliczenia.godziny

ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD COLUMN kwota_netto INTEGER;

ALTER TABLE rozliczenia.pensje 
ALTER COLUMN kwota_netto SET DATA TYPE double precision;

SELECT * FROM rozliczenia.pensje

UPDATE rozliczenia.pensje 
SET kwota_netto = kwota_brutto/1.23;

SELECT * FROM rozliczenia.pensje