-- знаходить всі смерті в країнах за певний рік
DROP FUNCTION IF EXISTS get_number_of_deaths_in_year(user_year integer);
CREATE OR REPLACE FUNCTION get_number_of_deaths_in_year(user_year integer)
    RETURNS TABLE (number_of_deaths integer, country text)
    LANGUAGE 'plpgsql'
AS $$
#variable_conflict use_column
BEGIN 
    RETURN QUERY
		SELECT sum(number_of_deaths)::INTEGER as deaths_in_year, country::TEXT
		FROM death INNER JOIN time ON death.time_id=time.time_id
		JOIN place ON death.place_id=place.place_id
		JOIN country ON place.country_id=country.country_id
		WHERE extract(year from time.date) = user_year
		GROUP BY country
		ORDER BY deaths_in_year DESC;
END;
$$; 

SELECT * FROM get_number_of_deaths_in_year(2018);