#!/bin/bash

# Carga de la creación de las tablas 
psql -f /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/creation.sql service=visualizacion_informacion

# Carga de datasets 1
psql -c '\copy raw.annual_co_canada from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/Annual_CO.csv with csv header;' service=visualizacion_informacion

# Carga de datasets 2
psql -c '\copy raw.annual_no2_canada from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/Annual_NO2.csv with csv header;' service=visualizacion_informacion

# Carga de datasets 3
psql -c '\copy raw.annual_o3_canada from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/Annual_O3.csv with csv header;' service=visualizacion_informacion

# Carga de datasets 4
psql -c '\copy raw.china_dataset from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/China_dataset.csv with csv header;' service=visualizacion_informacion

# Carga de datasets 5
psql -c '\copy raw.india_dataset from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/city_day.csv with csv header;' service=visualizacion_informacion

# Carga de datasets 6
psql -c '\copy raw.germany_carbon_monoxide from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/Annual-tabulation_Carbon_monoxide.csv with csv header;' service=visualizacion_informacion

# Carga de datasets 7
psql -c '\copy raw.germany_nitrogen_dioxide from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/Annual-tabulation_Nitrogen_dioxide.csv with csv header;' service=visualizacion_informacion

# Carga de datasets 8
psql -c '\copy raw.germany_sulphur_dioxide from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/Annual-tabulation_Sulphur_dioxide.csv with csv header;' service=visualizacion_informacion

# Carga de un catalogo de estados de Canada
psql -c '\copy raw.catalog_canada from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/canada_catalog.csv with csv header;' service=visualizacion_informacion

# Carga de datasets 9
psql -c '\copy raw.us_pollution from /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/pollution_us_2000_2016_reduced.csv with csv header;' service=visualizacion_informacion

# Ejecución de la exportanción de los dataframes
psql -f /home/bruno/Documentos/Visualizacion_informacion/carga_datasets/querys_to_dfs.sql service=visualizacion_informacion
