DROP DATABASE IF EXISTS  newschema;
CREATE DATABASE  newschema;
USE newschema;

CREATE TABLE adress (
    name varchar(25) NOT NULL,
    city_name varchar(25) NOT NULL,
    CONSTRAINT adress_pk PRIMARY KEY (name) 
);

-- Table: card_bonus
CREATE TABLE card_bonus (
    id int NOT NULL AUTO_INCREMENT,
    amount_to_be_added int NOT NULL,
    CONSTRAINT card_bonus_pk PRIMARY KEY (id)
);

-- Table: card_has_bonus
CREATE TABLE card_has_bonus (
    discount_card_id int NOT NULL,
    card_bonus_id int NOT NULL,
    CONSTRAINT card_has_bonus_pk PRIMARY KEY (discount_card_id,card_bonus_id)
);

-- Table: city
CREATE TABLE city (
    name varchar(25) NOT NULL,
    region_name varchar(25) NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (name)
);

-- Table: client
CREATE TABLE client (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(25) NOT NULL,
    surname varchar(25) NOT NULL,
    birth_date date NULL,
    gender varchar(7) NULL,
    discount_card_id int NULL,
    phone_number varchar(12) NOT NULL,
    CONSTRAINT client_pk PRIMARY KEY (id)
);
CREATE TABLE company (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(25) NOT NULL,
    CONSTRAINT company_pk PRIMARY KEY (id)
);
-- Table: client_parking_ticket
CREATE TABLE client_parking_ticket (
    client_id int NOT NULL,
    parking_ticket_id int NOT NULL,
    CONSTRAINT client_parking_ticket_pk PRIMARY KEY (parking_ticket_id,client_id)
);

-- Table: company


-- Table: company_client
CREATE TABLE company_client (
    is_client bool NOT NULL,
    client_id int NOT NULL,
    company_id int NOT NULL,
    CONSTRAINT company_client_pk PRIMARY KEY (client_id)
);

-- Table: country
CREATE TABLE country (
    name varchar(25) NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (name)
);

-- Table: discount_card
CREATE TABLE discount_card (
    id int NOT NULL AUTO_INCREMENT,
    credits int NOT NULL,
    reserved_place bool NOT NULL,
    company_id int NOT NULL,
    CONSTRAINT discount_card_pk PRIMARY KEY (id)
);

-- Table: empty_places
CREATE TABLE empty_places (
    quantity int NOT NULL,
    parking_id int NOT NULL,
    parking_place_id int NULL,
    enterprise_quantity int NULL,
    UNIQUE INDEX empty_places_ak_1 (enterprise_quantity),
    CONSTRAINT empty_places_pk PRIMARY KEY (parking_id)
);

-- Table: enterprise
CREATE TABLE enterprise (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(40) NOT NULL,
    city_name varchar(25) NOT NULL,
    CONSTRAINT enterprise_pk PRIMARY KEY (id)
);

-- Table: enterprise_company
CREATE TABLE enterprise_company (
    company_id int NOT NULL,
    enterprise_id int NOT NULL,
    is_client bool NOT NULL,
    CONSTRAINT enterprise_company_pk PRIMARY KEY (company_id,enterprise_id)
);

-- Table: enterprise_quantity
CREATE TABLE enterprise_quantity (
    enterprise_id int NOT NULL,
    parking_place_id int NOT NULL,
    CONSTRAINT enterprise_quantity_pk PRIMARY KEY (enterprise_id,parking_place_id)
);

-- Table: parking
CREATE TABLE parking (
    id int NOT NULL AUTO_INCREMENT,
    adress_name varchar(25) NOT NULL,
    company_id int NOT NULL,
    price_per_hour int NOT NULL,
    place_quantity int NOT NULL,
    CONSTRAINT parking_pk PRIMARY KEY (id)
);

-- Table: parking_place
CREATE TABLE parking_place (
    id int NOT NULL AUTO_INCREMENT,
    entry_time timestamp NULL,
    exit_time timestamp NULL,
    car_number varchar(10) NULL,
    client_id int NULL,
    is_reserved bool NOT NULL,
    is_empty bool NOT NULL,
    CONSTRAINT parking_place_pk PRIMARY KEY (id)
);

-- Table: parking_ticket
CREATE TABLE parking_ticket (
    id int NOT NULL AUTO_INCREMENT,
    parking_place_id int NULL,
    CONSTRAINT parking_ticket_pk PRIMARY KEY (id)
);

-- Table: region
CREATE TABLE region (
    name varchar(25) NOT NULL,
    country_name varchar(25) NOT NULL,
    CONSTRAINT region_pk PRIMARY KEY (name)
);

-- foreign keys
-- Reference: Table_13_card_bonus (table: card_has_bonus)
ALTER TABLE card_has_bonus ADD CONSTRAINT Table_13_card_bonus FOREIGN KEY Table_13_card_bonus (card_bonus_id)
    REFERENCES card_bonus (id);

