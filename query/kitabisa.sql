CREATE TABLE Customer (
    id int NOT NULL,
    cust_name varchar(255),
    phonenumber varchar(255),
    email varchar(255),
    category int,
    PRIMARY KEY (id)
);
CREATE TABLE Product (
    id varchar(255) NOT NULL,
    prod_name varchar(255),
    prod_amount numeric,
    vendor_id int,
    PRIMARY KEY (id)
);
CREATE TABLE `Order` (
    id int NOT NULL,
    cust_id int,
    amount numeric,
    prod_id varchar(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (cust_id) REFERENCES Customer(id),
    FOREIGN KEY (prod_id) REFERENCES Product(id)
);

insert into customer (id,cust_name,phonenumber,email,category)
values (101,'ahmad', '0812000001', 'ahmad@gmail.com', 1),
(102,'budi', '0812000002', 'budi@gmail.com', 1),
(103,'indah', '0812000003', 'indah@gmail.com', 2),
(104,'rani', '0812000004', 'rani@gmail.com', 3),
(105,'putri', '0812000005', 'putri@gmail.com', 2)

insert into product (id,prod_name,prod_amount,vendor_id)
values ('A100','Sabun Mandi', 10000, 10),
('A101','Pasta gigi',20000 , 11),
('A102','Shampoo', 15000, 12),
('A103','Sabun Cuci', 15000, 13),
('A104','Pewangi', 30000, 14)

insert into `order` (id,cust_id,amount,prod_id)
values (121,101, 10000, 'A100'),
(122,101,20000 , 'A101'),
(123,103, 20000, 'A101'),
(124,102, 15000, 'A103'),
(125,103, 30000, 'A104')

-- Please select order from low price to high price with all detail
select o.amount as order_amount,o.id as order_id, o.cust_id as cust_id, c.cust_name, c.phonenumber, c.email, c.category, o.prod_id,  p.prod_name, p.prod_amount,p.vendor_id from `order` as o
left join customer as c
	on o.cust_id = c.id
left join product as p
	on o.prod_id = p.id 
order by amount asc;

-- Display the cust_name  who purchased the prod_id A101 and A103
select cust_name from customer as c
left join `order` as o
	on c.id = o.cust_id
where o.prod_id = 'A101' and o.prod_id = 'A103';

-- Display All detail in table Product purchased by Budi
select c.cust_name as customer_name ,p.id as prod_id, p.prod_name, p.prod_amount, p.vendor_id from product as p
left join `order` as o
	on p.id = o.prod_id
left join customer as c
	on o.cust_id = c.id
where c.cust_name = 'budi';