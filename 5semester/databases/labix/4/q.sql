CREATE DATABASE lab4;
USE lab4;
CREATE TABLE IF NOT EXISTS departments (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
INSERT INTO departments (id, name) VALUES (1, "Group A");
INSERT INTO departments (id, name) VALUES (2, "Group B");
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    d_id INT
);
INSERT INTO users (name, d_id) VALUES ('Ivan', 1);
INSERT INTO users (name, d_id) VALUES ('Tommy', 1);
INSERT INTO users (name, d_id) VALUES ('Olga', 2);
INSERT INTO users (name, d_id) VALUES ('Ann', 2);
INSERT INTO users (name, d_id) VALUES ('Anthony', 2);

