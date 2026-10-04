-- my database
create database library_system
go 
use library_system
go

------------------
-- roles table
------------------
create table roles
(
role_id int primary key identity(1,1),
role_name nvarchar(20) not null unique
)

-- insert data
insert into roles(role_name)
values('Admin'),('Customer')

------------------
--user table
------------------
create table users(
user_id int primary key identity(1,1),
full_name nvarchar(50) not null,
email nvarchar(50) not null unique ,
phone_number nvarchar(20) unique,
role_id int not null,
pass_hash nvarchar(max),
constraint fk_user_role
foreign key (role_id)
references roles(role_id)  
)


------------------
--author table
------------------
create table author(
author_id int primary key identity(1,1),
author_name nvarchar(50) not null,
author_description nvarchar(max),
author_birthday date
)

------------------
--book table
------------------

create table book(
book_id int primary key identity(1,1),
book_ISBN nvarchar(50) not null unique,
book_name nvarchar(100) not null,
book_description nvarchar(max),
price decimal (8,2) check(price >0) not null,
stock_quantity int check(stock_quantity>=0)
)

------------------
-- Category table
------------------

create table category(
category_id int primary key identity(1,1),
category_name nvarchar(50) unique not null,
category_description nvarchar(max)
)

------------------
-- cart table
------------------

create table cart(
cart_id int primary key identity(1,1),
user_id int unique not null,
constraint fk_user_cart foreign key (user_id)
references users(user_id)
)

------------------
-- cart item table
------------------

create table cart_item(
cartitem_id int primary key identity(1,1),
cart_id int not null,
book_id int not null,
quantity int not null check(quantity>0),
constraint fk_cart_item foreign key (cart_id)
references cart(cart_id),
constraint fk_cart_item_book foreign key (book_id)
references book(book_id),
constraint uq_cart_item unique(cart_id,book_id)
)


------------------
-- Order table
------------------

create table orders(
order_id int primary key identity(1,1),
user_id int not null,
order_date datetime2 default getdate(),
total_amount decimal(8,2) not null check(total_amount>0),
constraint fk_user_order foreign key (user_id)
references users(user_id)
)

------------------
-- Orders item table
------------------

create table order_item
(
order_item_id int primary key identity(1,1),
order_id int not null,
book_id int not null,
quantity int not null check(quantity>0),
unit_price decimal(8,2) not null check(unit_price>0),
constraint fk_order_item_id foreign key (order_id)
references orders(order_id),
constraint fk_book_order_item foreign key (book_id)
references book(book_id),
constraint uq_order_book unique(order_id,book_id)
)


------------------
--Book Category table
------------------

create table book_category(
book_id int,
category_id int,
constraint pk_book_category_id primary key(book_id,category_id),
constraint fk_book_id_category foreign key (book_id)
references book(book_id),
constraint fk_category_id foreign key (category_id )
references category(category_id)
)

------------------
--Book Author table
------------------
create table book_author(
book_id int,
author_id int,
constraint pk_book_author_id primary key(book_id,author_id),
constraint fk_book_author_id foreign key (book_id)
references book(book_id),
constraint fk_author_id foreign key (author_id )
references author(author_id)
)


------------------
-- Users
------------------

INSERT INTO users
(full_name, email, phone_number, role_id, pass_hash)
VALUES
(N'Ahmed Ali',     N'ahmed@gmail.com',     N'0799000001', 1, N'dummy_hash_admin'),
(N'Mohammad Omar', N'mohammad@gmail.com',  N'0799000002', 2, N'dummy_hash_001'),
(N'Sara Khaled',   N'sara@gmail.com',      N'0799000003', 2, N'dummy_hash_002'),
(N'Omar Hassan',   N'omar@gmail.com',      N'0799000004', 2, N'dummy_hash_003'),
(N'Lina Ahmad',    N'lina@gmail.com',      N'0799000005', 2, N'dummy_hash_004'),
(N'Yousef Sami',   N'yousef@gmail.com',    N'0799000006', 2, N'dummy_hash_005');


------------------
-- Authors
------------------

INSERT INTO author
(author_name, author_description, author_birthday)
VALUES
(N'George Orwell',
 N'English novelist and essayist.',
 '1903-06-25'),

(N'J.K. Rowling',
 N'British author best known for the Harry Potter series.',
 '1965-07-31'),

(N'Robert C. Martin',
 N'American software engineer and author.',
 '1952-12-05'),

