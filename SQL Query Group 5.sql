
-- 1 List the customers who joined the loyalty program in 2022 and have loyalty points greater than 100. --
USE Uniqlo;
SELECT customer_name, join_date, loyalty_point
FROM customer
WHERE YEAR(join_date) = 2022 AND loyalty_point > 100;


-- 2 List all stores that are not located in London. -- 
USE Uniqlo;
SELECT store_name, store_location
FROM store
WHERE store_location NOT LIKE '%London%';


-- 3 Provide information about a store, including its name, location, phone number, and the details of the store's manager, based on the store's name.--
USE Uniqlo 
SELECT 
	st.store_name,
	st.store_location,
	st.store_phone, 
	m.manager_name,
	m.manager_email,
	m.manager_address
FROM store st 
JOIN manager m ON st.manager_id = m.manager_id
WHERE st.store_name = 'Uniqlo - Oxford Westgate';


-- 4 List the products with the highest to lowest sales in terms of quantity sold? -- 
USE Uniqlo;
SELECT pr.product_name, SUM(s.unit_sold) AS total_sales
FROM sales s
INNER JOIN [Product] pr ON s.product_id = pr.product_id
GROUP BY pr.product_name
ORDER BY total_sales DESC;	


-- 5 Based on the customer_id, query data about the bill information for the products the customer has purchased and the buying date? --
USE Uniqlo
SELECT b.bill_id, 
	b.buying_date,
	p.product_name
FROM bill b
CROSS APPLY STRING_SPLIT(b.product_id, ',') AS s
JOIN product p ON p.product_id = s.value
WHERE b.customer_id = 'CUS0052';



-- 6 Which are the 5 customers with the highest loyalty points, along with the dates they joined as members? --
USE Uniqlo
SELECT TOP 5 loyalty_point, 
	customer_id,
	customer_name,
	join_date
FROM customer cu
ORDER BY cu.loyalty_point DESC;


-- 7 Which 3 products have the highest units sold in winter?  --
USE Uniqlo
SELECT TOP 3 pro.product_name, SUM(sa.unit_sold) AS total_units_sold
FROM sales sa
JOIN product pro ON sa.product_id = pro.product_id 
JOIN category ca on pro.category_id = ca.category_id
WHERE ca.season = 'Winter'
GROUP BY pro.product_name
ORDER BY total_units_sold DESC;


-- 8 Which product categories are selling the most in stores based on the quantity sold? --
USE Uniqlo
SELECT c.category_name, SUM(s.unit_sold) AS total_quantity_sold
FROM sales s
INNER JOIN [Product] pr ON s.product_id = pr.product_id
INNER JOIN category c ON pr.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_quantity_sold DESC;


-- 9 Which products have high discount rates but low sales revenue? --
USE Uniqlo;
SELECT 
pr.product_id,
pr.product_name,
p.discount_rate,
s.total_profit
FROM [Product] pr
INNER JOIN Price p ON p.price_id = pr.price_id
INNER JOIN Sales s ON pr.product_id = s.product_id
WHERE p.discount_rate > (SELECT AVG(discount_rate) FROM Price)  
AND s.total_profit < (SELECT AVG(total_profit) FROM Sales)  
ORDER BY p.discount_rate DESC, s.total_profit ASC;  


-- 10 Which two suppliers have the highest and lowest sales revenue? -- 
USE Uniqlo;
SELECT TOP 2 sp.supplier_name, pr.product_name, SUM(s.unit_sold * s.sale_price) AS total_sales
FROM sales s
INNER JOIN [Product] pr ON s.product_id = pr.product_id
INNER JOIN supplier sp ON pr.supplier_id = sp.supplier_id
GROUP BY sp.supplier_name, pr.product_name
ORDER BY total_sales DESC;
SELECT TOP 2 sp.supplier_name, pr.product_name, SUM(s.unit_sold * s.sale_price) AS total_sales
FROM Sales s
INNER JOIN [Product] pr ON s.product_id = pr.product_id
INNER JOIN supplier sp ON pr.supplier_id = sp.supplier_id
GROUP BY sp.supplier_name, pr.product_name
ORDER BY total_sales ASC;


-- 11 How can we automatically update inventory, profit, and sales ranking of products when a sale transaction occurs, 
--    while also checking and notifying when inventory is low, to improve product management and store revenue?  --
CREATE TRIGGER UpdateInventoryAndSales
ON Sales
AFTER INSERT  
AS
BEGIN
    -- Update inventory quantity in the Inventory table when a product is sold  
UPDATE Inventory
SET inventory_quantity = inventory_quantity - i.unit_sold
FROM Inventory inv
INNER JOIN inserted i ON inv.product_id = i.product_id
INNER JOIN Store st ON inv.store_id = st.store_id;

    -- Update sale_price and calculate total profit in the Sales table 
UPDATE s
SET s.sale_price = p.selling_price
FROM Sales s
INNER JOIN inserted i ON s.sale_id = i.sale_id
INNER JOIN [Product] pr ON i.product_id = pr.product_id
INNER JOIN Price p ON pr.price_id = p.price_id;

UPDATE s
SET s.total_profit = s.sale_price * s.unit_sold
FROM Sales s
INNER JOIN inserted i ON s.sale_id = i.sale_id;

    -- Update sale_rank based on the total profit of product 
WITH RankCTE AS
(SELECT sale_id, RANK() OVER (ORDER BY total_profit DESC) AS rank
FROM Sales)
UPDATE s
SET s.sale_rank = r.rank
FROM Sales s
INNER JOIN RankCTE r ON s.sale_id = r.sale_id;

    -- Check if inventory quantity is less than 10 and notify to restock  
IF EXISTS (SELECT 1 
FROM Inventory 
WHERE product_id IN (SELECT product_id FROM inserted) 
AND inventory_quantity < 10)
BEGIN
PRINT 'Stock for product is low! Please consider restocking.';
END
END;


--  TEST TRIGGER --
INSERT INTO sales (sale_id, product_id,unit_sold, sale_rank)
VALUES ('SALE_0032', 470148,65,0);

DELETE FROM Sales
WHERE sale_id = 'SALE_0032';

CREATE TRIGGER UndoUpdateInventoryAndSales
ON Sales
AFTER DELETE
AS
BEGIN
    -- Restore inventory quantity in Inventory table when product is deleted
UPDATE Inventory
SET inventory_quantity = inventory_quantity + d.unit_sold
FROM Inventory inv
INNER JOIN deleted d ON inv.product_id = d.product_id;

    -- Restore selling price and profit in Sales table
UPDATE s
SET s.sale_price = NULL,  
    s.total_profit = NULL  
FROM Sales s
INNER JOIN deleted d ON s.sale_id = d.sale_id;

    -- Restore sale_rank (need to update again after deleting record)
WITH RankCTE AS (
SELECT sale_id, RANK() OVER (ORDER BY total_profit DESC) AS rank
FROM Sales)
UPDATE s
SET s.sale_rank = r.rank
FROM Sales s
INNER JOIN RankCTE r ON s.sale_id = r.sale_id;
END;
