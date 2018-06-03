CREATE SEQUENCE books_sequence;

CREATE OR REPLACE TRIGGER book_on_insert
  BEFORE INSERT ON books
  FOR EACH ROW
BEGIN
  SELECT books_sequence.nextval
  INTO :new.id
  FROM dual;
END;
CREATE SEQUENCE seq_orders;
CREATE SEQUENCE cus_sequence;

CREATE OR REPLACE TRIGGER cus_on_insert
  BEFORE INSERT ON customers
  FOR EACH ROW
BEGIN
  SELECT cus_sequence.nextval
  INTO :new.id
  FROM dual;
END;


CREATE SEQUENCE couriers_sequence;

CREATE OR REPLACE TRIGGER couriers_on_insert
  BEFORE INSERT ON couriers
  FOR EACH ROW
BEGIN
  SELECT couriers_sequence.nextval
  INTO :new.id
  FROM dual;
END;

/* Trigger after insert*/

create or replace  trigger baskets_after_insert
after insert 
    on baskets
    for each row
declare
begin
    update books set status=2 where id=:new.book_id;
end;

create or replace  trigger baskets_after_delete
after delete 
    on baskets
    for each row
declare
begin
    update books set status=1 where id=:old.book_id;
end;