(N'Yuval Noah Harari',
 N'Historian and author known for books about human history.',
 '1976-02-24'),

(N'Agatha Christie',
 N'British writer famous for detective and mystery novels.',
 '1890-09-15'),

(N'Stephen Hawking',
 N'English theoretical physicist and science author.',
 '1942-01-08'),

(N'F. Scott Fitzgerald',
 N'American novelist and short story writer.',
 '1896-09-24'),

(N'Homer',
 N'Ancient Greek poet traditionally associated with epic poetry.',
 NULL);


------------------
-- Books
------------------

INSERT INTO book
(book_ISBN, book_name, book_description, price, stock_quantity)
VALUES
(N'9780451524935',
 N'1984',
 N'A dystopian novel about surveillance and government control.',
 12.99, 15),

(N'9780439708180',
 N'Harry Potter and the Sorcerer''s Stone',
 N'The first novel in the Harry Potter fantasy series.',
 15.50, 20),

(N'9780132350884',
 N'Clean Code',
 N'A practical guide to writing clean and maintainable software.',
 35.99, 10),

(N'9780062316097',
 N'Sapiens',
 N'A brief history of humankind.',
 22.75, 12),

(N'9780062073484',
 N'And Then There Were None',
 N'A mystery novel about ten strangers on an isolated island.',
 14.25, 8),

(N'9780553380163',
 N'A Brief History of Time',
 N'An introduction to cosmology and the mysteries of the universe.',
 18.99, 7),

(N'9780743273565',
 N'The Great Gatsby',
 N'A classic novel about wealth, love, and the American dream.',
 11.50, 18),

(N'9780140449136',
 N'The Odyssey',
 N'An ancient Greek epic poem traditionally attributed to Homer.',
 16.80, 9);


------------------
-- Categories
------------------

INSERT INTO category
(category_name, category_description)
VALUES
(N'Fiction',
 N'Novels and fictional stories.'),

(N'Fantasy',
 N'Fantasy and magical stories.'),

(N'Science',
 N'Books related to science.'),

(N'History',
 N'Historical books and studies.'),

(N'Programming',
 N'Software development and programming.'),

(N'Mystery',
 N'Detective and mystery novels.'),

(N'Classic',
 N'Classic and influential literary works.');


------------------
-- Book Categories
------------------

INSERT INTO book_category
(book_id, category_id)
VALUES
-- 1984
(1, 1),
(1, 7),

-- Harry Potter
(2, 1),
(2, 2),

-- Clean Code
(3, 5),

-- Sapiens
(4, 3),
(4, 4),

-- And Then There Were None
(5, 1),
(5, 6),

-- A Brief History of Time
(6, 3),

-- The Great Gatsby
(7, 1),
(7, 7),

-- The Odyssey
(8, 1),
(8, 7);


------------------
-- Book Authors
------------------

INSERT INTO book_author
(book_id, author_id)
VALUES
(1, 1), -- 1984 -> George Orwell
(2, 2), -- Harry Potter -> J.K. Rowling
(3, 3), -- Clean Code -> Robert C. Martin
(4, 4), -- Sapiens -> Yuval Noah Harari
(5, 5), -- And Then There Were None -> Agatha Christie
(6, 6), -- A Brief History of Time -> Stephen Hawking
(7, 7), -- The Great Gatsby -> F. Scott Fitzgerald
(8, 8); -- The Odyssey -> Homer


------------------
-- Carts
------------------

INSERT INTO cart(user_id)
VALUES
(2),
(3),
(4),
(5),
(6);


------------------
-- Cart Items
------------------

INSERT INTO cart_item
(cart_id, book_id, quantity)
VALUES
-- Mohammad's cart
(1, 1, 2),
(1, 3, 1),

-- Sara's cart
(2, 2, 1),
(2, 5, 2),

-- Omar's cart
(3, 4, 1),
(3, 6, 1),

-- Lina's cart
(4, 7, 2),

-- Yousef's cart
(5, 8, 1);


------------------
-- Orders
------------------

INSERT INTO orders
(user_id, order_date, total_amount)
VALUES
(2, '2026-09-20 10:30:00', 61.97),
(3, '2026-09-21 14:15:00', 44.00),
(4, '2026-09-23 18:45:00', 41.74),
(5, '2026-09-25 11:20:00', 23.00),
(6, '2026-09-27 16:10:00', 52.79);


