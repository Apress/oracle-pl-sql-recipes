BEGIN
  utconfig.setfiledir('FILE_SYSTEM');
  -- Causes output to be redirected to file system
  utconfig.setreporter('File');
  utPLSQL.test('calc_quarter_hour');
  -- Closes the fle
  utfilereporter.close();
  -- Returns output redirection to DBMS_OUTPUT
  utconfig.setreporter('Output');
END;
/