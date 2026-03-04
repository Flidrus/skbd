-- 6. INNER JOIN: Список назв подій та міст, де вони проходять
SELECT e.title, l.city FROM events e 
INNER JOIN locations l ON e.location_id = l.id;

-- 7. LEFT JOIN: Усі користувачі та дати їхніх покупок (включаючи тих, хто нічого не купив)
SELECT u.full_name, t.purchase_date FROM users u 
LEFT JOIN tickets t ON u.id = t.user_id;

-- 8. RIGHT JOIN: Усі локації та події, заплановані в них
SELECT l.name, e.title FROM events e 
RIGHT JOIN locations l ON e.location_id = l.id;

-- 9. FULL JOIN: Поєднання категорій та подій для виявлення порожніх категорій
SELECT c.name AS category, e.title AS event FROM categories c 
FULL JOIN events e ON c.id = e.category_id;

-- 10. CROSS JOIN: Можливі комбінації користувачів та категорій для розсилки
SELECT u.full_name, c.name FROM users u CROSS JOIN categories c;

-- 11. SELF JOIN: Пошук користувачів з однаковими номерами телефону
SELECT u1.full_name, u2.full_name FROM users u1 
JOIN users u2 ON u1.phone = u2.phone AND u1.id <> u2.id;

-- 12. Потрійний JOIN: Детальна інформація про квиток (подія, локація, ціна)
SELECT t.id, e.title, l.name, t.price FROM tickets t
JOIN events e ON t.event_id = e.id
JOIN locations l ON e.location_id = l.id;