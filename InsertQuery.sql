-- Inserting more clients
INSERT INTO Client (name, address, telephone)
VALUES
    ('Dmitri Vuković', '12 Stari Grad, Belgrade', '987-654-3210'),
    ('Elif Yıldız', '15 Gülhane Sokak, Istanbul', '111-222-3333'),
    ('Olga Petrovna', '30 Nevsky Prospect, St. Petersburg', '555-111-2222'),
    ('Juan García', '221B Baker Street, London', '444-123-4567'),
    ('Sophia Chen', '8 Central Street, New York', '777-234-5678');

-- Inserting more employees
INSERT INTO Employee (name, position, telephone)
VALUES
    ('Viktor Petrov', 1, '555-999-8888'),  -- Example: position 1 for Manager
    ('Aylin Demir', 2, '555-444-3333'),    -- Example: position 2 for Receptionist
    ('Maya Şahin', 3, '555-888-1234'),    -- Example: position 3 for Housekeeping
    ('Stefan Novak', 1, '555-555-5555'),   -- Manager
    ('Rachel Roberts', 2, '555-777-0000'); -- Receptionist

-- Inserting more rooms
INSERT INTO Room (number, type, price)
VALUES
    (101, 1, 99.99),  -- Room 101, Standard, $99.99
    (102, 2, 150.55),  -- Room 102, Deluxe, $150.55
    (103, 1, 120.50),  -- Room 103, Standard, $120.50
    (104, 3, 180.00),  -- Room 104, Suite, $180.00
    (105, 1, 110.75),  -- Room 105, Standard, $110.75
    (106, 2, 160.99);  -- Room 106, Deluxe, $160.99

-- Inserting more bookings
INSERT INTO Booking (client_id, employee_id, room_id, booking_date, start_date, end_date)
VALUES
    (1, 1, 1, '2025-01-10', '2025-01-10', '2025-01-15'),  -- Dmitri Vuković booking Room 101
    (2, 2, 2, '2025-01-12', '2025-01-12', '2025-01-18'),  -- Elif Yıldız booking Room 102
    (1, 1, 2, '2025-01-12', '2026-01-12', '2027-01-18'),  -- Dmitri Vuković booking Room 102 again
    (3, 3, 3, '2025-02-05', '2025-02-06', '2025-02-10'),  -- Olga Petrovna booking Room 103
    (4, 2, 4, '2025-03-15', '2025-03-16', '2025-03-20'),  -- Juan García booking Room 104
    (5, 1, 5, '2025-04-01', '2025-04-02', '2025-04-07');  -- Sophia Chen booking Room 105
