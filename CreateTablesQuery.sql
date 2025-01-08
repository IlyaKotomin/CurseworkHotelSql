CREATE TABLE Client (
    client_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    address VARCHAR(255),
    telephone VARCHAR(20)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    position INT,   -- You could reference a separate "Position" table if needed for roles
    telephone VARCHAR(20)
);

CREATE TABLE Room (
    room_id INT PRIMARY KEY IDENTITY(1,1),
    number INT UNIQUE,
    type INT,  -- Example: 1 = standard, 2 = deluxe, etc.
    price DECIMAL(10, 2)
);

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
