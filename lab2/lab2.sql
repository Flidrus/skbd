Korben Dallas, [23.02.2026 0:45]
CREATE ROLE event_admin WITH LOGIN PASSWORD 'admin123';
ALTER ROLE event_admin SUPERUSER;

CREATE ROLE event_moderator WITH LOGIN PASSWORD 'mod123';
GRANT CONNECT ON DATABASE "LAB2" TO event_moderator;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO event_moderator;

CREATE ROLE event_user WITH LOGIN PASSWORD 'user123';
GRANT CONNECT ON DATABASE "LAB2" TO event_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO event_user;

Korben Dallas, [23.02.2026 0:45]
CREATE TABLE venues (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INTEGER CHECK (capacity > 0),
    address VARCHAR(255)
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    event_date TIMESTAMP NOT NULL,
    venue_id INTEGER REFERENCES venues(id) ON DELETE CASCADE
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_sum DECIMAL(10, 2)
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    event_id INTEGER REFERENCES events(id),
    order_id INTEGER REFERENCES orders(id),
    price DECIMAL(10, 2) NOT NULL,
    seat VARCHAR(10)
);

Korben Dallas, [23.02.2026 0:45]
INSERT INTO venues (name, capacity, address) VALUES 
('Палац Спорту', 10000, 'Київ, Спортивна площа, 1'),
('Олімпійський', 70000, 'Київ, вул. Велика Васильківська, 55');

INSERT INTO events (title, event_date, venue_id) VALUES 
('Турнір NAVI-Virtus.pro', '2026-05-20 20:00:00', 1),
('WGfest', '2026-06-10 21:00:00', 2),
('Kyivfoodfest', '2026-03-01 19:00:00', 1);

INSERT INTO customers (full_name, email, phone_number) VALUES 
('Гомельський Семен', 'gomelskiy2005@gmail.com', '+380669067501'),
('Олександр Крижановський', 'sasha.o@gmail.com', '+380674445566'),
('Ева Черкун', 'cherkun@gmail.com', '+380937778899');

INSERT INTO orders (customer_id, order_date, total_sum) VALUES 
(1, '2026-02-10', 3000.00),
(2, '2026-02-12', 500.00),
(3, '2026-01-20', 1600.00);

INSERT INTO tickets (event_id, order_id, price, seat) VALUES 
(1, 1, 1500.00, 'A-12'), (1, 1, 1500.00, 'A-13'),
(2, 2, 500.00, 'Sector B'),
(3, 3, 800.00, 'Ряд 5, м. 1'), (3, 3, 800.00, 'Ряд 5, м. 2');

Korben Dallas, [23.02.2026 0:45]
DROP TABLE IF EXISTS tickets, orders, events, customers, venues CASCADE;

CREATE TABLE venues (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INTEGER CHECK (capacity > 0),
    address VARCHAR(255)
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    event_date TIMESTAMP NOT NULL,
    venue_id INTEGER REFERENCES venues(id) ON DELETE CASCADE
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_sum DECIMAL(10, 2)
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    event_id INTEGER REFERENCES events(id),
    order_id INTEGER REFERENCES orders(id),
    price DECIMAL(10, 2) NOT NULL,
    seat VARCHAR(10)
);

Korben Dallas, [23.02.2026 0:46]
INSERT INTO venues (name, capacity, address) VALUES 
('Палац Спорту', 10000, 'Київ, Спортивна площа, 1'),
('Олімпійський', 70000, 'Київ, вул. Велика Васильківська, 55');

INSERT INTO events (title, event_date, venue_id) VALUES 
('Турнір NAVI-Virtus.pro', '2026-05-20 20:00:00', 1),
('WGFest', '2026-06-18 21:00:00', 2),
('Kyivfoodfest', '2026-03-01 19:00:00', 1);

INSERT INTO customers (full_name, email, phone_number) VALUES 
('Гомельський Семен', 'gomelskiy2005@gmail.com', '+380669067581'),
('Олександр Крижановський', 'sasha.o@gmail.com', '+380674445566'),
('Єва Черкун', 'cherkun@gmail.com', '+380937778899');

INSERT INTO orders (customer_id, total_sum) VALUES 
(1, 3000.00), (2, 500.00), (3, 1600.00);

INSERT INTO tickets (event_id, order_id, price, seat) VALUES 
(1, 1, 1500.00, 'A-12'), (1, 1, 1500.00, 'A-13'),
(2, 2, 500.00, 'Sector B'),
(3, 3, 800.00, 'Ряд 5'), (3, 3, 800.00, 'Ряд 6');

Korben Dallas, [23.02.2026 0:46]
SELECT e.title AS "Подія", v.name AS "Локація", e.event_date AS "Дата"
FROM events e
JOIN venues v ON e.venue_id = v.id;

Korben Dallas, [23.02.2026 0:46]
SELECT e.title AS "Назва заходу", COUNT(t.id) AS "Кількість квитків"
FROM events e
LEFT JOIN tickets t ON e.id = t.event_id
GROUP BY e.title;

Korben Dallas, [23.02.2026 0:46]
SELECT SUM(price) AS "Загальний дохід" FROM tickets;

Korben Dallas, [23.02.2026 0:46]
SELECT c.full_name, e.title, t.seat, t.price
FROM tickets t
JOIN events e ON t.event_id = e.id
JOIN orders o ON t.order_id = o.id
JOIN customers c ON o.customer_id = c.id;

Korben Dallas, [23.02.2026 0:46]
SELECT e.title, SUM(t.price) AS total_revenue
FROM events e
JOIN tickets t ON e.id = t.event_id
GROUP BY e.title;
