-- schema.sql: PostgreSQL schema for Employment Management System
-- Creates Department, JobPosition, Employee tables with relationships.

-- Drop tables if they exist for reset (not for production use; remove in prod)
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS job_positions CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

-- Department table
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Job Position table
CREATE TABLE job_positions (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    department_id INTEGER REFERENCES departments(id) ON DELETE SET NULL
);

-- Employee table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    department_id INTEGER REFERENCES departments(id) ON DELETE SET NULL,
    job_position_id INTEGER REFERENCES job_positions(id) ON DELETE SET NULL,
    salary NUMERIC(12, 2)
);

-- Indexes for faster lookups
CREATE INDEX idx_employee_department ON employees(department_id);
CREATE INDEX idx_employee_position ON employees(job_position_id);

-- Minimal seed data for demonstration (optional, remove in prod)
INSERT INTO departments (name, description) VALUES
    ('Human Resources', 'Handles employee related services'),
    ('Engineering', 'Product development and maintenance'),
    ('Sales', 'Manages sales operations');

INSERT INTO job_positions (title, description, department_id) VALUES
    ('HR Manager', 'Manages HR activities', 1),
    ('Software Engineer', 'Develops software products', 2),
    ('Sales Executive', 'Handles client accounts', 3);

INSERT INTO employees (first_name, last_name, email, department_id, job_position_id, salary)
VALUES
    ('Alice', 'Smith', 'alice.smith@example.com', 1, 1, 65000),
    ('Bob', 'Jones', 'bob.jones@example.com', 2, 2, 90000),
    ('Carol', 'White', 'carol.white@example.com', 3, 3, 70000);
