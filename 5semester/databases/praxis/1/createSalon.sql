CREATE DATABASE IF NOT EXISTS salon;
USE salon;

CREATE TABLE IF NOT EXISTS masters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    surname VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    surname VARCHAR(45) NOT NULL,
    phone_number VARCHAR(48)
);

CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS visits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    visit_date DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE
);

CREATE TABLE visit_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT NOT NULL,
    service_id INT NOT NULL,
    visit_id INT NOT NULL,
    FOREIGN KEY (master_id) REFERENCES masters (id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services (id) ON DELETE CASCADE,
    FOREIGN KEY (visit_id) REFERENCES visits (id) ON DELETE CASCADE,
    UNIQUE (master_id, service_id, visit_id)
);

