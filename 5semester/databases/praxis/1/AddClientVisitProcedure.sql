DELIMITER @@@

CREATE PROCEDURE AddClientVisit (
    IN master_name VARCHAR(45),
    IN master_surname VARCHAR(45),
    IN client_name VARCHAR(45),
    IN client_surname VARCHAR(45),
    IN client_phone_number VARCHAR(48),
    IN name_of_service VARCHAR(100),
    IN service_price DECIMAL(10, 2),
    IN visit_date DATE
)
BEGIN
    DECLARE master_id INT;
    DECLARE client_id INT;
    DECLARE service_id INT;
    DECLARE visit_id INT;

    -- Проверка существования мастера
    SELECT id INTO master_id
    FROM masters
    WHERE name = master_name AND surname = master_surname
    LIMIT 1;

    IF master_id IS NULL THEN
        INSERT INTO masters (name, surname)
        VALUES (master_name, master_surname);
        SET master_id = LAST_INSERT_ID();
    END IF;

    -- Проверка существования клиента
    SELECT id INTO client_id
    FROM clients
    WHERE name = client_name AND surname = client_surname AND phone_number = client_phone_number
    LIMIT 1;

    IF client_id IS NULL THEN
        INSERT INTO clients (name, surname, phone_number)
        VALUES (client_name, client_surname, client_phone_number);
        SET client_id = LAST_INSERT_ID();
    END IF;

    -- Проверка существования услуги
    SELECT id INTO service_id
    FROM services
    WHERE name = name_of_service AND price = service_price
    LIMIT 1;

    IF service_id IS NULL THEN
        INSERT INTO services (name, price)
        VALUES (name_of_service, service_price);
        SET service_id = LAST_INSERT_ID();
    END IF;

    -- Добавление визита
    INSERT INTO visits (client_id, visit_date)
    VALUES (client_id, visit_date);
    SET visit_id = LAST_INSERT_ID();

    -- Добавление деталей визита
    INSERT INTO visit_details (master_id, visit_id, service_id)
    VALUES (master_id, visit_id, service_id);

END @@@
DELIMITER;

CALL AddClientVisit('Слава', 'КПСС', 'Хан', 'Замай', '8 (444) 729-17-55', 'Укладка', '450', '2024-12-22');
