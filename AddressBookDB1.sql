--UC1:- Ability to create a Address Book Service DB.
--Use SQL Client to create DB and DB Records.
CREATE DATABASE AddressBookDB1;
USE AddressBookDB1;

--UC2:- Ability to create a Address Book Table with first and last names, 
--address, city, state, zip, phone number and email as its attributes.
CREATE TABLE AddressBook
(
firstName varchar(20) not null,
lastName varChar(20) not null,
address varchar(100) not null,
city varchar(20) not null,
state varchar(20) not null,
zip int not null,
phoneNumber varchar(12),
email varchar(20) not null
);
select * from AddressBook;

-- UC3:- Ability to insert new Contacts to Address Book.
insert into AddressBook (firstName,lastName,address,city,state,zip,phoneNumber,email) 
values('Omprakash','Khawshi','Alandi','Pune','Maharashtra','412105','8788616249','omkhawshi@gmail.com');
select * from AddressBook;

insert into AddressBook values('Ankit','Mankar','Patrahi Nagpur','Nagpur','Maharashtra','440023','8188888898','ankit@gmail.com');

insert into AddressBook values('Rahul','Nayr','Nagpur','Nagpur','Maharashtra','442203','12345678910','opre@gmail.com');

--UC4:- Ability to edit existing contact person using their name.
update AddressBook set zip=444444 where firstName='Ankit';
select * from AddressBook;

update AddressBook set email='ankitmankar@gmail.com' where firstName='Ankit';

update AddressBook set lastName='Singh' where firstName='Rahul';
select * from AddressBook;

--UC5:- Ability to delete a person using person's name.
Delete AddressBook where firstName='Rahul';
select * from AddressBook;