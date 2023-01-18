-- процедура, що виводить загальну кількість смертей в країні
DROP PROCEDURE IF EXISTS get_total_deaths(varchar);
CREATE OR REPLACE PROCEDURE get_total_deaths(country_arg varchar(250))
LANGUAGE 'plpgsql'
AS $$
DECLARE country country.country%TYPE;
DECLARE number_of_d  death.number_of_deaths%TYPE;

BEGIN
    SELECT country.country, sum(death.number_of_deaths) INTO country, number_of_d FROM death
	JOIN place ON death.place_id=place.place_id
	JOIN country ON place.country_id=country.country_id
	WHERE country.country = country_arg
	GROUP BY country.country;
    RAISE INFO 'Total number of deaths in % is %', TRIM(country), number_of_d;
END;
$$;

CALL get_total_deaths('USA');