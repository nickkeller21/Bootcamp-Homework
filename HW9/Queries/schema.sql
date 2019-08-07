-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

DROP TABLE IF EXISTS departments CASCADE;
CREATE TABLE departments (
    dept_no varchar(10) PRIMARY KEY  NOT NULL,
    department varchar(30)   NOT NULL
);

DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE employees (
    emp_no int PRIMARY KEY NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar(30)   NOT NULL,
    last_name varchar(30)   NOT NULL,
    gender varchar(1)   NOT NULL,
    hire_date date   NOT NULL
);

DROP TABLE IF EXISTS salaries CASCADE;
CREATE TABLE salaries(
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

DROP TABLE IF EXISTS titles CASCADE;
CREATE TABLE titles (
    emp_no int   NOT NULL,
    title varchar(30)   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

DROP TABLE IF EXISTS dept_emp CASCADE;
CREATE TABLE dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar(10)   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

DROP TABLE IF EXISTS dept_manager CASCADE;
CREATE TABLE dept_manager (
    dept_no varchar(10)   NOT NULL,
    emp_no int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);




