CREATE OR REPLACE FUNCTION mass_energy_calc (mass IN NUMBER,
                                                                                                      energy IN NUMBER)
RETURN PLS_INTEGER IS
  new_mass    PLS_INTEGER := mass;
  new_energy  PLS_INTEGER := energy;
BEGIN
  RETURN ((new_mass * new_energy) * (new_mass * new_energy));
EXCEPTION
  WHEN OTHERS THEN
    RETURN -1;
END;
/