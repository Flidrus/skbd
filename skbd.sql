SELECT o.order_id, p.brand, p.model, o.quantity, o.total_price
FROM Orders o
JOIN Phones p ON o.phone_id = p.phone_id;