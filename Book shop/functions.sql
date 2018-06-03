create or replace function assign_courier(o_id in number)
    return number
is
cou_row couriers%rowtype;
begin
    select * into cou_row from couriers where is_busy=0 and rownum=1;
    if sql%found then
        update book_orders set courier_id=cou_row.id where id=o_id;
        update couriers set is_busy=1 where id=cou_row.id;
        return 1;
    else
        return 0;
    end if;
exception
    when others then
        --DBMS_OUTPUT.PUT_LINE('Cannot insert it to basket');
        return 0;
end;



/* FUNCTION FOR ADDING TO BASKET and with exeption */
create or replace function add_book_to_basket(c_id in number,b_id in number)
    return number
is
begin
    insert into baskets values(c_id,b_id);
    if sql%found then
        return 1;
    end if;
exception
    when DUP_VAL_ON_INDEX then
        return 0;
end;


/* FUNCTION FOR DELETING TO BASKET*/
create or replace function delete_book_to_basket(c_id in number,b_id in number)
    return number
is
begin
    DELETE FROM baskets WHERE CUSTOMER_ID = c_id and BOOK_ID= b_id;
    if sql%found then
        return 1;
    ELSE 
        RETURN 0;
    end if;
end;

/* demonstration */
DEclare
    reportation number;
BEGIN
    reportation := add_book_to_basket(1,3);
    dbms_output.put_line('Function status: ' || reportation);
    
     --reportation := delete_book_to_basket(1,2);
     --dbms_output.put_line('Function status: ' || reportation);
END;
select * from baskets;
select * from books;
