/*======================Assignment 05======================*/
/*== Part 01 ==*/
-- Use ITI DB
use iti
--1.Retrieve a number of students who have a value in their age. 

Select COUNT(St_Age) [Number Of Students]
From Student

--2.Display number of courses for each topic name 

Select T.Top_Name , COUNT(C.Crs_Id) [Number Of Courses]
From Course C , Topic T
Where T.Top_Id = C.Top_Id
Group By T.Top_Name

--3.Display student with the following Format (use isNull function)
--Student ID	Student Full Name	Department name

Select S.St_Id [Student ID] , CONCAT(ISNULL(S.St_Fname , 'No Name') , ' ' , ISNULL(S.St_Lname , 'No Name')) [Student Full Name] , D.Dept_Name
From Student S , Department D
Where D.Dept_Id = S.Dept_Id

--4.Select instructor name and his salary but if there is no salary display value ‘0000’ . “use one of Null Function” 

Select Ins_Name , ISNULL(Salary , 000) Salary
From Instructor

--5.Select Supervisor first name and the count of students who supervises on them

Select Supers.St_Fname , COUNT(Stds.St_Id) [Number Of Students]
From Student Stds , Student Supers
Where Supers.St_Id = Stds.St_super
Group By Supers.St_Fname

--6.Display max and min salary for instructors
Select MAX(Salary) [Max Salary] , MIN(Salary) [Min Salary]
From Instructor

--7.Select Average Salary for instructors

Select AVG(Salary) [Average Salary]
From Instructor

--8.Display instructors who have salaries less than the average salary of all instructors.

Select *
From Instructor
Where Salary < (Select AVG(Salary) From Instructor)

--9.Display the Department name that contains the instructor who receives the minimum salary.

Select D.Dept_Name
From Instructor I , Department D
Where D.Dept_Id = I.Dept_Id and I.Salary = (Select MIN(Salary) From Instructor)

--============================
--10.Select max two salaries in instructor table. 

Select Top(2) Salary
From Instructor
Order By Salary Desc

/*=========================================================================================================================*/
/*== Part 02 ==*/
--Use MyCompany DB
use MyCompany

--DQL:
--1.For each project, list the project name and the total hours per week (for all employees) spent on that project.

Select P.Pname , SUM(WF.Hours) [Project Hours]
From Project P , Works_for WF
Where P.Pnumber = WF.Pno
Group By P.Pname


--2.For each department, retrieve the department name and the maximum, minimum and average salary of its employees.

Select D.Dname , MAX(E.Salary) [Max Salary] , MIN(E.Salary) [Min Salary] , AVG(E.Salary) [Average Salary]
From Departments D ,Employee E
Where D.Dnum = E.Dno
Group By D.Dname

--3.Display the data of the department which has the smallest employee ID over all employees' ID.

Select D.*
From Employee E , Departments D
Where D.Dnum = E.Dno and E.SSN = (Select MIN(SSN) From Employee Where Dno is not NULL)

--4.List the last name of all managers who have no dependents.

Select E.Lname , D.Dname
From Employee E , Departments D
Where E.SSN = D.MGRSSN and E.SSN not in (Select ESSN From Dependent)

--5.For each department-- if its average salary is less than the average salary of all employees display its number, name and number of its employees.

Select D.Dnum , D.Dname , COUNT(E.SSN) [Number Of Employees]
From Departments D , Employee E
Where D.Dnum = E.Dno
Group By  D.Dnum , D.Dname
Having AVG(E.Salary) < (Select AVG(Salary) from Employee)


--6.Try to get the max 2 salaries using subquery

Select  MAX(Salary)
From Employee
Union
Select MAX(Salary)
From Employee
Where Salary < (Select MAX(Salary) From Employee)

-------------------------------------------------------------------------
Select (Select  MAX(Salary)
From Employee) , (Select MAX(Salary)
From Employee
Where Salary < (Select MAX(Salary) From Employee))

-----------------------------------------------------------------------------------------------------------------------------------

--7.Display the employee number and name if he/she has at least one dependent (use exists keyword) self-study.

Select Distinct E.Fname , E.SSN
From Employee E , Dependent D
Where E.SSN = D.ESSN and Exists(Select ESSN From Dependent )
 

--------------------------------------------------------------------

Select E.Fname , E.SSN
From Employee E 
Where Exists(Select ESSN From Dependent D Where E.SSN =  D.ESSN )

/*=========================================================================================================================*/





