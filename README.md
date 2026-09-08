
🚌 Bus Trips Reservation System

A database design and implementation project for managing bus trip reservations — covering conceptual design (ERD), logical design (relational schema), SQL implementation, and a working data-entry application built with Oracle Forms Builder.

Team ID: 44 TA: Alshaymaa Abdelaty

📌 Project Overview

This system models a real-world bus trip reservation service where passengers book seats on trips, drivers are assigned to vehicles, and tickets are issued and tracked for payment status. The project was developed in four stages: conceptual modeling, logical schema design, SQL implementation, and a front-end data-entry application.

🧩 1. Entity-Relationship Diagram (ERD)

The ERD models the core entities and their relationships:

Person (superclass) — SSN (key), Name, Phone_No (multivalued), Birth_Date (composite: Year/Month/Day), Gender, and a derived attribute Age.
Driver and Passenger — both inherit from Person (disjoint specialization).
Driver adds: Salary, License_No.
Passenger adds: Payment_Method.
Vehicle — ID (key), Model, Bus_Capacity.
Trip — ID (key), Starting_Loc, End_Loc, Date (composite), Passengers_No, Is_Paid.
Ticket — ID (key), Price, Seat_No, Reservation_Date (composite).

Relationships & Cardinalities:

Relationship	Cardinality	Description
Drive	1 Driver : 1 Vehicle	Each driver drives one vehicle at a time
Travel	1 Vehicle : N Passengers	A vehicle transports many passengers
Purchase	1 Passenger : 1 Ticket	Each ticket is bought by exactly one passenger
For	1 Trip : N Tickets	A trip can have many tickets issued for it

📄 See Bus_Trips_ERD_and_Schema.pdf for the full diagram.

🗂️ 2. Logical (Relational) Schema

The ERD was mapped into the following relational tables:

Vehicle(ID, Bus_Capacity, Model)
Person(SSN, Name, Year, Month, Day, Gender)
Phone_No(Person_ID, Phone_No) — separate table for the multivalued phone attribute
Passenger(Person_ID, Payment_Method, Vehicle_ID, Ticket_ID)
Driver(Person_ID, Salary, License_No, Vehicle_ID)
Ticket(ID, Price, Seat_No, Year, Month, Day, Trip_ID)
Trip(ID, Passengers_No, Starting_Loc, End_Loc, Year, Month, Day, Is_Paid)

Foreign keys tie Passenger/Driver back to Person (inheritance), Ticket to Trip, and Passenger/Driver to Vehicle.

📄 See Bus_Trips_ERD_and_Schema.pdf for the full schema diagram.

💾 3. SQL Implementation

The schema was implemented in Oracle SQL, including:

DDL — CREATE TABLE statements with primary keys, foreign keys, NOT NULL, UNIQUE, and CHECK constraints (e.g. driver salary must be greater than 5000).
DML — sample data inserted for buses, persons, phone numbers, trips, tickets, passengers, and drivers.
Schema evolution — ALTER TABLE statements adding gender to Person and ispayed to Ticket after initial creation, followed by UPDATE statements populating those columns.

📄 Full script: Bus_Trips_Reservation_System.sql

🖥️ 4. Oracle Forms Application

A data-entry front end was built in Oracle Forms Builder on top of the schema, demonstrating:

Data Blocks created via the Data Block Wizard for PERSON, TRIP, TICKET, PASSENGER, and DRIVER tables.
Layout design using the Layout Wizard (form-style and tabular-style layouts).
Master-Detail relationships — e.g. Trip (master) → Ticket (detail).
Radio Groups for Gender selection (Male/Female).
List Items for Payment_Method (Cash / Credit Card / Mobile Wallet).
List of Values (LOV) — a searchable popup letting a Driver select their assigned Bus by ID, Model, or Capacity.
PL/SQL Triggers & Alerts — data validation logic (e.g. rejecting an invalid birth year) that raises a custom Alert dialog with "invalid data".
Calculated (derived) items — Age computed automatically from the entered Birth Year using a formula item.

📄 All step-by-step screenshots are combined in Bus_Trips_Forms_Steps.pdf.


🛠️ Tools & Technologies
Database: Oracle Database / Oracle SQL
Front-end: Oracle Forms Builder (PL/SQL, Data Blocks, LOVs, Triggers, Alerts)
Modeling: Entity-Relationship Diagram (ERD), Relational Schema Design
