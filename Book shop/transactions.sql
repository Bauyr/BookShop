SET AUTOCOMMIT ON;
Create or replace procedure updatebooktitleandprice(userid in number) is

Begin
    SAVEPOINT firsttt;
        update books set TITLE = 'Abai zholi', price = 10000 WHERE id = userid;
    Commit;
EXCEPTION
   WHEN no_data_found THEN 
      ROLLBACK TO firsttt;
      Dbms_output.put_line('No data is updated');
End;
/

Begin
    updatebooktitleandprice(20);
end;