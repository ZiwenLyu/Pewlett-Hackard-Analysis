-- Creating tables for PH-EmployeeDB
CREATE TABLE departments(
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);
CREATE TABLE employees(
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);
CREATE TABLE dept_managers(
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (dept_no,emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
CREATE TABLE titles(
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
SELECT * FROM departments;

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create retirement new table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE  (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- check the table
SELECT *
FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_no,
       dm.emp_no,
       dm.from_date,
       dm.to_date
FROM dept_managers as dm
INNER JOIN departments as d ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT re.emp_no,
       re.first_name,
       re.last_name,
	   de.to_date
FROM retirement_info as re
LEFT JOIN dept_emp as de ON re.emp_no = de.emp_no

-- Find retirement-eligible employees currently work at PH
SELECT re.emp_no,
       re.first_name,
	   re.last_name,
	   de.to_date
INTO current_emp
FROM retirement_info as re
LEFT JOIN dept_emp as de ON re.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT *
FROM current_emp

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Check salaries and to_date
SELECT * FROM salaries
ORDER BY to_date DESC;


-- retirement eligible employee info
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
 ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
 ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT dm.dept_no,
       d.dept_name,
	   dm.emp_no,
	   ce.first_name,
	   ce.last_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
FROM dept_managers as dm
INNER JOIN departments as d 
 ON d.dept_no = dm.dept_no
INNER JOIN current_emp as ce
 ON dm.emp_no = ce.emp_no;
 
-- List of department retirees
SELECT ce.emp_no,
       ce.first_name,
       ce.last_name,
       d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- List of Sales and Development department retirees
SELECT ce.emp_no,
       ce.first_name,
       ce.last_name,
	   d.dept_name
INTO sales_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

-- List of Sales and Development department retirees
SELECT ce.emp_no,
       ce.first_name,
       ce.last_name,
	   d.dept_name
INTO sales_del_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name in ('Sales','Development');

SELECT *
FROM sales_del_info