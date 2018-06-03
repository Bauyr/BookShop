/* CURSOR BASED RECORD */
DECLARE 
   CURSOR showallbooks is SELECT * FROM books; 
   showallbooks_rec showallbooks%rowtype; 
BEGIN 
   OPEN showallbooks; 
   LOOP 
      FETCH showallbooks into showallbooks_rec; 
      EXIT WHEN showallbooks%notfound; 
      DBMS_OUTPUT.put_line(showallbooks_rec.id || ' ' || showallbooks_rec.title); 
   END LOOP; 
END; 
/