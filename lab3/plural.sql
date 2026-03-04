-- 21. UNION: Список усіх унікальних назв (локацій та подій)
SELECT name AS label FROM locations UNION SELECT title FROM events;

-- 22. UNION ALL: Об'єднання всіх ID користувачів та локацій для технічного звіту
SELECT id FROM users UNION ALL SELECT id FROM locations;

-- 23. INTERSECT: ID користувачів, які зареєстровані та здійснили покупку
SELECT id FROM users INTERSECT SELECT user_id FROM tickets;

-- 24. EXCEPT: Категорії, для яких ще не створено жодної події
SELECT id FROM categories EXCEPT SELECT category_id FROM events;

-- 25. UNION: Події у Києві та події з категорією "Концерт"
SELECT title FROM events e JOIN locations l ON e.location_id = l.id WHERE l.city = 'Київ'
UNION
SELECT title FROM events e JOIN categories c ON e.category_id = c.id WHERE c.name = 'Концерт';