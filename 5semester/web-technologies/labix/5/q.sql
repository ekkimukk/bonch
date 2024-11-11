CREATE DATABASE IF NOT EXISTS web_lab_5;

USE web_lab_5;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL,
    login VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active'
);

INSERT INTO users (nickname, login, email, status) VALUES
('Nick1', 'login1', 'email1@example.com', 'active'),
('Nick2', 'login2', 'email2@example.com', 'inactive'),
('Nick3', 'login3', 'email3@example.com', 'active');

create table if not exists users_with_hashes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL,
    login VARCHAR(50) NOT NULL,
    password_hash char(41) NOT NULL,
    email VARCHAR(100) NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active'
    CHECK (LENGTH(login) BETWEEN 3 AND 15),
    CHECK (LENGTH(password_hash) BETWEEN 10 AND 15)
);

Insert Into users_with_hashes (nickname, login, password_hash, email, status) values
('Nick1', 'login1', 'email1@example.com', PASSWORD('password1'), 'active'),
('Nick2', 'login2', 'email2@example.com', PASSWORD('password2'), 'inactive'),
('Nick3', 'login3', 'email3@example.com', PASSWORD('password3'), 'active');
