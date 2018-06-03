DECLARE 
    TYPE c_list IS TABLE of varchar(100); 
    name_list c_list := c_list();
    
    TYPE amount_list IS TABLE of number;
    amount amount_list := amount_list(); 
    
    counter integer :=0; 
   
   cursor asd is sELECT sum(books.price)  as sumof,(select name || ' ' || surname from customers where id = BASKETS.CUSTOMER_ID) as fullname FROM baskets inner join books on baskets.book_id = books.id group by baskets.CUSTOMER_ID;
   recasd asd%rowtype;
BEGIN 

    Open asd;
    LOOP 
      FETCH asd into recasd; 
        EXIT WHEN asd%notfound; 
            counter := counter + 1;
            name_list.extend; 
            name_list(counter)  := recasd.fullname; 
            
            amount.extend; 
            amount(counter)  := recasd.sumof; 
            
            dbms_output.put_line('Customer: '||name_list(counter)|| ' /// for payment in basket: ' || amount(counter) || 'tg');
    END LOOP; 
    Close asd;
END; 
/

commit;