-- Reference: Table_13_discount_card (table: card_has_bonus)
ALTER TABLE card_has_bonus ADD CONSTRAINT Table_13_discount_card FOREIGN KEY Table_13_discount_card (discount_card_id)
    REFERENCES discount_card (id);

-- Reference: Table_23_client (table: client_parking_ticket)
ALTER TABLE client_parking_ticket ADD CONSTRAINT Table_23_client FOREIGN KEY Table_23_client (client_id)
    REFERENCES client (id);

-- Reference: Table_8_city (table: adress)
ALTER TABLE adress ADD CONSTRAINT Table_8_city FOREIGN KEY Table_8_city (city_name)
    REFERENCES city (name);

-- Reference: city_region (table: city)
ALTER TABLE city ADD CONSTRAINT city_region FOREIGN KEY city_region (region_name)
    REFERENCES region (name);

-- Reference: client_discount_card (table: client)
ALTER TABLE client ADD CONSTRAINT client_discount_card FOREIGN KEY client_discount_card (discount_card_id)
    REFERENCES discount_card (id);

-- Reference: client_parking_ticket (table: client_parking_ticket)
ALTER TABLE client_parking_ticket ADD CONSTRAINT client_parking_ticket FOREIGN KEY client_parking_ticket (parking_ticket_id)
    REFERENCES parking_ticket (id);

-- Reference: company_client_client (table: company_client)
ALTER TABLE company_client ADD CONSTRAINT company_client_client FOREIGN KEY company_client_client (client_id)
    REFERENCES client (id);

-- Reference: company_client_company (table: company_client)
ALTER TABLE company_client ADD CONSTRAINT company_client_company FOREIGN KEY company_client_company (company_id)
    REFERENCES company (id);

-- Reference: discount_card_company (table: discount_card)
ALTER TABLE discount_card ADD CONSTRAINT discount_card_company FOREIGN KEY discount_card_company (company_id)
    REFERENCES company (id);і

-- Reference: empty_places_parking (table: empty_places)
ALTER TABLE empty_places ADD CONSTRAINT empty_places_parking FOREIGN KEY empty_places_parking (parking_id)
    REFERENCES parking (id);

-- Reference: empty_places_parking_place (table: empty_places)
ALTER TABLE empty_places ADD CONSTRAINT empty_places_parking_place FOREIGN KEY empty_places_parking_place (parking_place_id)
    REFERENCES parking_place (id);

-- Reference: enterprise_city (table: enterprise)
ALTER TABLE enterprise ADD CONSTRAINT enterprise_city FOREIGN KEY enterprise_city (city_name)
    REFERENCES city (name);

-- Reference: enterprise_company_company (table: enterprise_company)
ALTER TABLE enterprise_company ADD CONSTRAINT enterprise_company_company FOREIGN KEY enterprise_company_company (company_id)
    REFERENCES company (id);

-- Reference: enterprise_company_enterprise (table: enterprise_company)
ALTER TABLE enterprise_company ADD CONSTRAINT enterprise_company_enterprise FOREIGN KEY enterprise_company_enterprise (enterprise_id)
    REFERENCES enterprise (id);

-- Reference: enterprise_quantity_enterprise (table: enterprise_quantity)
ALTER TABLE enterprise_quantity ADD CONSTRAINT enterprise_quantity_enterprise FOREIGN KEY enterprise_quantity_enterprise (enterprise_id)
    REFERENCES enterprise (id);

-- Reference: parking_adress (table: parking)
ALTER TABLE parking ADD CONSTRAINT parking_adress FOREIGN KEY parking_adress (adress_name)
    REFERENCES adress (name);

-- Reference: parking_company (table: parking)
ALTER TABLE parking ADD CONSTRAINT parking_company FOREIGN KEY parking_company (company_id)
    REFERENCES company (id);

-- Reference: parking_place_client (table: parking_place)
ALTER TABLE parking_place ADD CONSTRAINT parking_place_client FOREIGN KEY parking_place_client (client_id)
    REFERENCES client (id);

-- Reference: parking_ticket_parking_place (table: parking_ticket)
ALTER TABLE parking_ticket ADD CONSTRAINT parking_ticket_parking_place FOREIGN KEY parking_ticket_parking_place (parking_place_id)
    REFERENCES parking_place (id);

-- Reference: region_country (table: region)
ALTER TABLE region ADD CONSTRAINT region_country FOREIGN KEY region_country (country_name)
    REFERENCES country (name);


INSERT INTO `newschema`.`country` (`name`) VALUES ('Ukraine');

INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Lviv District', 'Ukraine');
INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Odessa District', 'Ukraine');
INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Kharkiv District', 'Ukraine');
INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Volyun District', 'Ukraine');
INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Zakarpatya District', 'Ukraine');
INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Ternopil District', 'Ukraine');
INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Kyiv District', 'Ukraine');
INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Chernivtsi District', 'Ukraine');
INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Dnipropetrovsk District', 'Ukraine');
INSERT INTO `newschema`.`region` (`name`, `country_name`) VALUES ('Luhansk District', 'Ukraine');

INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Lviv', 'Lviv District');
INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Kyiv', 'Kyiv District');
INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Lutsk', 'Volyun District');
INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Dnipro', 'Dnipropetrovsk District');
INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Kaniv', 'Chernivtsi District');
INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Ternopil', 'Ternopil District');
INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Odessa', 'Odessa District');
INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Kharkiv', 'Kharkiv District');
INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Uman', 'Chernivtsi District');
INSERT INTO `newschema`.`city` (`name`, `region_name`) VALUES ('Uzhgorod', 'Zakarpatya District');

INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Shevchnka 35', 'Lviv');
INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Banderu 24', 'Kyiv');
INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Doroshenka 22', 'Kharkiv');
INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Stusa 13', 'Odessa');
INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Chornovola 17', 'Dnipro');
INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Ukrainku 12', 'Ternopil');
INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Sheptytskogo 36', 'Lutsk');
INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Lvivska 5', 'Uzhgorod');
INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Virmenska 9', 'Uman');
INSERT INTO `newschema`.`adress` (`name`, `city_name`) VALUES ('Heroiv Krut 14', 'Kaniv');

INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('1', 'company_1');
INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('2', 'company_2');
INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('3', 'company_3');
INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('4', 'company_4');
INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('5', 'company_5');
INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('6', 'company_6');
INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('7', 'company_7');
INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('8', 'company_8');
INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('9', 'company_9');
INSERT INTO `newschema`.`company` (`id`, `name`) VALUES ('10', 'company_10');

INSERT INTO `newschema`.`discount_card` (`id`, `credits`, `reserved_place`, `company_id`) VALUES ('1', '111', '1', '1');
INSERT INTO `newschema`.`discount_card` (`id`, `credits`, `reserved_place`, `company_id`) VALUES ('2', '200', '0', '2');
INSERT INTO `newschema`.`discount_card` (`id`, `credits`, `reserved_place`, `company_id`) VALUES ('3', '297', '0', '3');
INSERT INTO `newschema`.`discount_card` (`id`, `credits`, `reserved_place`, `company_id`) VALUES ('4', '394', '0', '4');
INSERT INTO `newschema`.`discount_card` (`id`, `credits`, `reserved_place`, `company_id`) VALUES ('5', '311', '1', '5');

INSERT INTO `newschema`.`card_bonus` (`id`, `amount_to_be_added`) VALUES ('1', '150');
INSERT INTO `newschema`.`card_bonus` (`id`, `amount_to_be_added`) VALUES ('2', '300');
INSERT INTO `newschema`.`card_bonus` (`id`, `amount_to_be_added`) VALUES ('3', '225');
INSERT INTO `newschema`.`card_bonus` (`id`, `amount_to_be_added`) VALUES ('4', '500');
INSERT INTO `newschema`.`card_bonus` (`id`, `amount_to_be_added`) VALUES ('5', '450');


INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('1', 'Marko', 'Danylo', '08.05.2004', 'Male', '1', '0674547556');
INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('2', 'Yulia', 'Haleiko', '10.04.2004', 'Female', '2', '0632645977');
INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('3', 'Iruna', 'Klius', '05.05.2004', 'Female', '3', '0933532556');
INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('4', 'Yura', 'Andrus', '16.08.2004', 'Male', '4', '0631415677');
INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('5', 'Vlad', 'Boiko', '16.01.2004', 'Male', '5', '0682053200');
INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('6', 'Ivan', 'Zaliznyak', '25.11.2004', 'Male', '1', '0735429611');
INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('7', 'Anastasia', 'Vasilitsia', '17.03.2004', 'Female', '2', '0674151102');
INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('8', 'Marta', 'Oliferchuk', '28.04.2004', 'Female', '3', '0636531124');
INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('9', 'Olya', 'Pascal', '12.02.2004', 'Female', '4', '0679631248');
INSERT INTO `newschema`.`client` (`id`, `name`, `surname`, `birth_date`, `gender`, `discount_card_id`, `phone_number`) VALUES ('10', 'Oleg', 'Yatskiv', '29.02.2004', 'Male', '5', '0633102456');

INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('Meta', 'Lviv');
INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('Google', 'Kyiv');
INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('MangaLib', 'Lutsk');
INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('Utati', 'Kharkiv');
INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('RamenMo', 'Lviv');
INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('Teams', 'Uzhgorod');
INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('Zoom', 'Uman');
INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('Microsoft', 'Kaniv');
INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('Apple', 'Lviv');
INSERT INTO `newschema`.`enterprise` (`name`, `city_name`) VALUES ('Youtube', 'Dnipro');

INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('1', '1', '0');
INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('4', '3', '1');
INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('3', '4', '0');
INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('2', '5', '1');
INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('5', '7', '1');
INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('6', '8', '0');
INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('8', '9', '1');
INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('7', '10', '0');
INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('10', '6', '1');
INSERT INTO `newschema`.`enterprise_company` (`company_id`, `enterprise_id`, `is_client`) VALUES ('9', '2', '0');


INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('1', '1', '10');
INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('0', '2', '9');
INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('1', '3', '8');
INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('0', '4', '7');
INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('1', '5', '6');
INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('0', '6', '5');
INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('1', '7', '4');
INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('0', '8', '3');
INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('1', '9', '2');
INSERT INTO `newschema`.`company_client` (`is_client`, `client_id`, `company_id`) VALUES ('0', '10', '1');

INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Chornovola 17', '1', '15', '115');
INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Doroshenka 22', '2', '33', '100');
INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Banderu 24', '3', '30', '90');
INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Shevchnka 35', '4', '27', '84');
INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Heroiv Krut 14', '5', '26', '75');
INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Stusa 13', '6', '31', '95');
INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Ukrainku 12', '7', '24', '100');
INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Lvivska 5', '8', '18', '79');
INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Virmenska 9', '9', '17', '92');
INSERT INTO `newschema`.`parking` (`adress_name`, `company_id`, `price_per_hour`, `place_quantity`) VALUES ('Sheptytskogo 36', '10', '22', '110');


INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:14:07', '2022-10-26 04:14:07', 'BC 0339 AC', '1', '0', '0');
INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:14:30', '2022-10-26 04:14:30', 'BC 1664 MA', '2', '0', '0');
INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:14:45', '2022-10-26 04:14:45', 'BC 0320 KI', '3', '0', '0');
INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:15:07', '2022-10-26 04:15:07', 'AA 7777 TI', '4', '0', '0');
INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:16:07', '2022-10-26 04:16:07', 'BA 1204 NN', '5', '0', '0');
INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:25:07', '2022-10-26 04:25:07', 'BC 7534 RA', '6', '0', '0');
INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:35:07', '2022-10-26 04:35:07', 'BO 6137 HA', '7', '0', '0');
INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:45:07', '2022-10-26 04:45:07', 'BO 9432 OJ', '8', '0', '1');
INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:46:07', '2022-10-26 04:46:07', 'AA 1652 MF', '9', '0', '1');
INSERT INTO `newschema`.`parking_place` (`entry_time`, `exit_time`, `car_number`, `client_id`, `is_reserved`, `is_empty`) VALUES ('2022-10-26 03:54:07', '2022-10-26 04:54:07', 'BC 1710 VZ', '10', '0', '1');

INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('1');
INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('2');
INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('3');
INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('4');
INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('5');
INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('6');
INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('7');
INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('8');
INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('9');
INSERT INTO `newschema`.`parking_ticket` (`parking_place_id`) VALUES ('10');

INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('1', '5');
INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('2', '3');
INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('3', '2');
INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('4', '8');
INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('5', '9');
INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('6', '7');
INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('7', '6');
INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('8', '10');
INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('9', '1');
INSERT INTO `newschema`.`enterprise_quantity` (`enterprise_id`, `parking_place_id`) VALUES ('10', '4');


INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('1', '4');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('2', '6');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('3', '9');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('4', '7');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('5', '2');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('6', '1');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('7', '10');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('8', '3');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('9', '5');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('10', '8');

INSERT INTO `newschema`.`card_has_bonus` (`discount_card_id`, `card_bonus_id`) VALUES ('1', '2');
INSERT INTO `newschema`.`card_has_bonus` (`discount_card_id`, `card_bonus_id`) VALUES ('1', '3');
INSERT INTO `newschema`.`card_has_bonus` (`discount_card_id`, `card_bonus_id`) VALUES ('2', '4');
INSERT INTO `newschema`.`card_has_bonus` (`discount_card_id`, `card_bonus_id`) VALUES ('3', '5');
INSERT INTO `newschema`.`card_has_bonus` (`discount_card_id`, `card_bonus_id`) VALUES ('4', '1');

INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('1', '3');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('2', '8');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('3', '4');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('4', '1');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('5', '9');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('6', '7');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('7', '2');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('8', '5');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('9', '10');
INSERT INTO `newschema`.`client_parking_ticket` (`client_id`, `parking_ticket_id`) VALUES ('10', '6');

INSERT INTO `newschema`.`empty_places` (`quantity`, `parking_id`, `parking_place_id`, `enterprise_quantity`) VALUES ('8', '1', '4', '8');


