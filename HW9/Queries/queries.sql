--1
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees e 
JOIN salaries s ON e.emp_no=s.emp_no;

--2
SELECT last_name, first_name
FROM employees
WHERE hire_date >= '1986-01-01'
AND hire_date < '1987-01-01';

--3
--All Dept managers ever
SELECT dm.dept_no, d.department, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager dm
LEFT JOIN departments d ON dm.dept_no=d.dept_no
JOIN employees e ON dm.emp_no=e.emp_no;
--Current Department managers
SELECT dm.dept_no, d.department, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager dm
LEFT JOIN departments d ON dm.dept_no=d.dept_no
JOIN employees e ON dm.emp_no=e.emp_no
WHERE dm.to_date>'9998-01-01';

--4
SELECT e.emp_no, last_name, first_name, department
FROM employees e
JOIN dept_emp de ON e.emp_no=de.emp_no
JOIN departments d ON de.dept_no=d.dept_no;

--5
SELECT * 
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6
SELECT e.emp_no, last_name, first_name, department
FROM employees e
JOIN dept_emp de ON e.emp_no=de.emp_no
JOIN departments d ON de.dept_no=d.dept_no
WHERE department = 'Sales';

--7
SELECT e.emp_no, last_name, first_name, department
FROM employees e
JOIN dept_emp de ON e.emp_no=de.emp_no
JOIN departments d ON de.dept_no=d.dept_no
WHERE department = 'Sales'
OR department = 'Development';

--8
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY last_name desc;