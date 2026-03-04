-- 1. Загальна кількість подій у базі
SELECT COUNT(*) AS total_events FROM events;

-- 2. Загальна сума виручки від проданих квитків
SELECT SUM(price) AS total_revenue FROM tickets WHERE status = 'paid';

-- 3. Середня базова ціна квитка на всі події
SELECT AVG(base_price) AS average_event_price FROM events;

-- 4. Мінімальна ціна квитка серед усіх доступних подій
SELECT MIN(base_price) AS cheapest_event FROM events;

-- 5. Дата останнього проданого квитка
SELECT MAX(purchase_date) AS last_ticket_sale FROM tickets;