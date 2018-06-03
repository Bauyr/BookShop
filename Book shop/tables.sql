/*Book status*/
create table book_statuses(id number primary key, name varchar(40) NOT NULL);

insert into book_statuses values(1,'available');
insert into book_statuses values(2,'in basket');
insert into book_statuses values(3,'in delivery process');
insert into book_statuses values(4,'sold');

delete from book_statuses;
select * from book_statuses;

/*Book */
create table books(id number primary key,title varchar(40) not null,author varchar(40) not null,year_of_edition number not null, price number not null,status number default 1 not null,foreign key(status) references book_statuses(id));

insert into books(title,author,year_of_edition,price) values('???? ????','?????? ??????',2000,5000);
insert into books(title,author,year_of_edition,price) values('???? ????','?????? ??????',2000,5000);
insert into books(title,author,year_of_edition,price) values('???? ????','?????? ??????',2000,5000);
insert into books(title,author,year_of_edition,price) values('???? ????','?????? ??????',2000,5000);
insert into books(title,author,year_of_edition,price) values('???? ????','?????? ??????',2000,5000);
insert into books(title,author,year_of_edition,price) values('???? ????','?????? ??????',2000,5000);
insert into books(title,author,year_of_edition,price) values('???? ????','?????? ??????',2000,5000);
insert into books(title,author,year_of_edition,price) values('???? ????','?????? ??????',2000,5000);
insert into books(title,author,year_of_edition,price) values('????? ???????','?????? ????????',1970,4500);
insert into books(title,author,year_of_edition,price) values('????? ???????','?????? ????????',1970,4500);
insert into books(title,author,year_of_edition,price) values('????? ???????','?????? ????????',1970,4500);
insert into books(title,author,year_of_edition,price) values('????? ???????','?????? ????????',1970,4500);
insert into books(title,author,year_of_edition,price) values('????? ???????','?????? ????????',1970,4500);


drop table books;
select * from books;

/* cusomers table*/

create table customers(id number primary key,name varchar(40) not null,surname varchar(40) not null,phone_number varchar(11) not null);

insert into customers(name,surname,phone_number) values('Nargiza','Kaparova','87015550575');
insert into customers(name,surname,phone_number) values('Manarbek','Malikov','87011413208');
insert into customers(name,surname,phone_number) values('Anuarbek','Zakiryanov','87079784563');
insert into customers(name,surname,phone_number) values('Perizat','Armanova','87021534200');
insert into customers(name,surname,phone_number) values('Razaria','Aibarova','87778592054');
insert into customers(name,surname,phone_number) values('Galizhan','Otemisov','87012345671');
insert into customers(name,surname,phone_number) values('Manas','Kadirgaliev','87758399126');

select * from customers;
drop table customers;

/* Basket */
create table baskets(customer_id not null,book_id not null,CONSTRAINT basket_customer foreign key(customer_id) REFERENCES customers(id), CONSTRAINT basket_book foreign key(book_id) REFERENCES books(id),CONSTRAINT basket_unique unique(book_id));


-- order status

create table order_statuses(id number primary key, name varchar(40) NOT NULL);
                            
insert into order_statuses values(1,'waiting');
insert into order_statuses values(2,'on the way');
insert into order_statuses values(3,'canceled');
insert into order_statuses values(4,'success');

select * from order_statuses;
    
    
-- couriers

create table couriers( id number primary key,  name varchar(40) not null, surname varchar(40) not null, phone_number varchar(11) not null,is_busy number default 0 not null);

insert into couriers(name,surname,phone_number) values('Lee','Jack','87011231243');
insert into couriers(name,surname,phone_number) values('Lee','Chun','87011231244');
insert into couriers(name,surname,phone_number) values('Cristiano','Ronaldo','87011231245');
insert into couriers(name,surname,phone_number) values('Sergio','Ramos','87011231246');
insert into couriers(name,surname,phone_number) values('Son','Hui','87011231247');

select * from couriers;
                 
-- book orders

create table book_orders( id number primary key,  customer_id number not null,  status number default 1 not null,  request_date timestamp default sysdate,  delivery_date TIMESTAMP, book_count number not null, purchase_amount number not null, courier_id number,constraint fk_order_statuses foreign key(status) references order_statuses(id),constraint fk_couriers foreign key(courier_id) references couriers(id));

drop table book_orders;
select * from book_orders;