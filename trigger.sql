--тригер, що видаляє всі пробіли з назви країни
CREATE OR REPLACE FUNCTION remove_spaces() RETURNS trigger 
LANGUAGE 'plpgsql'
AS
$$
     BEGIN
          UPDATE country 
          SET country = REPLACE(country, ' ', '') WHERE country.country_id = NEW.country_id; 
		  RETURN NULL; 
     END;
$$;

CREATE TRIGGER removespaces
AFTER INSERT ON country
FOR EACH ROW EXECUTE FUNCTION remove_spaces();

