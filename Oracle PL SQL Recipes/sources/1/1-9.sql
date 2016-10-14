<<outer_block>>
DECLARE
   mgr_id NUMBER(6) := '&current_manager_id';
   dept_count  number := 0;
BEGIN
   SELECT count(*)
   INTO dept_count
   FROM departments
   WHERE manager_id = outer_block.mgr_id;

   IF dept_count > 0 THEN
      <<inner_block>>
      DECLARE
         dept_name VARCHAR2(30);
         mgr_id  NUMBER(6):= '&new_manager_id';
      BEGIN
         SELECT department_name
         INTO dept_name
         FROM departments
         WHERE manager_id = outer_block.mgr_id;

         UPDATE departments
         SET manager_id = inner_block.mgr_id
         WHERE manager_id = outer_block.mgr_id;
            DBMS_OUTPUT.PUT_LINE
               ('Department manager ID has been changed for ' || dept_name);
         
      END inner_block;
   ELSE
      DBMS_OUTPUT.PUT_LINE('There are no departments listed for the manager');
   END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('There are no departments listed for the manager');
END outer_block;
/