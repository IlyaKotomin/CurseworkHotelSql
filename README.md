### Project: Database Foundations - Hotel Management System

#### 1. **Assignment**

Design and implement a database for a hotel, storing the following information:

-   **Client**: name, address, telephone number
-   **Employee**: name, position, telephone
-   **Room**: number, type, price
-   **Booking**: client, employee, room, date, period

**Rules:**

-   A client can have more than one booking at different times.
-   Each room can only accommodate one client at a time.

#### 2. **Database Normalization**

The database is normalized to ensure minimal redundancy and to facilitate efficient querying and updates. The structure contains:

-   Separate tables for clients, employees, rooms, and bookings.
-   **Foreign key constraints** ensuring integrity between entities.

----------

### 3. **ER Diagram**

The database can be visualized using the Entity-Relationship Diagram, created with Oracle Data Modeler or Data Grip.

**Entities**:

1.  **Client**: Stores personal information about clients, including unique client ID as a primary key.
2.  **Employee**: Stores employee details, including their position, telephone, and a unique employee ID.
3.  **Room**: Records room details with unique room IDs and other specifications.
4.  **Booking**: Links clients, employees, and rooms, recording the booking period.

![diagram](https://github.com/IlyaKotomin/CurseworkHotelSql/blob/main/3.png?raw=true)

----------

### 4. **SQL Commands**

#### 4.1 **Table Definitions (DDL)**

```sql
-- Creating the 'Client' table
CREATE TABLE Client (
    client_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    address VARCHAR(255),
    telephone VARCHAR(20)
);

-- Creating the 'Employee' table
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    position INT,   -- Position reference: 1 = Manager, 2 = Receptionist
    telephone VARCHAR(20)
);

-- Creating the 'Room' table
CREATE TABLE Room (
    room_id INT PRIMARY KEY IDENTITY(1,1),
    number INT UNIQUE,
    type INT,  -- Room type reference: 1 = Standard, 2 = Deluxe, etc.
    price DECIMAL(10, 2)
);

-- Creating the 'Booking' table
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    client_id INT,
    employee_id INT,
    room_id INT,
    booking_date DATE,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (client_id) REFERENCES Client(client_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id),
    CONSTRAINT UQ_Room_Only_One_Booking UNIQUE (room_id, start_date, end_date)
);
```

#### 4.2 **Sample Data Insertions (DML)**

```sql
-- Insert Clients
INSERT INTO Client (name, address, telephone)
VALUES
    ('Dmitri Vuković', '12 Stari Grad, Belgrade', '987-654-3210'),
    ('Elif Yıldız', '15 Gülhane Sokak, Istanbul', '111-222-3333'),
    ('Olga Petrovna', '30 Nevsky Prospect, St. Petersburg', '555-111-2222');

-- Insert Employees
INSERT INTO Employee (name, position, telephone)
VALUES
    ('Viktor Petrov', 1, '555-999-8888'),
    ('Aylin Demir', 2, '555-444-3333'),
    ('Maya Şahin', 3, '555-888-1234');

-- Insert Rooms
INSERT INTO Room (number, type, price)
VALUES
    (101, 1, 99.99),
    (102, 2, 150.55),
    (103, 1, 120.50);

-- Insert Bookings
INSERT INTO Booking (client_id, employee_id, room_id, booking_date, start_date, end_date)
VALUES
    (1, 1, 1, '2025-01-10', '2025-01-10', '2025-01-15');
```

----------

### 5. **Operations (Entering, Correcting, Deleting Data)**

#### 5.1 **Entering Data**

```sql
-- Insert data for a client, employee, room, and booking
INSERT INTO Client (name, address, telephone) VALUES ('John Doe', '123 Main St', '123-456-7890');
INSERT INTO Employee (name, position, telephone) VALUES ('Jane Smith', 1, '987-654-3210');
INSERT INTO Room (number, type, price) VALUES (101, 1, 99.99);
INSERT INTO Booking (client_id, employee_id, room_id, booking_date, start_date, end_date) 
VALUES (1, 1, 1, '2025-01-01', '2025-01-10', '2025-01-15');
```
#### 5.2 **Correcting Data**

```sql
-- Update client phone number
UPDATE Client SET telephone = '111-222-3333' WHERE client_id = 1;

-- Update employee position
UPDATE Employee SET position = 2 WHERE employee_id = 1;

-- Update room price
UPDATE Room SET price = 120.00 WHERE room_id = 1;
```

#### 5.3 **Deleting Data**

```sql
-- Delete client record (Ensure no dependent records exist)
DELETE FROM Client WHERE client_id = 1;
-- Delete associated employee, room, and booking if necessary
DELETE FROM Employee WHERE employee_id = 1;
```

----------

### 6. **Search Queries**

#### 6.1 **Search Room by Type**

```sql
SELECT * FROM Room WHERE type = 1;  -- Standard rooms
```
![table](https://github.com/IlyaKotomin/CurseworkHotelSql/blob/main6.1.png?raw=true)

#### 6.2 **Search Room by Date/Period (Availability Check)**

```sql
DECLARE @check_date DATE = '2025-01-14';
SELECT r.room_id, r.number, r.type, r.price
FROM Room r
         LEFT JOIN Booking b ON r.room_id = b.room_id
    AND @check_date BETWEEN b.start_date AND b.end_date
WHERE b.booking_id IS NULL;
```

![table](https://github.com/IlyaKotomin/CurseworkHotelSql/blob/main6.2.png?raw=true)

#### 6.3 **Search Client by Phone**

```sql
SELECT * FROM Client WHERE telephone = '111-222-3333';
```

![table](https://github.com/IlyaKotomin/CurseworkHotelSql/blob/main6.3.png?raw=true)

----------

### 7. **Reports**

#### 7.1 **Client’s Total Account**

```sql
SELECT c.client_id, c.name, SUM(r.price) AS total_account
FROM Client c
JOIN Booking b ON c.client_id = b.client_id
JOIN Room r ON b.room_id = r.room_id
WHERE c.client_id = 1
GROUP BY c.client_id, c.name;
```

![table](https://github.com/IlyaKotomin/CurseworkHotelSql/blob/main7.1.png?raw=true)

#### 7.2 **Last 5 Customer Reservations**

```sql
SELECT TOP 5 b.booking_id, b.booking_date, b.start_date, b.end_date, r.number AS room_number
FROM Booking b
JOIN Room r ON b.room_id = r.room_id
WHERE b.client_id = 1
ORDER BY b.booking_date DESC;
```

![table](https://github.com/IlyaKotomin/CurseworkHotelSql/blob/main7.2.png?raw=true)

#### 7.3 **Available Rooms for Type/Date/Period**

```sql
SELECT r.room_id, r.number
FROM Room r
WHERE r.type = 2 -- for deluxe rooms
AND NOT EXISTS (
    SELECT 1 FROM Booking b
    WHERE b.room_id = r.room_id 
    AND ('2025-01-10' BETWEEN b.start_date AND b.end_date)
);
```

![table](https://github.com/IlyaKotomin/CurseworkHotelSql/blob/main7.3.png?raw=true)

#### 7.4 **Reservations Count by Employee in a Given Period**

```sql
SELECT e.employee_id, e.name, COUNT(b.booking_id) AS number_of_reservations
FROM Employee e
JOIN Booking b ON e.employee_id = b.employee_id
WHERE b.start_date BETWEEN '2025-01-01' AND '2025-01-31'
GROUP BY e.employee_id, e.name;
```

![table](https://github.com/IlyaKotomin/CurseworkHotelSql/blob/main7.4.png?raw=true)

----------
