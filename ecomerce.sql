create database Ecommerce;
use Ecommerce;

/* create customer table and insert values */
create table customers (
    customer_id int auto_increment primary key,
    firstname varchar(255),
    lastname varchar(255),
    email varchar(255),
    address varchar(255)
);
insert into customers (customer_id, firstname, lastname, email, address)
values
    (1, 'John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
    (2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
    (3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
    (4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
    (5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District'),
    (6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
    (7, 'Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
    (8, 'Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
    (9, 'William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
    (10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St');
select * from customers;

/* create products table and insert values */    
    create table products (
    product_id int auto_increment primary key,
    name varchar(255),
    description varchar(255),
    price decimal(10, 2),
    stockquantity int
);
insert into products (product_id, name, description, price, stockquantity)
values
    (1, 'Laptop', 'High-performance laptop', 800.00, 10),
    (2, 'Smartphone', 'Latest smartphone', 600.00, 15),
    (3, 'Tablet', 'Portable tablet', 300.00, 20),
    (4, 'Headphones', 'Noise-canceling', 150.00, 30),
    (5, 'TV', '4K Smart TV', 900.00, 5),
    (6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
    (7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
    (8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
    (9, 'Blender', 'High-speed blender', 70.00, 20),
    (10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);
select * from products;

/* create cart table and insert values */   
create table cart (
    cart_id int auto_increment primary key,
    customer_id int,
    product_id int,
    quantity int,
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id)
);
insert into cart (cart_id, customer_id, product_id, quantity)
values
    (1, 1, 1, 2),
    (2, 1, 3, 1),
    (3, 2, 3, 4),
    (4, 3, 4, 3),
    (5, 3, 5, 2),
    (6, 4, 6, 1),
    (7, 5, 1, 1),
    (8, 6, 10, 2),
    (9, 6, 9, 3),
    (10, 7, 7, 2);
select * from cart;

/* create orders table and insert values */   
create table orders (
    order_id int auto_increment primary key,
    customer_id int,
    order_date date,
    total_price decimal(10, 2),
    foreign key (customer_id) references customers(customer_id)
);
insert into orders (order_id, customer_id, order_date, total_amount)
values
    (1, 1, '2023-01-05', 1200.00),
    (2, 2, '2023-02-10', 900.00),
    (3, 3, '2023-03-15', 300.00),
    (4, 4, '2023-04-20', 150.00),
    (5, 5, '2023-05-25', 1800.00),
    (6, 6, '2023-06-30', 400.00),
    (7, 7, '2023-07-05', 700.00),
    (8, 8, '2023-08-10', 160.00),
    (9, 9, '2023-09-15', 140.00),
    (10, 10, '2023-10-20', 1400.00);
select * from orders;

/* create order_items table and insert values */   
create table order_items (
    order_item_id int auto_increment primary key,
    order_id int,
    product_id int,
    quantity int,
    itemamount decimal(10, 2),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);
insert into order_items (order_item_id, order_id, product_id, quantity, itemamount)
values
    (1, 1, 1, 2, 1600.00),
    (2, 1, 3, 1, 300.00),
    (3, 2, 2, 3, 1800.00),
    (4, 3, 5, 2, 1800.00),
    (5, 4, 4, 4, 600.00),
    (6, 4, 6, 1, 50.00),
    (7, 5, 1, 1, 800.00),
    (8, 5, 2, 2, 1200.00),
    (9, 6, 10, 2, 240.00),
    (10, 6, 9, 3, 210.00);
 select * from order_items;


/* quries */
select * from customers;
select * from products;
select * from cart;
select * from orders;
select * from order_items;

/* 1. Update refrigerator product price to 800. */
update products set price=800.00 where name='refrigerator';
 
/*2. Remove all cart items for a specific customer.*/
update cart set quantity=0 where customer_id=2;
 
/*3. Retrieve Products Priced Below $100.*/
select name, price from products where price <100.00;
 
/*4. Find Products with Stock Quantity Greater Than 5.*/
select name,stockquantity from products where stockquantity >5;

/*5. Retrieve Orders with Total Amount Between $500 and $1000.*/
select * from orders where total_amount between 500 and 1000;

/*6. Find Products which name end with letter ‘r’.*/
select name from products where name like'%r';

/*7. Retrieve Cart Items for Customer 5.*/
select * from cart where customer_id=5;

/*8. Find Customers Who Placed Orders in 2023.*/
select  c.*
from customers c
join orders o on c.customer_id = o.customer_id
where year(o.order_date) = 2023;

/*9. Determine the Minimum Stock Quantity for Each Product Category.*/

/*10. Calculate the Total Amount Spent by Each Customer.*/
select
o.customer_id,
c.firstname,
c.lastname,
sum(oi.itemamount) as totalamountspent
from orders o
join order_items oi on o.order_id = oi.order_id
join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.firstname, c.lastname;

/*11. Calculate the average Amount Spent by Each Customer.*/
select
o.customer_id,
c.firstname,
c.lastname,
avg(oi.itemamount) as averageamountspent
from orders o
join order_items oi on o.order_id = oi.order_id
join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.firstname, c.lastname;

/*12. Count the Number of Orders Placed by Each Customer.*/
select
customer_id,
count(order_id) as numberoforders
from orders
group by customer_id;

/*13. Find the Maximum Order Amount for Each Customer.*/
select
customer_id,
max(total_amount) as maxorderamount
from orders
group by customer_id;

/*14. Get Customers Who Placed Orders Totaling Over $1000.*/
select
o.customer_id,
c.firstname,
c.lastname
from orders o
join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.firstname, c.lastname
having sum(o.total_amount) > 1000;

/*15. Subquery to Find Products Not in the Cart.*/
select *
from products
where product_id not in (select distinct product_id from cart);

/*16. Subquery to Find Customers Who Haven't Placed Orders.*/
select* from customers
where customer_id not in(select distinct customer_id from orders);

/*17. Subquery to Calculate the Percentage of Total Revenue for a Product.*/

/*18. Subquery to Find Products with Low Stock.*/
select *
from products
where stockquantity < (select avg(stockquantity) from products);

/*19. Subquery to Find Customers Who Placed High-Value Orders.*/
select customer_id, firstname, lastname
from customers
where customer_id in (
    select customer_id
    from orders
    group by customer_id
    having sum(total_amount) > 1000
);


