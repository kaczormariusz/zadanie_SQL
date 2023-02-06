CREATE DATABASE zadanie_sql CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;

USE zadanie_sql;

CREATE TABLE pracownik(
	id INT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(30),
    nazwisko VARCHAR(30),
    wyplata INT,
    data_urodzenia DATE,
    stanowisko VARCHAR(30)
);

INSERT INTO pracownik
	(imie, nazwisko, wyplata, data_urodzenia, stanowisko)
VALUES
	('Tomasz', 'Borowiak', 7000, '1980-09-01', 'Księgowy'),
	('Grażyna', 'Nowak', 15000, '1983-12-13', 'Dyrektor'),
    ('Marzanna', 'Kwiecień',  12000, '1990-06-16', 'Kierownik HR'),
    ('Witold', 'Masło', 5500, '1997-11-02', 'Magazynier'),
    ('Bożena', 'Kiełbasa', 7500, '1994-04-02', 'Inspektor BHP i ppoż'),
    ('Grzegorz', 'Winnicki', 6500, '1989-01-31', 'Lider');

SELECT * FROM
	pracownik
WHERE
	stanowisko = 'Magazynier';


SELECT * FROM
	pracownik
WHERE
	data_urodzenia >= CURRENT_DATE()-INTERVAL 30 YEAR;

UPDATE
	pracownik
SET
	wyplata = wyplata + (wyplata * 10/100)
where
	stanowisko = 'Magazynier';


SELECT * FROM
	pracownik
WHERE
	data_urodzenia = (select max(data_urodzenia) from pracownik);

DROP TABLE if exists pracownik;


**********************************************************************************************


CREATE DATABASE firma CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;
USE firma;
CREATE TABLE stanowisko(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nazwa_stanowiska VARCHAR(30),
    opis VARCHAR(200),
    zarobki INT
);

CREATE TABLE pracownik(
	id INT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(20),
    nazwisko varchar(20),
    stanowisko_id INT,
    FOREIGN KEY (stanowisko_id) REFERENCES stanowisko(id)
);

CREATE TABLE adres(
    id INT PRIMARY KEY AUTO_INCREMENT,
    ulica_numer VARCHAR(40),
    kod_pocztowy VARCHAR(6),
    miejscowosc VARCHAR(25),
    pracownik_id INT UNIQUE NOT NULL,
    FOREIGN KEY (pracownik_id) REFERENCES pracownik(id)
);

INSERT INTO stanowisko
	(nazwa_stanowiska, opis, zarobki)
VALUES
	('Dyrektor', 'Pracownik zarządzający zakładem pracy', 15000),
    ('Kierownik HR', 'Pracownik nadzorujący pracę działu HR', 10000),
    ('Księgowy', 'Pracownik działu księgowość', 7000),
    ('Magazynier', 'Pracownik magazynu', 5500),
    ('Inspektor BHP i ppoż', 'Pracownik działu BHP', 7500);

INSERT INTO pracownik
	(imie, nazwisko, stanowisko_id)
VALUES
	('Tomasz', 'Borowiak', 1),
	('Grażyna', 'Nowak', 2),
    ('Marzanna', 'Kwiecień',  3),
    ('Witold', 'Masło', 4),
    ('Bożena', 'Kiełbasa', 5),
    ('Grzegorz', 'Winnicki', 5),
    ('Daniel', 'Zabłocki', 4);

INSERT INTO adres
	(ulica_numer, kod_pocztowy, miejscowosc, pracownik_id)
VALUES
    ('Słomiana 39', '77-300', 'Warszawa', 1),
    ('Motoryzacyjna 6/2', '66-300', 'Poznań', 4),
    ('Bażantowa 15', '99-100', 'Gdańsk', 2),
    ('Morelowa 2a/3', '54-123', 'Świnoujście', 3),
    ('Zagadkowa 88', '33-015', 'Lidzbark', 5),
    ('Potasowa 56/4','10-321', 'Olsztyn',7),
    ('Mrówkowa 34','99-100', 'Gdańsk', 6);

SELECT
	pracownik.imie, pracownik.nazwisko, stanowisko.nazwa_stanowiska
FROM
	pracownik, stanowisko, adres
WHERE
    pracownik.stanowisko_id = stanowisko.id;

SELECT
	pracownik.imie, pracownik.nazwisko, stanowisko.nazwa_stanowiska, concat( adres.ulica_numer, ' ' , adres.kod_pocztowy ,' ' , adres.miejscowosc) as adres_zamieszkania
FROM
	pracownik, stanowisko, adres
WHERE
    pracownik.stanowisko_id = stanowisko.id
AND
    pracownik.id = adres.pracownik_id;

SELECT SUM(zarobki) as suma_zarobkow
FROM
	pracownik, stanowisko
WHERE
	pracownik.stanowisko_id = stanowisko.id;

SELECT
	pracownik.imie, pracownik.nazwisko, adres.kod_pocztowy
FROM
	pracownik, adres
where adres.kod_pocztowy = '99-100'
and pracownik.id = adres.pracownik_id;