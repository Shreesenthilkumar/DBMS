CREATE DATABASE SENIOR;
USE SENIOR
CREATE DATABASE BRANCH;
CREATE TABLE BRANCH(
BRANCH_ID INT PRIMARY KEY AUTO_INCREMENT,
BR_NAME VARCHAR(20) NOT NULL,
ADDR VARCHAR(200) );
DESC BRANCH;
SELECT * FROM BRANCH;

CREATE DATABASE EMPLOYEE;
CREATE TABLE employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    ename VARCHAR(30) NOT NULL,
    job_desc VARCHAR(20),
    salary INT,
    branch_id INT,
    CONSTRAINT FK_branchId FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

INSERT INTO BRANCH (BR_NAME, ADDR) VALUES
('Central', '123 Main St, Mumbai'),
('North Zone', '88 Ring Road, Delhi'),
('South Wing', '45 MG Road, Bengaluru'),
('East Point', '12 Salt Lake, Kolkata'),
('West Hub', '67 Marine Drive, Mumbai');

INSERT INTO employee (ename, job_desc, salary, branch_id) VALUES
('Amit Sharma', 'Manager', 85000, 1),
('Riya Mehta', 'Clerk', 30000, 2),
('Karan Patel', 'Developer', 60000, 3),
('Sneha Roy', 'Tester', 50000, 4),
('Vikram Singh', 'Support', 40000, 5),
('Neha Kapoor', 'Manager', 87000, 1),
('Arjun Reddy', 'Clerk', 32000, 2),
('Priya Das', 'Developer', 63000, 3),
('Rohit Verma', 'Tester', 51000, 4),
('Anita Nair', 'Support', 42000, 5),
('Deepak Jain', 'Manager', 90000, 1),
('Sonal Joshi', 'Clerk', 31000, 2),
('Tarun Malik', 'Developer', 64000, 3),
('Pooja Iyer', 'Tester', 52000, 4),
('Kavita Rao', 'Support', 41000, 5);

SELECT 
    employee.emp_id, 
    employee.ename, 
    employee.job_desc, 
    branch.branch_id
FROM employee
JOIN branch
ON employee.branch_id = branch.branch_id;