------------------
-- Order Items
------------------

INSERT INTO order_item
(order_id, book_id, quantity, unit_price)
VALUES

-- Order 1
(1, 1, 2, 12.99),
(1, 3, 1, 35.99),

-- Order 2
(2, 2, 1, 15.50),
(2, 5, 2, 14.25),

-- Order 3
(3, 4, 1, 22.75),
(3, 6, 1, 18.99),

-- Order 4
(4, 7, 2, 11.50),

-- Order 5
(5, 3, 1, 35.99),
(5, 8, 1, 16.80);




-----------
--select
-----------

--1.Display all books with:
--Book name
--Price
--Stock quantity
select book_name,price,stock_quantity from book

--2.Display books with a price greater than 15.
select * from book
where price > 15

--3.Display books with stock less than 10.
select * from book
where stock_quantity< 10

--4.Display all Customers only, excluding Admins.
select * from users u
join roles r on r.role_id = u.role_id 
where r.role_name= 'Customer' 

--5.Display all books ordered from most expensive to cheapest.
select * from book 
order by price desc 

--6.Display each book with its Author’s name.
select b.book_name, a.author_name from book_author ba
join book b on b.book_id = ba.book_id
join author a on a.author_id = ba.author_id

--7.Display each book with its Categories.
select b.book_name,c.category_name from book_category bc
join book b on b.book_id = bc.book_id
join category c on c.category_id = bc.category_id 

--8.Display all books that belong to the Programming category.
select b.book_name,c.category_name from book_category bc
join book b on b.book_id = bc.book_id
join category c on c.category_id = bc.category_id
where b.book_name = 'Programming'

--9.Display all books written by George Orwell.
select b.book_name from book_author ba
join book b on b.book_id = ba.book_id
join author a on a.author_id = ba.author_id
where a.author_name = 'George Orwell'

--10.Display the contents of the Cart belonging to Customer with user_id = 2.
select b.book_name,b.price,ct.quantity from cart_item ct
join cart c on c.cart_id = ct.cart_id 
join book b on b.book_id = ct.book_id
where c.user_id=2 

--11.Calculate the total value of the Cart for Customer 2.
select sum(b.price * ct.quantity) as total_price from cart_item ct
join cart c on c.cart_id = ct.cart_id 
join book b on b.book_id = ct.book_id
where c.user_id=2 

--12.Display all Customers who have books in their Cart.
select DISTINCT u.full_name from cart c
join users u on u.user_id = c.user_id
join cart_item ci on ci.cart_id = c.cart_id


--13.Display the Purchase History for Customer 2.
select order_id,order_date,total_amount from orders
where user_id = 2

--14.Display the details of Order ID = 1.
select b.book_name,oi.quantity,oi.unit_price, oi.quantity * oi.unit_price as subtotal  from order_item oi
join book b on b.book_id = oi.book_id
where oi.order_id = 1

--15.Display all Orders with the name of the Customer who placed each order.
select o.order_id,u.full_name,o.order_date,o.total_amount from orders o
join users u on u.user_id = o.user_id

--16.Display the best-selling books based on their total quantity sold.
select b.book_name,sum(oi.quantity) as 'Total quantity sold'from order_item oi
join book b on b.book_id = oi.book_id
group by b.book_name 
order by sum(oi.quantity) desc

--17.Calculate the total sales across all Orders.
select sum(total_amount) as total_sales from orders

--18.Calculate the total sales for each Customer.
select u.full_name,sum(o.total_amount)  as 'total sales for each Customer' from orders o
join users u on u.user_id = o.user_id
group by  u.full_name

--19.Display books that have never been sold.
select  b.book_id,b.book_name from book b
left join order_item oi on b.book_id = oi.book_id
where oi.quantity is null

--20.Display books that have never been added to any Cart
select * from book b 
left join cart_item c on b.book_id = c.book_id
where c.book_id is null

--Display books where the current stock quantity is 
--less than the total quantity of that book currently in all Carts.

SELECT 
    b.book_id,
    b.book_name,
    b.stock_quantity,
    SUM(ci.quantity) AS total_cart_quantity
FROM book b
JOIN cart_item ci 
    ON b.book_id = ci.book_id
GROUP BY 
    b.book_id,
    b.book_name,
    b.stock_quantity
HAVING b.stock_quantity < SUM(ci.quantity);


