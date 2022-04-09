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

--UC6:- Ability to Retrieve Person belonging to a City or State from the Address Book.
select city,state from AddressBook;
select * from AddressBook where state='Uttar Pradesh' 
select * from AddressBook where city='Pune' or state='Uttar Pradesh';

--UC7:- Ability to understand the size of address book by City and State.
-- Here size indicates the count.
select COUNT(city) from AddressBook;

select city, count(*) as AddressCount
from AddressBook group by (city);

select COUNT(state) from AddressBook;

select state, count(*) as AddressCount
from AddressBook group by (state);

--UC8:- Ability to retrieve entries sorted alphabetically by Person’s name for a given city.
select * from AddressBook order by city ASC;  --sorted by ASCII value of city

select * from AddressBook where city = 'Pune'
order by (firstName);

select * from AddressBook where city = 'Nagpur'
order by (firstName);

--UC9:- Ability to identify each Address Book with name and Type.
--UC9.1:- Alter Address Book to add name and type.
alter table AddressBook add Name varchar(255),Type varchar(255);
select * from AddressBook;

--UC9.2:- Here the type could Family, Friends, Profession, etc.
update AddressBook set Name='Aron';

update AddressBook set Type ='Friend' where firstName='Omprakash' or firstName='Prashant';
select * from AddressBook;

update AddressBook set Type ='Family' where firstName='Ankit' or firstName='EREN'; 
select * from AddressBook;

--UC10:- Ability to get number of contact persons i.e. count by type.
select count(type) from AddressBook;

select Type, count(*) as TypeCount 
from AddressBook group by Type;


--UC11:- Ability to add person to both Friend and Family.
insert into AddressBook(firstName,lastName,address,city,state,zip,phoneNumber,email,Name,Type) 
values('Shani','Seth','DLW','Banaras','Uttar Pradesh','126105','8762498989','shani@gmail.com','ShaniContact','Family');
 
insert into AddressBook values('Ravi','Verma','DLW','Banaras','Uttar Pradesh','226105','7862498989','ravi@gmail.com','RaviContact','Friend');
select * from AddressBook;

---UC12:- Draw the ER Diagram for Address Book Service DB. 
--        Identifies the Entities ? Entities can be Identified using Normalization Technique.
--        Check each attribute and see if they are Composite or Multi-Valued.

--Create table Addresses
Create table Addresses(Address_id int not null identity(1,1) primary key,City varchar(20) not null,
State varchar(20) not null,Zip varchar(6) not null default '412105');
select * from Addresses; --Display table
--drop table Addresses
--insert value  into Addresses table
insert into Addresses(City,State) values('Pune','Maharashtra');
insert into Addresses(City,State) values('Pune','Maharashtra');
insert into Addresses(City,State) values('Jaunpur','Uttar Pradesh');
select * from Addresses;

--Create table ContactDetails
create table ContactDetails(FirstName varchar(50) not null,LastName varchar(50) not null,Address varchar(50) not null, Contact_id int not null identity(1,1)
foreign key references Addresses(Address_id),PhoneNumber varchar(10) not null, Email varchar(50) not null,Primary key(FirstName,LastName));
select * from ContactDetails;
--drop table ContactDetails;
--insert value  ContactDetails table
insert into ContactDetails(Contact_id,FirstName,LastName,Address,PhoneNumber,Email)values
('1','Om','Khawshi','Sonpur','8788616249','omkha@gmail.com'),
('2','Ankit','Mankar','Nagpur','1234567891','ankit@gmail.com'),
('3','Shubham','Seth','Patrahi','1515161918','a@gmail.com');
select * from ContactDetails;


--Create Table AddressBookName
create table AddressBookName(Name_id int not null identity(1,1) primary key, AddressBookName varchar(50) not null unique,
ContactType varchar(50) not null unique);
select * from AddressBookName;

--insert value into AddressBookName table
insert into AddressBookName values('AddressBook1','Friends'),('AddressBook2','Parents'),('AddressBook3','Brothers');

--Create table ContactTypeMapping
create table ContactTypeMapping(FirstName varchar(50) not null,LastName varchar(50) not null,
Name_id int not null foreign key references AddressBookName(Name_id),
Foreign key(FirstName,LastName) references ContactDetails(FirstName,LastName), unique(FirstName,LastName,Name_id));
select * from ContactTypeMapping;

--insert value  ContactTypeMapping table
insert into ContactTypeMapping (FirstName,LastName,Name_id) values('Shubham','Seth','1');
insert into ContactTypeMapping (FirstName,LastName,Name_id) values('Rahul','Nayar','2');
select * from ContactTypeMapping;