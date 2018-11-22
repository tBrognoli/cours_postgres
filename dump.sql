CREATE TABLE Theme(
   id_theme INT PRIMARY KEY,
   room VARCHAR(25),
   name_theme VARCHAR(50),
   code_theme VARCHAR(2)
);

CREATE TABLE Auteur(
   id_author INT PRIMARY KEY,
   name_author VARCHAR(50),
   code_author VARCHAR(2)
);

CREATE TABLE Subscriber(
   id_subscriber INT PRIMARY KEY,
   card_number INT,
   last_name VARCHAR(50),
   email VARCHAR(50),
   first_name VARCHAR(50),
   delay LOGICAL,
   date_start DATE,
   date_end DATE
);

CREATE TABLE Reservation(
   id_reservation INT PRIMARY KEY,
   date_reservation DATE,
   id_subscriber INT REFERENCES Subscriber(id_subscriber) NOT NULL
);

CREATE TABLE Command(
   id_command VARCHAR(50) PRIMARY KEY,
   number_copies INT,
   date_arrive DATE,
   date_command DATE
);

CREATE TABLE Vendeur(
   id_vendeur INT PRIMARY KEY,
   type_vendeur VARCHAR(50),
   nom VARCHAR(50),
   id_command VARCHAR(50) REFERENCES Command(id_command) NOT NULL
);

CREATE TABLE Ouvrage(
   id_book INT PRIMARY KEY,
   ISBN VARCHAR(16),
   edition VARCHAR(50),
   code_title VARCHAR(2),
   id_theme INT,
   id_authtor INT NOT NULL,
   title VARCHAR(50),
   number_example INT,
   id_command VARCHAR(50) REFERENCES Command(id_command) NOT NULL,
   id_author INT REFERENCES Auteur(id_author) NOT NULL,
   id_theme_1 INT REFERENCES Theme(id_theme) NOT NULL
);

CREATE TABLE Pret(
   id_pret INT PRIMARY KEY,
   date_start DATE,
   date_end DATE,
   is_delay LOGICAL,
   id_subscriber INT REFERENCES Subscriber(id_subscriber) NOT NULL,
   id_book INT REFERENCES Ouvrage(id_book) NOT NULL
);
