Alter table raw.us_pollution alter column "O3" type numeric using "O3"::NUMERIC;

Alter table raw.us_pollution alter column "NO2" type numeric using "NO2"::NUMERIC;

Alter table raw.us_pollution alter column "CO" type numeric using "CO"::NUMERIC;

Alter table raw.us_pollution alter column "year" type int using "year"::int;

Alter table raw.us_pollution alter column "fips" type int using "fips"::int;

\COPY (SELECT "city", "latitude" as "lat", "longitude" as "lon", "mean" as "co","Year" FROM raw.annual_co_canada ORDER BY "Year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_annual_co_canada.csv' DELIMITER ',' CSV HEADER;

\COPY (SELECT "city", "latitude" as "lat", "longitude" as "lon", "mean" as "no2","Year" FROM raw.annual_no2_canada ORDER BY "Year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_annual_no2_canada.csv' DELIMITER ',' CSV HEADER;

\COPY (SELECT "city", "latitude" as "lat", "longitude" as "lon", "mean" as "o3","Year" FROM raw.annual_o3_canada ORDER BY "Year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_annual_o3_canada.csv' DELIMITER ',' CSV HEADER;

\COPY (SELECT "station","year", avg("co")/100 as "co", avg("NO2") as "NO2", avg("O3") as "O3" FROM raw.china_dataset GROUP BY "station","year" ORDER BY "year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_china_dataset.csv' DELIMITER ',' CSV HEADER;

\COPY (SELECT "city","Year", avg("CO") as "CO", avg("NO2") as "NO2", avg("O3") as "O3" FROM raw.india_dataset GROUP BY "city","Year" ORDER BY "Year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_india_dataset.csv' DELIMITER ',' CSV HEADER;

\COPY (SELECT "state_measuring_network","Year", avg("annual_mean_value_in_mg_m3") as "CO" FROM raw.germany_carbon_monoxide GROUP BY "state_measuring_network","Year" ORDER BY "Year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_germany_carbon_monoxide.csv' DELIMITER ',' CSV HEADER;

\COPY (SELECT "state_measuring_network","Year", avg("annual_mean_value_in_mg_m3") as "NO2" FROM raw.germany_nitrogen_dioxide GROUP BY "state_measuring_network","Year" ORDER BY "Year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_germany_nitrogen_dioxide.csv' DELIMITER ',' CSV HEADER;

\COPY (SELECT "state_measuring_network","Year", avg("annual_mean_value_in_mg_m3") as "SO2" FROM raw.germany_sulphur_dioxide GROUP BY "state_measuring_network","Year" ORDER BY "Year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_germany_sulphur_dioxide.csv' DELIMITER ',' CSV HEADER;

\COPY (select "fips","full","year", avg("NO2") as "NO2" from raw.us_pollution group by "fips","full","year" order by "fips","full","year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/us_pollution_NO2.csv' DELIMITER ',' CSV HEADER;

\COPY (select "fips","full","year", avg("O3") as "O3" from raw.us_pollution group by "fips","full","year" order by "fips","full","year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/us_pollution_O3.csv' DELIMITER ',' CSV HEADER;

\COPY (select "fips","full","year", avg("CO") as "CO" from raw.us_pollution group by "fips","full","year" order by "fips","full","year" asc) TO '/home/bruno/Documentos/Visualizacion_informacion/dataframes/us_pollution_CO.csv' DELIMITER ',' CSV HEADER;
