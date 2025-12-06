/*create database employee;

The task to be performed: 

1.	Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources.

2.	Create an ER diagram for the given employee database.*/




/* 3.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, 
and make a list of employees and details of their department.

select * from emp_record_table

select EMP_ID, FIRST_NAME, LAST_NAME , GENDER , DEPT AS Department from emp_record_table

*/



/* 4.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
●	less than two
●	greater than four 
●	between two and four


select EMP_ID, FIRST_NAME,LAST_NAME,GENDER,DEPT AS Department , EMP_RATING
 from emp_record_table where EMP_RATING<2 or EMP_RATING > 4 or EMP_RATING between 2 and 4
 
*/

/* 5.	Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table
 and then give the resultant column alias as NAME.

 select concat(FIRST_NAME ," " , LAST_NAME ) as name from emp_record_table where DEPT = 'Finance'
 */
 
/* 6.	Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).

-- step 1
select e.EMP_ID,e.FIRST_NAME,e.LAST_NAME, m.EMP_ID as M_id ,m.FIRST_NAME as M_name from emp_record_table e
join emp_record_table m  on e.MANAGER_ID = m.EMP_ID

-- step 2

select m.EMP_ID as M_id , m.FIRST_NAME as M_name , e.EMP_ID , e.FIRST_NAME from emp_record_table e
join emp_record_table m on e.MANAGER_ID = m.EMP_ID

--Step 3
select m_id as employess_id , M_name as employees_name,
COUNT(emp_id) number_of_reporting from ( 
select m.EMP_ID as M_id , m.First_name as M_name , e.EMP_ID , e.FIRST_NAME from emp_record_table e
join emp_record_table m on e.MANAGER_ID= m.EMP_ID)a 
group by m_id, M_name
*/

/* 7.	Write a query to list down all the employees from the healthcare and finance departments using union. 
Take data from the employee record table.


 select * from emp_record_table where DEPT = 'HEALTHCARE'
 union
 select * from emp_record_table where DEPT = 'FINANCE'

*/

/* 8.	Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT,
 and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.


-- step 1 
select * from emp_record_table


-- step 2
select EMP_ID , FIRST_NAME, LAST_NAME ,a.ROLE ,DEPT as Department ,EMP_RATING from emp_record_table a

-- step 3 
select dept as Department , max(emp_rating) as max_rating_depat from emp_record_table  where dept != 'ALL' group by dept

-- step 4
with emp as (select EMP_ID , FIRST_NAME, LAST_NAME ,a.ROLE ,DEPT as Department ,EMP_RATING from emp_record_table a),
groupBy as (select dept as Department , max(emp_rating) as max_rating_depat from emp_record_table  where dept != 'ALL' group by dept)
select a.* ,b.max_rating_Depat from emp a join groupBy b on a.Department = b.Department
*/

/* 9.	Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.


select DEPT as Department , min(SALARY) as Minimum_sal_Department, 
max(SALARY) as Maximum_sal_Department from emp_record_table where DEPT != ' ALL'
group by DEPT
*/

/* 10.	Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.

select * , dense_rank() over (order by exp desc)
rank1 from emp_record_table
*/

/* 11.	Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.

-- step 1
create view empview as
select EMP_ID,FIRST_NAME +' ' + LAST_NAME as Name ,GENDER ,COUNTRY ,SALARY from emp_record_table where SALARY>6000

select * from empview
*/

/* 12.	Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.


select * from emp_record_table where exp in 
( select EXP from emp_record_table where EXP >10)
*/

/* 13.	Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.

create or  alter procedure empdetails @emp varchar(10)
as
select * from emp_record_table where exp>3
go 
execute or exec both
exec empdetails@emp= emp_id
*/

/* 14.	Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.

The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.

CREATE OR ALTER FUNCTION employeExp (@exp INT)
RETURS NVARCHAR(50)
AS
BEGIN
DECLARE @jobProfile NVARCHAR(50)
IF @exp <=2
SET @jobProfile = 'JUNIOR DATA SCIENTIST'
ELSE IF @exp <=5
SET @jobProfile = 'ASSOCIATE DATA SCIENTIST'
ELSE IF @exp <=10
SET @jobProfile = 'SENIOR DATA SCIENTIST'
ELSE IF @exp <=12
SET @jobProfiel = 'LEAD DATA SCIENTIST'
ELSE
SET @jobProfile = 'MANAGER'
RETURN @jobProfile
END;

Select EMP_ID ,concat(first_name,last_name) as Name , EXP ,role, dbo.employeExp(exp) as JobProfile from data_science_team

-
*/


/* 15.	Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.

- create index idx_emp_rec_table on emp_record_table (FIRST_NAME);
select * from emp_record_table where FIRST_NAME = 'ERic';
*/


 

/* 16.	Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
select * from emp_record_table;
-- create duplicate table

select * into demo from emp_record_table;
 
 select * from demo;
 
 select EMP_RATING , (0.05*EMP_RATING) hike from demo;
 
 update demo set SALARY = (select SALARY +(select SALARY *0.05*EMP_Rating))
*/

/* 17.	Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.

select country, continent, avg(Salary) over ( partition by country) AVG_Salary_Distr_Country,
avg(Salary) over ( partition by Continent) AVG_Salary_Distr_Continent from emp_table;
*/

