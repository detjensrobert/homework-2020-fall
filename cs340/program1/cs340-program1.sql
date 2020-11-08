-- CS 340 Assignment 1
-- Robert Detjens

-- 1. Create the table DEPT_STATS as shown below:

create table `DEPT_STATS` (
  `Dnumber` int(2) not null,
  `Emp_count` int(11) not null,
  `Avg_salary` decimal(10,2) not null,
  primary key (`Dnumber`),
  foreign key (`Dnumber`) references `DEPARTMENT` (`Dnumber`)
) ENGINE = INNODB;

-- 2. Write a procedure called InitDeptStats to initialize the table.

delimiter !
create procedure InitDeptStats()
begin
  insert into DEPT_STATS (Dnumber, Emp_count, Avg_salary)
    select E.Dno, count(*), avg(E.Salary)
    from EMPLOYEE E
    group by E.Dno;
end!
delimiter ;

-- 3. Write triggers for the EMPLOYEE table that modify the DEPT_STATS table
--    when rows are inserted, deleted or updated in the EMPLOYEE table.

delimiter !
create procedure UpdateDeptStats()
begin
  replace into DEPT_STATS (Dnumber, Emp_count, Avg_salary)
    select E.Dno, count(*), avg(E.Salary)
    from EMPLOYEE E
    group by E.Dno;
end!
delimiter ;

create trigger `DELETEDeptStats`
after delete on `EMPLOYEE`
for each row
call UpdateDeptStats();

create trigger `INSERTDeptStats`
after insert on `EMPLOYEE`
for each row
call UpdateDeptStats();

create trigger `UPDATEDeptStats`
after update on `EMPLOYEE`
for each row
call UpdateDeptStats();

-- 4. Write a trigger called MaxTotalHours for the WORKS_ON table that will
--    generate user defined error message if an attempt is made to assign the
--    employee more than 40 hours.

delimiter !
create trigger `MaxTotalHours`
before insert on `WORKS_ON`
for each row
begin
  declare hoursWorked decimal(3,1);
  declare errMsg varchar(100);

  select sum(Hours) + NEW.Hours
  into hoursWorked
  from WORKS_ON WO
  where WO.Essn = NEW.Essn
  group by NEW.Essn;

  if (hoursWorked > 40) then
    set errMsg = concat('ERR: Employee hours exceeds 40h (now ', hoursWorked, 'h, adding ', NEW.Hours, 'h)');
    signal SQLSTATE '45000' set MESSAGE_TEXT = errMsg;
  end if;
end!
delimiter ;

-- 5. Write a function called PayLevel that given an Ssn as input, returns:
--    "Above Average" if the employee makes more than the department average
--    "Average" if the employee makes the same as the department average
--    "Below Average" if the employee makes less than the department average

delimiter !
create function PayLevel(
  Ssn char(9)
)
returns varchar(25)
begin
  declare result varchar(25);

  select case
    when E.Salary > DS.Avg_salary then "Above Average"
    when E.Salary < DS.Avg_salary then "Below Average"
    else "Average"
  end into result
  from EMPLOYEE E, DEPT_STATS DS
  where E.Ssn = Ssn
    and E.Dno = DS.Dnumber;

  return result;
end!
delimiter ;
