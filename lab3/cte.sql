-- 26. CTE для розрахунку статистики продажів по кожній події
WITH EventSales AS (
    SELECT event_id, COUNT(*) as ticket_count, SUM(price) as revenue FROM tickets GROUP BY event_id
)
SELECT e.title, s.ticket_count, s.revenue FROM events e JOIN EventSales s ON e.id = s.event_id;

-- 27. CTE для фільтрації VIP користувачів (більше 2 квитків)
WITH VIP_Users AS (
    SELECT user_id FROM tickets GROUP BY user_id HAVING COUNT(*) > 2
)
SELECT u.full_name, u.email FROM users u JOIN VIP_Users v ON u.id = v.user_id;

-- 28. CTE для аналізу завантаженості локацій
WITH LocationLoad AS (
    SELECT location_id, COUNT(*) as events_num FROM events GROUP BY location_id
)
SELECT l.name, ll.events_num FROM locations l JOIN LocationLoad ll ON l.id = ll.location_id;

-- 29. Поєднання двох CTE: Користувачі та їхні середні витрати
WITH UserSpending AS (
    SELECT user_id, AVG(price) as avg_spent FROM tickets GROUP BY user_id
)
SELECT u.full_name, us.avg_spent FROM users u JOIN UserSpending us ON u.id = us.user_id;

-- 30. CTE для ієрархії (якщо є вкладені категорії)
WITH RECURSIVE CategoryHierarchy AS (
    SELECT id, name FROM categories WHERE id = 1
    UNION ALL
    SELECT c.id, c.name FROM categories c JOIN CategoryHierarchy ch ON c.id = ch.id + 1 WHERE c.id < 5
)
SELECT * FROM CategoryHierarchy;

-- 31. CTE для визначення частки події у загальній виручці
WITH TotalRev AS (SELECT SUM(price) as total FROM tickets)
SELECT e.title, SUM(t.price) / (SELECT total FROM TotalRev) * 100 as percent_of_revenue
FROM events e JOIN tickets t ON e.id = t.event_id GROUP BY e.title;

-- 32. Складне CTE: Порівняння ціни події з середньою ціною по місту
WITH CityAvg AS (
    SELECT city, AVG(base_price) as avg_p FROM events e JOIN locations l ON e.location_id = l.id GROUP BY city
)
SELECT e.title, l.city, e.base_price, ca.avg_p FROM events e 
JOIN locations l ON e.location_id = l.id JOIN CityAvg ca ON l.city = ca.city;