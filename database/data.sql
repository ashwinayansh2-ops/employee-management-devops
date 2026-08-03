CREATE DATABASE IF NOT EXISTS employee_management;

USE employee_management;

CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_code VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    department VARCHAR(100),
    designation VARCHAR(100),
    salary DECIMAL(10,2),
    hire_date DATE,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO employees
(employee_code,
 first_name,
 last_name,
 email,
 phone,
 department,
 designation,
 salary,
 hire_date,
 status)
VALUES

('EMP001','John','Doe','john.doe@company.com','9876543210','Engineering','Software Engineer',65000,'2023-01-10','ACTIVE'),

('EMP002','Jane','Smith','jane.smith@company.com','9876543211','HR','HR Manager',75000,'2022-09-15','ACTIVE'),

('EMP003','Michael','Johnson','michael.johnson@company.com','9876543212','Finance','Financial Analyst',72000,'2021-05-20','ACTIVE'),

('EMP004','Emily','Davis','emily.davis@company.com','9876543213','Sales','Sales Executive',58000,'2024-02-12','ACTIVE'),

('EMP005','David','Wilson','david.wilson@company.com','9876543214','Engineering','DevOps Engineer',85000,'2020-11-05','ACTIVE'),

('EMP006','Sophia','Brown','sophia.brown@company.com','9876543215','Marketing','Marketing Specialist',62000,'2023-06-18','ACTIVE'),

('EMP007','James','Miller','james.miller@company.com','9876543216','Engineering','Technical Lead',110000,'2019-03-01','ACTIVE'),

('EMP008','Olivia','Taylor','olivia.taylor@company.com','9876543217','Support','Support Engineer',55000,'2024-01-22','ACTIVE'),

('EMP009','William','Anderson','william.anderson@company.com','9876543218','Engineering','QA Engineer',60000,'2022-07-14','ACTIVE'),

('EMP010','Emma','Thomas','emma.thomas@company.com','9876543219','Administration','Office Administrator',50000,'2021-12-10','ACTIVE');