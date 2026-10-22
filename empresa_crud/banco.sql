-- Execute no phpMyAdmin (http://localhost/phpmyadmin) para criar o banco e a tabela

CREATE DATABASE IF NOT EXISTS empresa
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE empresa;

CREATE TABLE IF NOT EXISTS funcionario (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100)  NOT NULL,
    email         VARCHAR(100)  NOT NULL,
    telefone      VARCHAR(20),
    cargo         VARCHAR(50)   NOT NULL,
    salario       DECIMAL(10,2) NOT NULL,
    data_admissao DATE          NOT NULL
);
