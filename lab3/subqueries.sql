-- 13. Подія з максимальною базовою ціною
SELECT title, base_price FROM events 
WHERE base_price = (SELECT MAX(base_price) FROM events);

-- 14. Користувачі, які купували квитки на події дорожче 400
SELECT full_name FROM users WHERE id IN (
    SELECT user_id FROM tickets WHERE price > 400
);

-- 15. Події, на які ще не продано жодного квитка
SELECT title FROM events WHERE id NOT IN (
    SELECT DISTINCT event_id FROM tickets
);

-- 16. EXISTS: Користувачі, які мають хоча б один оплачений квиток
SELECT full_name FROM users u WHERE EXISTS (
    SELECT 1 FROM tickets t WHERE t.user_id = u.id AND t.status = 'paid'
);

-- 17. NOT EXISTS: Локації, в яких не заплановано жодної події
SELECT name FROM locations l WHERE NOT EXISTS (
    SELECT 1 FROM events e WHERE e.location_id = l.id
);

-- 18. Підзапит у SELECT: Назва події та різниця її ціни від середньої
SELECT title, base_price - (SELECT AVG(base_price) FROM events) AS price_diff FROM events;

-- 19. Підзапит у FROM: Середня виручка на одну локацію
SELECT AVG(total_loc_sales) FROM (
    SELECT location_id, SUM(price) as total_loc_sales FROM events e
    JOIN tickets t ON e.id = t.event_id GROUP BY location_id
) AS loc_totals;

-- 20. Корельований підзапит: Події дорожчі за середню ціну у своїй категорії
SELECT e1.title, e1.base_price FROM events e1 WHERE e1.base_price > (
    SELECT AVG(e2.base_price) FROM events e2 WHERE e2.category_id = e1.category_id
);