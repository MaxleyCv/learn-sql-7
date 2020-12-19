CREATE DATABASE IF NOT EXISTS University;
USE University;

DROP table if exists city; 
CREATE TABLE city (
  id int NOT NULL,
  name varchar(45) DEFAULT NULL,
  region_id int DEFAULT NULL,
  PRIMARY KEY (id)
) ;

DROP table if exists debts; 
CREATE TABLE debts (
  id int primary key auto_increment,
  subject varchar(45) DEFAULT NULL
);

DROP table if exists student_groups; 
CREATE TABLE student_groups (
  id int primary key auto_increment,
  name varchar(45) DEFAULT NULL,
  number varchar(45) DEFAULT NULL,
  join_year varchar(45) DEFAULT NULL
);


DROP table if exists regions; 
CREATE TABLE regions (
  id int primary key auto_increment,
  name varchar(45) DEFAULT NULL,
  zip_code varchar(45) DEFAULT NULL
);

DROP table if exists schools; 
CREATE TABLE schools (
   id int primary key auto_increment,
  name varchar(45) DEFAULT NULL,
  phone varchar(45) DEFAULT NULL,
  director_name varchar(45) DEFAULT NULL,
  director_surname varchar(45) DEFAULT NULL,
  director_patronim varchar(45) DEFAULT NULL,
  city_id int DEFAULT NULL
);

DROP table if exists student_has_debt; 
CREATE TABLE student_has_debt (
   id int primary key auto_increment,
  student_id varchar(45) DEFAULT NULL,
  debt_id varchar(45) DEFAULT NULL
);

DROP table if exists students; 
CREATE TABLE students (
  id int primary key auto_increment,
  name varchar(45) DEFAULT NULL,
  surname varchar(45) DEFAULT NULL,
  patronim varchar(45) DEFAULT NULL,
  birth_date date DEFAULT NULL,
  join_date date DEFAULT NULL,
  student_card_number varchar(45) DEFAULT NULL,
  email varchar(45) DEFAULT NULL,
  group_id int DEFAULT NULL,
  school_id int DEFAULT NULL,
  city_id varchar(45) DEFAULT NULL
);
