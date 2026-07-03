-- PROJECT TASK


-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books (isbn, book_title, category, rental_price, status, author, publisher)
values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
select * from books;

-- Task 2: Update an Existing Member's Address for member_id 107
update members
set member_address = '965 Sandle St'
where member_id = 'C107';
select* from members;

-- Task 3:  Delete the record with issued_id = 'IS121' from the issued_status table.
delete from issue_status
where issued_id = 'IS121';
select* from issue_status;

-- Task 4:  Select all books issued by the employee with emp_id = 'E101'.
select * from employees
where emp_id = 'E101';


-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
select
issued_emp_id,
count(issued_emp_id) as total_book_issued  
from issue_status
group by  issued_emp_id
having count(issued_emp_id) > 1;

-- CTAS- CREATE TABLE AS SELECT
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt*

create table book_counts
as
select 
b.isbn,
b.book_title,
count(ist.issued_id) as no_issued
from books as b
join 
issue_status as ist
on ist.issued_book_isbn = b.isbn
group by 1, 2;

select * 
from book_counts;

-- Task 7. Retrieve All Books in a Specific Category:
select * from books
where category = 'history';

-- Task 8: Find Total Rental Income by Category
select 
b.category,
sum(b.rental_price) total_rental_income,
count(*)
from books as b 
join 
issue_status as ist
on ist.issued_book_isbn = b.isbn
group by 1 ;


-- Task 9: List Members Who Registered in the Last 180 Days:
select *
from members
where datediff (curdate() , reg_date) <= 180;


-- Task 10: List Employees with Their Branch Manager's Name and their branch details
select 
e1.*,
b.branch_id,
e2.emp_name as manager
from employees as e1
join 
branch as b
on b.branch_id = e1.branch_id
join employees as e2
on b.manager_id= e2.emp_id;


-- Task 11: Retrieve the List of Books Not Yet Returned
select 
ist.issued_id,
ist.issued_book_name
from issue_status as ist
left join 
return_status as rst
on rst.issued_id = ist.issued_id
where rst.return_date is null;


-- Task 12. Create a Table of Books with Rental Price Above a Certain Threshold of 5.
create table expensive_books
as 
select * 
from books
where rental_price >= 7;