/* Cursors */
set SERVEROUTPUT ON;
DECLARE 
   fname varchar(50); 
   booktitle varchar(50); 
   price number; 
   CURSOR basketing is 
      SELECT (select name || ' ' || surname as fullname from CUSTOMERS where id = baskets.CUSTOMER_ID), books.title, books.price FROM baskets inner join books on baskets.book_id = books.id; 
BEGIN 
   OPEN basketing; 
   LOOP 
   FETCH basketing into fname, booktitle, price; 
      EXIT WHEN basketing%notfound; 
      dbms_output.put_line(fname || ' has ordered book with title "' || booktitle || ' and price of ' || price || 'tg'); 
   END LOOP; 
   CLOSE basketing; 
END; 
/

