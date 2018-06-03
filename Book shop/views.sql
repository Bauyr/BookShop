/* VIEWS */
create or replace view baskets_view as
    select c.id customer_id,count(*) as book_count,sum(b.price) as total_price from baskets bas
        inner join customers c on c.id=bas.CUSTOMER_ID
        inner join books b on b.id=bas.book_id
        where b.status=2
        group by c.id ;
        
SELECT * FROM BASKETS_VIEW;