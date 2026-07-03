# 1.Retrieve the first and last names of all employees from the `employees` table.
SELECT first_name, last_name
FROM employees;

# 2. Find all departments with the name "Sales".
SELECT *
FROM departments
WHERE dept_name = 'Sales';

#3. List all the job titles in the titles table.
SELECT DISTINCT title
FROM titles;     
#This will give distinct title names

# 4. Show the `emp_no`, `from_date`, and `to_date` for employees working
# in the 'Sales' department.
SELECT de.emp_no ,de.from_date,de.to_date
FROM dept_emp de
JOIN departments d
ON d.dept_no=de.dept_no
WHERE d.dept_name='Sales';

# 5. Display the employee number and their corresponding department number 
#from the `dept_emp` table.
SELECT emp_no,dept_no
FROM dept_emp;

#6. Find the birth dates of all employees whose first name is 'John'.
#WHERE first_name = 'John';
SELECT first_name, birth_date
FROM employees
WHERE first_name = 'John';

#7.Show all department managers along with their department numbers.
SELECT dept_no,
       emp_no
FROM dept_manager;

#8. Retrieve the employee number and title 
#of employees whose title starts with 'Senior'.
SELECT emp_no,title
FROM titles
WHERE title LIKE 'Senior%';

#9. List the employee numbers and salaries where the salary is greater than 50,000.
SELECT emp_no,salary
FROM salaries
WHERE salary>50000;

#10. Find all employees who were hired after January 1, 2000.
SELECT *
FROM employees
WHERE hire_date> '2000-01-01';

#11. Find the highest salary for each employee.
#FROM salaries GROUP BY emp_no
SELECT 
	CONCAT(e.first_name,e.last_name)AS full_name,s.emp_no, 
	max(s.salary) AS highest_salary
	FROM employees e
	JOIN salaries s
	ON e.emp_no=s.emp_no
	GROUP BY e.emp_no;

#12. List all the departments along with the number of employees in each department.
SELECT d.dept_no,
       d.dept_name,
       COUNT(de.emp_no) AS total_employees
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
GROUP BY d.dept_no, d.dept_name;

#3. Retrieve the current department of each employee 
#using the `current_dept_emp` view.
SELECT *
FROM current_dept_emp ;

#4. Show the number of employees who hold the title 'Manager'.
SELECT COUNT(DISTINCT emp_no) AS total_managers
FROM titles
WHERE title = 'Manager';

#5. Find the employees who have worked in multiple departments.
SELECT 
		CONCAT(e.first_name,' ',e.last_name) AS full_name,
		de.emp_no,
       COUNT(DISTINCT de.dept_no) AS department_count
		FROM dept_emp de
		JOIN employees e
		ON e.emp_no=de.emp_no
		GROUP BY emp_no
		HAVING COUNT(DISTINCT dept_no) > 1;
        
#6. List the employee numbers and the total number of departments 
#they managed in their career.
SELECT emp_no,
       COUNT(DISTINCT dept_no) AS departments_managed
FROM dept_manager
GROUP BY emp_no;

#7. Display the employees whose salary was below 40,000 at any point.
SELECT DISTINCT s.emp_no, e.first_name, e.last_name, s.salary
FROM salaries s
JOIN employees e
  ON e.emp_no = s.emp_no
WHERE s.salary < 40000;

#8. Find all employees who are currently in a department
# but were previously in a different one.
SELECT de.emp_no,e.first_name,e.last_name
FROM dept_emp de
JOIN employees e
ON e.emp_no=de.emp_no
GROUP BY emp_no
HAVING COUNT(DISTINCT dept_no) > 1
   AND SUM(CASE WHEN to_date = '9999-01-01' THEN 1 ELSE 0 END) > 0;
   
#9. Get the department managers who have managed more than one department.
SELECT de.emp_no,e.first_name,e.last_name,
COUNT(DISTINCT de.dept_no) AS departments_managed
FROM dept_manager de
JOIN employees e
ON e.emp_no=de.emp_no
GROUP BY de.emp_no
HAVING COUNT(DISTINCT de.dept_no) > 1;

#10. Retrieve the titles of employees who have held the same title more than once.
SELECT emp_no,
       title,
       COUNT(*) AS times_held
FROM titles
GROUP BY emp_no, title
HAVING COUNT(*) > 1;