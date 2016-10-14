CREATE OR REPLACE PROCEDURE change_manager(current_manager_id NUMBER,
                                            new_manager_id  NUMBER) AS

cursor manager_tab_cur is
select table_name
from user_tab_columns
where column_name = 'MANAGER_ID'
and table_name not in (select view_name from user_views);

rec_count	number := 0;
ref_count	number := 0;



BEGIN

   -- Print out the tables which will be updated

   DBMS_OUTPUT.PUT_LINE('Tables referencing the selected MANAGER ID#:' || current_manager_id);

   FOR manager_rec IN manager_tab_cur LOOP
      EXECUTE IMMEDIATE 'select count(*) total ' ||
                        'from ' || manager_rec.table_name ||
			' where manager_id = :manager_id_num'
      INTO rec_count
      USING current_manager_id;

      if rec_count > 0 then
	 DBMS_OUTPUT.PUT_LINE(manager_rec.table_name || ': ' || rec_count);
     	 ref_count := ref_count + 1;
      end if;

      rec_count := 0;

   END LOOP;

   if ref_count > 0 then
      DBMS_OUTPUT.PUT_LINE('Manager is referenced in ' || ref_count || ' tables.');
      DBMS_OUTPUT.PUT_LINE('...Now Changing the Manager Identifier...');
   end if;

   -- Perform the actual table updates

   FOR manager_rec IN manager_tab_cur LOOP
      EXECUTE IMMEDIATE 'select count(*) total ' ||
                        'from ' || manager_rec.table_name ||
			' where manager_id = :manager_id_num'
      INTO rec_count
      USING current_manager_id;

      if rec_count > 0 then
	 
         EXECUTE IMMEDIATE 'update ' || manager_rec.table_name || ' ' ||
			   'set manager_id = :new_manager_id ' ||
			   'where equipment = :old_manager_id'
         USING new_manager_id, current_manager_id;

      end if;

      rec_count := 0;

   END LOOP;

   -- Print out the tables which still reference the manager number.

   FOR manager_rec IN manager_tab_cur LOOP
      EXECUTE IMMEDIATE 'select count(*) total ' ||
                        'from ' || manager_rec.table_name ||
			' where manager_id = :manager_id_numr'
      INTO rec_count
      USING current_manager_id;

      if rec_count > 0 then
	 DBMS_OUTPUT.PUT_LINE(manager_rec.table_name || ': ' || rec_count);
     	 ref_count := ref_count + 1;
      end if;

      rec_count := 0;

   END LOOP;

   if ref_count > 0 then
      DBMS_OUTPUT.PUT_LINE('Manager #: ' || current_manager_id || ' is now referenced in ' ||
                       ref_count || ' tables.');
      DBMS_OUTPUT.PUT_LINE('...There should be no tables listed above...');
   end if;

end;
/