-- Solution for Problem 1:
WITH CTE_min_event_date AS (
    SELECT player_id, MIN(event_date) AS 'first_login' 
    FROM Activity GROUP BY player_id
)
SELECT a.player_id, a.device_id
FROM Activity a JOIN CTE_min_event_date c 
ON c.player_id = a.player_id AND a.event_date = c.first_login

-- Solution for Problem 2
SELECT player_id, event_date, 
    SUM(games_played) OVER (PARTITION BY player_id ORDER BY event_date) AS games_played_so_far
FROM Activity;

-- Solution for Problem 3:
SELECT ROUND(MIN(SQRT(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))), 2) AS shortest
FROM Point2D p1
JOIN Point2D p2 ON p1.x != p2.x OR p1.y != p2.y;

-- Solution for Problem 4:
SELECT p.firstName, p.lastName, a.city, a.state 
FROM Address a RIGHT JOIN Person p ON p.personId = a.personId;

-- Solution for Problem 5:
WITH CTE AS(
    SELECT customer_id, YEAR(order_date) AS 'year', SUM(price) as 'price'
    FROM Orders
    GROUP BY year, customer_id
    ORDER BY Customer_id, year
)
SELECT c1.customer_id
FROM CTE c1 LEFT JOIN CTE c2
ON c1.customer_id = c2.customer_id AND c1.year+1 = c2.year AND c1.price < c2.price
GROUP BY 1
Having
COUNT(*) - COUNT(c2.customer_id) = 1;
