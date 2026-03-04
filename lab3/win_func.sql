-- 33. ROW_NUMBER: Пронумерувати квитки для кожної події за датою
SELECT event_id, purchase_date, ROW_NUMBER() OVER(PARTITION BY event_id ORDER BY purchase_date) as t_seq FROM tickets;

-- 34. RANK: Ранжування подій за базовою ціною
SELECT title, base_price, RANK() OVER(ORDER BY base_price DESC) as price_rank FROM events;

-- 35. DENSE_RANK: Ранжування за датою подій без пропусків у рангах
SELECT title, date, DENSE_RANK() OVER(ORDER BY date) as date_rank FROM events;

-- 36. LAG: Отримати ціну попереднього проданого квитка
SELECT id, price, LAG(price, 1) OVER(ORDER BY purchase_date) as previous_sale_price FROM tickets;

-- 37. LEAD: Отримати дату наступної запланованої події
SELECT title, date, LEAD(date, 1) OVER(ORDER BY date) as next_event_date FROM events;

-- 38. SUM OVER: Накопичувальна виручка за часом (Running Total)
SELECT purchase_date, price, SUM(price) OVER(ORDER BY purchase_date) as cumulative_revenue FROM tickets;

-- 39. AVG OVER: Порівняння ціни події з середньою у її категорії через вікно
SELECT title, category_id, base_price, AVG(base_price) OVER(PARTITION BY category_id) as category_average FROM events;

-- 40. NTILE: Розподіл подій на 4 цінові групи (квартилі)
SELECT title, base_price, NTILE(4) OVER(ORDER BY base_price) as price_group FROM events;