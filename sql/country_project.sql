create table country_development (
	country  VARCHAR,
	child_mort FLOAT,
	exports    FLOAT,
	health     FLOAT,
	imports    FLOAT,
	income     FLOAT,
	inflation  FLOAT,
	life_expec FLOAT,
	total_fer  FLOAT,
	gdpp       FLOAT
);

/* Confirm that data has been imported successfully */
select *
from country_development limit 10;

select count(*)
from country_development;

/* Check for NULL values in data */
SELECT 
  COUNT(*) FILTER (WHERE child_mort IS NULL) AS child_mort_nulls,
  COUNT(*) FILTER (WHERE exports IS NULL) AS exports_nulls,
  COUNT(*) FILTER (WHERE health IS NULL) AS health_nulls,
  COUNT(*) FILTER (WHERE imports IS NULL) AS imports_nulls,
  COUNT(*) FILTER (WHERE income IS NULL) AS income_nulls,
  COUNT(*) FILTER (WHERE inflation IS NULL) AS inflation_nulls,
  COUNT(*) FILTER (WHERE life_expec IS NULL) AS life_expec_nulls,
  COUNT(*) FILTER (WHERE total_fer IS NULL) AS total_fer_nulls,
  COUNT(*) FILTER (WHERE gdpp IS NULL) AS gdpp_nulls
FROM country_development;

/* Check for negative or invalid values */ 
SELECT * FROM country_development
WHERE child_mort < 0 OR health < 0 OR income < 0 OR life_expec < 0 OR gdpp < 0;

/* Inspect Distribution */
SELECT 
  MIN(child_mort), MAX(child_mort), 
  MIN(income), MAX(income),
  MIN(gdpp), MAX(gdpp)
FROM country_development;

/* Normalize the Variables for Clustering*/
CREATE TABLE country_normalized AS
SELECT 
  country,
  (child_mort - AVG(child_mort) OVER()) / STDDEV(child_mort) OVER() AS child_mort,
  (exports - AVG(exports) OVER()) / STDDEV(exports) OVER() AS exports,
  (health - AVG(health) OVER()) / STDDEV(health) OVER() AS health,
  (imports - AVG(imports) OVER()) / STDDEV(imports) OVER() AS imports,
  (income - AVG(income) OVER()) / STDDEV(income) OVER() AS income,
  (inflation - AVG(inflation) OVER()) / STDDEV(inflation) OVER() AS inflation,
  (life_expec - AVG(life_expec) OVER()) / STDDEV(life_expec) OVER() AS life_expec,
  (total_fer - AVG(total_fer) OVER()) / STDDEV(total_fer) OVER() AS total_fer,
  (gdpp - AVG(gdpp) OVER()) / STDDEV(gdpp) OVER() AS gdpp
FROM country_development;


