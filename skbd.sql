CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Phones (
    phone_id SERIAL PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(155) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    storage_gb INT,
    category_id INT,
    CONSTRAINT fk_category
      FOREIGN KEY(category_id) 
      REFERENCES Categories(category_id)
      ON DELETE SET NULL
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    phone_id INT NOT NULL,
    quantity INT DEFAULT 1 CHECK (quantity > 0),
    order_date DATE DEFAULT CURRENT_DATE,
    total_price DECIMAL(10, 2), 
    CONSTRAINT fk_phone
      FOREIGN KEY(phone_id) 
      REFERENCES Phones(phone_id)
      ON DELETE CASCADE
);
INSERT INTO Categories (name) VALUES 
('Флагмани'), 
('Бюджетні'), 
('Захищені');

INSERT INTO Phones (brand, model, price, storage_gb, category_id) VALUES 
('Apple', 'iPhone 15 Pro', 45000.00, 256, 1),
('Samsung', 'Galaxy S24', 38000.00, 128, 1),
('Xiaomi', 'Redmi Note 13', 10500.00, 128, 2),
('Nokia', 'XR21', 18000.00, 128, 3);

INSERT INTO Orders (phone_id, quantity, total_price) VALUES 
(1, 1, 45000.00), 
(3, 1, 10500.00),
(4, 2, 36000.00);
SELECT * FROM Phones
SELECT p.brand, p.model, o.quantity, o.total_price 
FROM Orders o
JOIN Phones p ON o.phone_id = p.phone_id;
