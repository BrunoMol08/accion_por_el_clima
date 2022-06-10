drop schema if exists raw cascade;

create schema raw;

drop table if exists raw.annual_co_canada;

create table raw.annual_co_canada(
    NAPS_ID int,
    City char(100),
    P_T char(4),
    "Location" char(150),
    Latitude float,
    Longitude float,
    Elevation float,
    Classification char(20),
    ID char(20),
    Minimum float,
    "10th_Percentile" float,
    "30th_Percentile" float,
    "50th_Percentile" float,
    "70th_Percentile" float,
    "80th_Percentile" float,
    "90th_Percentile" float,
    "95th_Percentile" float,
    "98th_Percentile" float,
    "99th_Percentile" float,
    "99.9th_Percentile" float,
    Maximum float,
    Percent_Completeness float,
    January float,
    February float,
    March float,
    April float,
    May float,
    June float,
    July float,
    August float,
    September float,
    October float,
    November float,
    December float,
    Mean float,
    Standard_Deviation float,
    "Year" int
);

drop table if exists raw.annual_no2_canada;

create table raw.annual_no2_canada(
    NAPS_ID int,
    City char(100),
    P_T char(4),
    "Location" char(150),
    Latitude float,
    Longitude float,
    Elevation float,
    Classification char(20),
    ID char(20),
    Minimum float,
    "10th_Percentile" float,
    "30th_Percentile" float,
    "50th_Percentile" float,
    "70th_Percentile" float,
    "80th_Percentile" float,
    "90th_Percentile" float,
    "95th_Percentile" float,
    "98th_Percentile" float,
    "99th_Percentile" float,
    "99.9th_Percentile" float,
    Maximum float,
    Percent_Completeness float,
    January float,
    February float,
    March float,
    April float,
    May float,
    June float,
    July float,
    August float,
    September float,
    October float,
    November float,
    December float,
    Mean float,
    Standard_Deviation float,
    "Year" int
);

drop table if exists raw.annual_o3_canada;

create table raw.annual_o3_canada(
    NAPS_ID int,
    City char(100),
    P_T char(4),
    "Location" char(150),
    Latitude float,
    Longitude float,
    Elevation float,
    Classification char(20),
    ID char(20),
    Minimum float,
    "10th_Percentile" float,
    "30th_Percentile" float,
    "50th_Percentile" float,
    "70th_Percentile" float,
    "80th_Percentile" float,
    "90th_Percentile" float,
    "95th_Percentile" float,
    "98th_Percentile" float,
    "99th_Percentile" float,
    "99.9th_Percentile" float,
    Maximum float,
    Percent_Completeness float,
    January float,
    February float,
    March float,
    April float,
    May float,
    June float,
    July float,
    August float,
    September float,
    October float,
    November float,
    December float,
    Mean float,
    Standard_Deviation float,
    "Year" int
);

drop table if exists raw.china_dataset;

create table raw.china_dataset(
    "No" int,
    "year" int,
    "month" int,
    "day" int,
    hour int,
    "PM2.5" float,
    "PM10" float,
    "SO2" float,
    "NO2" float,
    CO int,
    "O3" float,
    TEMP float,
    PRES float,
    DEWP float,
    RAIN float,
    wd char(10),
    WSPM float,
    station char(80)
);

drop table if exists raw.india_dataset;

create table raw.india_dataset(
    City char(80),
    "Date" char(80),
    "PM2.5" float,
    "PM10" float,
    "NO" float,
    "NO2" float,
    "NOx" float,
    "NH3" float,
    "CO" float,
    "SO2" float,
    "O3" float,
    Benzene float,
    Toluene float,
    Xylene float,
    AQI int, 
    AQI_Bucket char(25),
    "Year" int
);

drop table if exists raw.germany_carbon_monoxide;

create table raw.germany_carbon_monoxide(
    State_Measuring_network char(50),
    Station_code char(15),
    Station_name char(80),
    Station_setting char(40),
    Station_type char(30),
    Annual_mean_value_in_mg_m3 float,
    Number_of_days_with_highest_daily_8_hour_averages_above_10_mg_m3 int,
    "Year" int
);

drop table if exists raw.germany_nitrogen_dioxide;

create table raw.germany_nitrogen_dioxide(
    State_Measuring_network char(50),
    Station_code char(15),
    Station_name char(80),
    Station_setting char(40),
    Station_type char(30),
    Annual_mean_value_in_mg_m3 float,
    "Year" int
);

drop table if exists raw.germany_sulphur_dioxide;

create table raw.germany_sulphur_dioxide(
    State_Measuring_network char(50),
    Station_code char(15),
    Station_name char(80),
    Station_setting char(40),
    Station_type char(30),
    Annual_mean_value_in_mg_m3 float,
    Number_of_days_with_daily_mean_values_above_125_µg_m int,
    Number_of_hourly_mean_values_above_350_µg_m3 int,
    "Year" int
);

drop table if exists raw.catalog_canada;

create table raw.catalog_canada(
    province char(50),
    p_t char(3)
);

drop table if exists raw.us_pollution;

create table raw.us_pollution (
	"fips" varchar(255),
	"full" varchar(255),
	"year" varchar(255),
	"O3" varchar(255),
	"NO2" varchar(255),
	"CO" varchar(255)
);