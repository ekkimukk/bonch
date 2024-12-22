DELIMITER @@@
CREATE PROCEDURE UpdatePrices (IN multiplier DECIMAL(10, 2))
BEGIN
    UPDATE services
    SET price = price * multiplier;
END @@@
DELIMITER;

