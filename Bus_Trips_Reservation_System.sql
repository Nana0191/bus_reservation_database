--------------------------------------------------------------------
-- Bus Trips Reservation System
-- SQL Script: DDL (Table Creation) + DML (Sample Data) + Alterations
--------------------------------------------------------------------

--------------------------------------------------------------------
-- 1. TABLE CREATION (DDL)
--------------------------------------------------------------------

CREATE TABLE Bus (
    bus_id        NUMBER PRIMARY KEY,
    model_id      VARCHAR2(50) NOT NULL,
    bus_capacity  NUMBER NOT NULL
);

CREATE TABLE person (
    ssn        NUMBER PRIMARY KEY,
    full_name  VARCHAR2(100) NOT NULL,
    year       NUMBER NOT NULL,
    month      NUMBER NOT NULL,
    day        NUMBER NOT NULL
);

CREATE TABLE phonenumber (
    person_id     NUMBER REFERENCES PERSON (SSN),
    phone_number  VARCHAR2(20) NOT NULL,
    PRIMARY KEY (person_id, phone_number)
);

CREATE TABLE Trip (
    trip_id        NUMBER PRIMARY KEY,
    starting_loc   VARCHAR2(100) NOT NULL,
    end_loc        VARCHAR2(100) NOT NULL,
    passengers_no  NUMBER NOT NULL,
    trip_year      NUMBER,
    trip_month     NUMBER,
    trip_day       NUMBER
);

CREATE TABLE Ticket (
    ticket_id     NUMBER PRIMARY KEY,
    price         NUMBER NOT NULL,
    ticket_year   NUMBER,
    ticket_month  NUMBER,
    ticket_day    NUMBER,
    seat_number   NUMBER NOT NULL,
    trip_id       NUMBER REFERENCES TRIP (TRIP_ID)
);

CREATE TABLE passenger (
    ssn             NUMBER PRIMARY KEY REFERENCES PERSON (SSN),
    payment_method  VARCHAR2(50),
    bus_id          NUMBER REFERENCES BUS (bus_id),
    ticket_id       NUMBER REFERENCES TICKET (ticket_id)
);

CREATE TABLE driver (
    ssn              NUMBER PRIMARY KEY REFERENCES PERSON (SSN),
    salary           NUMBER CHECK (salary > 5000),
    license_number   VARCHAR2(20) UNIQUE,
    bus_id           NUMBER REFERENCES BUS (bus_id)
);


--------------------------------------------------------------------
-- 2. SAMPLE DATA (DML - INSERT STATEMENTS)
--------------------------------------------------------------------

-- Bus
INSERT INTO Bus (bus_id, model_id, bus_capacity) VALUES (101, 'MOD-A', 45);
INSERT INTO Bus (bus_id, model_id, bus_capacity) VALUES (102, 'MOD-B', 60);
INSERT INTO Bus (bus_id, model_id, bus_capacity) VALUES (103, 'MOD-C', 50);

-- Person
INSERT INTO person VALUES (2001, 'Ahmed Mohamed', 1999, 5, 12);
INSERT INTO person VALUES (2002, 'Sara Ali', 2000, 8, 22);
INSERT INTO person VALUES (2003, 'Omar Hassan', 1998, 11, 3);
INSERT INTO person VALUES (2004, 'Karim Adel', 1995, 6, 15);
INSERT INTO person VALUES (2005, 'Mona Tarek', 1993, 2, 7);
INSERT INTO person VALUES (2006, 'Mostafa Hussein', 1990, 9, 30);

-- Phone numbers (multivalued attribute -> separate table;
-- a person can have more than one phone number)
INSERT INTO phonenumber VALUES (2001, '01012345678');
INSERT INTO phonenumber VALUES (2001, '01287654321');
INSERT INTO phonenumber VALUES (2002, '01144556677');
INSERT INTO phonenumber VALUES (2003, '01599887766');
INSERT INTO phonenumber VALUES (2004, '01544556677');
INSERT INTO phonenumber VALUES (2005, '01022448899');
INSERT INTO phonenumber VALUES (2006, '01177889955');

-- Trip
INSERT INTO Trip VALUES (3001, 'Cairo', 'Alexandria', 45, 2024, 3, 10);
INSERT INTO Trip VALUES (3002, 'Giza', 'Hurghada', 50, 2024, 4, 5);
INSERT INTO Trip VALUES (3003, 'Cairo', 'Luxor', 60, 2024, 5, 20);

-- Ticket
INSERT INTO Ticket VALUES (5001, 150, 2024, 3, 10, 12, 3001);
INSERT INTO Ticket VALUES (5002, 220, 2024, 4, 5, 7, 3002);
INSERT INTO Ticket VALUES (5003, 300, 2024, 5, 20, 18, 3003);

-- Passenger
INSERT INTO passenger VALUES (2001, 'Cash', 101, 5001);
INSERT INTO passenger VALUES (2002, 'Credit Card', 102, 5002);
INSERT INTO passenger VALUES (2003, 'Mobile Wallet', 103, 5003);

-- Driver
INSERT INTO driver VALUES (2004, 7500, 'LIC-2001', 101);
INSERT INTO driver VALUES (2005, 8200, 'LIC-2002', 102);
INSERT INTO driver VALUES (2006, 9500, 'LIC-2003', 103);


--------------------------------------------------------------------
-- 3. SCHEMA ALTERATIONS
--------------------------------------------------------------------

-- Add Gender attribute to Person
ALTER TABLE Person
ADD gender VARCHAR2(2);

UPDATE Person SET gender = 'M' WHERE ssn = 2003;
UPDATE Person SET gender = 'M' WHERE ssn = 2001;
UPDATE Person SET gender = 'F' WHERE ssn = 2002;
UPDATE Person SET gender = 'M' WHERE ssn = 2006;
UPDATE Person SET gender = 'M' WHERE ssn = 2004;
UPDATE Person SET gender = 'F' WHERE ssn = 2005;

-- Add Is_Paid attribute to Ticket
ALTER TABLE ticket
ADD ispayed NUMBER(1);

UPDATE ticket SET ispayed = 1 WHERE ticket_id = 5001;
UPDATE ticket SET ispayed = 0 WHERE ticket_id = 5002;
UPDATE ticket SET ispayed = 1 WHERE ticket_id = 5003;

COMMIT;
