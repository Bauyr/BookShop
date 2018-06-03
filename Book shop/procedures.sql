/* PROCEDURE FOR ADDING TO ORDER BOOK */
create or replace procedure place_order(c_id in number)
is  
    order_id number;
    order_row baskets_view%rowtype;
begin
    order_id:=seq_orders.nextval;
    select * into order_row from baskets_view where customer_id=c_id;
    if sql%found then
        insert into book_orders(customer_id,book_count,purchase_amount) values(c_id,order_row.book_count,order_row.total_price);
        if assign_courier(order_id) = 1 then
        
            --set status of order to on the way
            update book_orders set status=2 where id=order_id;
            --set status of book to in delivery process
            update books set status=3 where id in (select book_id from BASKETS where customer_id=c_id);
            
            dbms_output.put_line('Courier assigned to your order.Please wait delivery');
        else 
            dbms_output.put_line('All couriers are busy.We will deliver your order after one of them will be freed');
        end if;
    else
        dbms_output.put_line('Do not have any books in basket to place order');
    end if;
exception
    when others then
        dbms_output.put_line('You do not have any books in basket to place order,first of all add books to your basket');
end;
/

/* PROCEDURE */
create or replace procedure finish_order(o_id in number)
is  
    cou_id number;
    c_id number;
    waiting_order book_orders%rowtype;
begin
    select customer_id,courier_id into c_id,cou_id from book_orders where id=o_id; 
    --set order status to success and assign deliver_date
    update book_orders set status=4,DELIVERY_DATE=sysdate where id =o_id;
    --set status of book to  sold
    update   books set status=4 where id in (select book_id from BASKETS where customer_id=c_id);
    
    select * into waiting_order from book_orders where status=1 and ROWNUM=1;
    if sql%found then--take another waiting order if have
        update book_orders set courier_id=cou_id where id=waiting_order.id;
    else--else rest time
        update couriers set is_busy=0 where id=cou_id;
    end if;
exception
    when NO_DATA_FOUND then
         update couriers set is_busy=0 where id=cou_id;
end;
/