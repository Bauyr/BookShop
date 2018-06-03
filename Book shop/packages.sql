CREATE OR REPLACE PACKAGE bookshoppack AS 
   PROCEDURE showallbooks; 
   PROCEDURE showallcustomers; 
   PROCEDURE showallorders;
   
   procedure addnewbook(titlee in varchar, auth in varchar, yoe in number, pricee in number);
   procedure updatebook(upbook in number,titlee in varchar, auth in varchar, pricee in number);
   PROCEDURE deletebook(delbookid in number);
END bookshoppack; 
/

CREATE OR REPLACE PACKAGE BODY  bookshoppack AS 
   PROCEDURE showallbooks is
        CURSOR showallbookss is SELECT * FROM books; 
        showallbooks_rec showallbookss%rowtype; 
   BEGIN
        OPEN showallbookss; 
        LOOP 
            FETCH showallbookss into showallbooks_rec; 
            EXIT WHEN showallbookss%notfound; 
            DBMS_OUTPUT.put_line(showallbooks_rec.id || ' ' || showallbooks_rec.title); 
        END LOOP; 
        CLOSE showallbookss; 
   END showallbooks;
   
   PROCEDURE showallcustomers is
        CURSOR showallcus is SELECT * FROM CUSTOMERS; 
        showallbooks_rec showallcus%rowtype; 
   BEGIN
        OPEN showallcus; 
        LOOP 
            FETCH showallcus into showallbooks_rec; 
            EXIT WHEN showallcus%notfound; 
            DBMS_OUTPUT.put_line(showallbooks_rec.name || ' ' || showallbooks_rec.surname  || ' --- ' || showallbooks_rec.phone_number); 
        END LOOP; 
        CLOSE showallcus; 
   END showallcustomers;
   
   PROCEDURE showallorders is
        fname varchar(50); 
        booktitle varchar(50); 
        price number; 
        CURSOR basketing is SELECT (select name || ' ' || surname as fullname from CUSTOMERS where id = baskets.CUSTOMER_ID), books.title, books.price FROM baskets inner join books on baskets.book_id = books.id; 
   BEGIN 
       OPEN basketing; 
       LOOP 
       FETCH basketing into fname, booktitle, price; 
          EXIT WHEN basketing%notfound; 
          dbms_output.put_line(fname || ' has ordered book with title "' || booktitle || '" and price of ' || price || 'tg'); 
       END LOOP; 
       CLOSE basketing; 
    END showallorders;
    
    
   procedure addnewbook(titlee in varchar, auth in varchar, yoe in number, pricee in number) IS
   
   BEGIN
        insert into books(title,AUTHOR,YEAR_OF_EDITION,PRICE) values(titlee,auth, yoe, pricee);
        if sql%found then
            DBMS_OUTPUT.PUT_LINE('Succesfully added you book! Details:(' || titlee || ','|| auth ||')!');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Error while adding you book!!');
        end if;
   END addnewbook;
   
   procedure  updatebook(upbook in number,titlee in varchar, auth in varchar, pricee in number) IS
   BEGIN
        update books set title = titlee, author = auth, price = pricee where id = upbook;
        if sql%found then
            DBMS_OUTPUT.PUT_LINE('Succesfully updated you book!');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Error while updating you book!!');
        end if;
   END updatebook;
   
   procedure deletebook(delbookid in number) IS
   BEGIN
        DELETE FROM BOOKS WHERE id = delbookid;
        if sql%found then
            DBMS_OUTPUT.PUT_LINE('Succesfully deleted you book!');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Error while deleting you book!!');
        end if;
   END deletebook;
END bookshoppack; 
/

DECLARE
BEGIN
    bookshoppack.showallbooks;
    DBMS_OUTPUT.PUT_LINE('------------------------------');
    bookshoppack.showallcustomers; 
    DBMS_OUTPUT.PUT_LINE('------------------------------');
    bookshoppack.showallorders;
END;