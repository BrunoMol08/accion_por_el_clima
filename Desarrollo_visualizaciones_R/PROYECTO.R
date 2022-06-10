### Autor: Bruno Molina Zacatenco
## CU: 000187228

### Código que genera todas las visualizaciones necesarias para el proyecto

### Librerías importadas
library(ggplot2)
library(dplyr)
library(leaflet)
library(leaflet.extras)
library(gridExtra)
library(plotly)
library(htmlwidgets)
library(usmap)
library(scales)
library(sf)
library(raster)
library(stringr)

### Limpieza de datos

df <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/pollution_us_2000_2016.csv')
df_1 <- subset(df, select = c(2,6,9,11,16,21))

colnames(df_1) <- c('fips','full','date','CO','NO2','O3')

vect <- list()
for(i in 1:nrow(df_1)) {
  row <- df_1[i,3]
  x <- substr(row,1,4)
  vect[i] <- strtoi(x)
}

df_1$year <- vect

df_2 <- subset(df_1, select = c(1,2,7,6,5,4))
head(df_2)

df_2 <- apply(df_2,2,as.character)

write.csv(df_2,"/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/pollution_us_2000_2016_reduced.csv",row.names = FALSE)

### Datos provenientes de limpiezas externas

## Carga de los dataframes
# Canada
df_co_canada <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_annual_co_canada.csv')
df_no2_canada <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_annual_no2_canada.csv')
df_o3_canada <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_annual_o3_canada.csv')

# China
df_china_dataset <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_china_dataset.csv')

# USA
df_co_us <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/us_pollution_CO.csv')
df_no2_us <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/us_pollution_NO2.csv')
df_o3_us <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/us_pollution_O3.csv')

# India
df_india_dataset <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_india_dataset.csv')

# Germany
df_co_germany <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_germany_carbon_monoxide.csv')
df_no2_germany <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_germany_nitrogen_dioxide.csv')
df_so2_germany <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/dataframes/df_germany_sulphur_dioxide.csv')

#Paises màs contaminantes y su huella ecológica
df_foot <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/Footprint_pcap_tonnes_with_melt.csv')

# Emisiones de CO2 desde 1960 al 2018
df_co2_emissions <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/CO2_Emissions_1960-2018.csv')

#### Visualizaciones Canada

### CO

## Dividimos por años

#2015
df_co_canada_2015 <- df_co_canada %>% filter(Year == 2015)

co_canada_2015 <- df_co_canada_2015 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_co_canada_2015$lon, lat = df_co_canada_2015$lat, intensity = df_co_canada_2015$co*100, blur = 40, max = 0.05, radius = 20)

#2016
df_co_canada_2016 <- df_co_canada %>% filter(Year == 2016)

co_canada_2016 <- df_co_canada_2016 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_co_canada_2016$lon, lat = df_co_canada_2016$lat, intensity = df_co_canada_2016$co*100, blur = 40, max = 0.05, radius = 20)

#2017
df_co_canada_2017 <- df_co_canada %>% filter(Year == 2017)

co_canada_2017 <- df_co_canada_2017 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_co_canada_2017$lon, lat = df_co_canada_2017$lat, intensity = df_co_canada_2017$co*100, blur = 40, max = 0.05, radius = 20)

#2018
df_co_canada_2018 <- df_co_canada %>% filter(Year == 2018)

co_canada_2018 <- df_co_canada_2018 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_co_canada_2018$lon, lat = df_co_canada_2018$lat, intensity = df_co_canada_2018$co*100, blur = 40, max = 0.05, radius = 20)

#2019
df_co_canada_2019 <- df_co_canada %>% filter(Year == 2019)

co_canada_2019 <- df_co_canada_2019 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_co_canada_2019$lon, lat = df_co_canada_2019$lat, intensity = df_co_canada_2019$co*100, blur = 40, max = 0.05, radius = 20)

#2020
df_co_canada_2020 <- df_co_canada %>% filter(Year == 2020)

co_canada_2020 <- df_co_canada_2020 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_co_canada_2020$lon, lat = df_co_canada_2020$lat, intensity = df_co_canada_2020$co*100, blur = 40, max = 0.05, radius = 20)

co_canada_2015
co_canada_2016
co_canada_2017
co_canada_2018
co_canada_2019
co_canada_2020

### NO2

#2015
df_no2_canada_2015 <- df_no2_canada %>% filter(Year == 2015)

no2_canada_2015 <- df_no2_canada_2015 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_no2_canada_2015$lon, lat = df_no2_canada_2015$lat, intensity = df_no2_canada_2015$no2*100, blur = 40, max = 0.05, radius = 20)

#2016
df_no2_canada_2016 <- df_no2_canada %>% filter(Year == 2016)

no2_canada_2016 <- df_no2_canada_2016 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_no2_canada_2016$lon, lat = df_no2_canada_2016$lat, intensity = df_no2_canada_2016$no2*100, blur = 40, max = 0.05, radius = 20)

#2017
df_no2_canada_2017 <- df_no2_canada %>% filter(Year == 2017)

no2_canada_2017 <- df_no2_canada_2017 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_no2_canada_2017$lon, lat = df_no2_canada_2017$lat, intensity = df_no2_canada_2017$no2*100, blur = 40, max = 0.05, radius = 20)

#2018
df_no2_canada_2018 <- df_no2_canada %>% filter(Year == 2018)

no2_canada_2018 <- df_no2_canada_2018 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_no2_canada_2018$lon, lat = df_no2_canada_2018$lat, intensity = df_no2_canada_2018$no2*100, blur = 40, max = 0.05, radius = 20)

#2019
df_no2_canada_2019 <- df_no2_canada %>% filter(Year == 2019)

no2_canada_2019 <- df_no2_canada_2019 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_no2_canada_2019$lon, lat = df_no2_canada_2019$lat, intensity = df_no2_canada_2019$no2*100, blur = 40, max = 0.05, radius = 20)

#2020
df_no2_canada_2020 <- df_no2_canada %>% filter(Year == 2020)

no2_canada_2020 <- df_no2_canada_2020 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_no2_canada_2020$lon, lat = df_no2_canada_2020$lat, intensity = df_no2_canada_2020$no2*100, blur = 40, max = 0.05, radius = 20)

no2_canada_2015
no2_canada_2016
no2_canada_2017
no2_canada_2018
no2_canada_2019
no2_canada_2020

### o3

#2015
df_o3_canada_2015 <- df_o3_canada %>% filter(Year == 2015)

o3_canada_2015 <- df_o3_canada_2015 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_o3_canada_2015$lon, lat = df_o3_canada_2015$lat, intensity = df_o3_canada_2015$o3*100, blur = 40, max = 0.05, radius = 20)

#2016
df_o3_canada_2016 <- df_o3_canada %>% filter(Year == 2016)

o3_canada_2016 <- df_o3_canada_2016 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_o3_canada_2016$lon, lat = df_o3_canada_2016$lat, intensity = df_o3_canada_2016$o3*100, blur = 40, max = 0.05, radius = 20)

#2017
df_o3_canada_2017 <- df_o3_canada %>% filter(Year == 2017)

o3_canada_2017 <- df_o3_canada_2017 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_o3_canada_2017$lon, lat = df_o3_canada_2017$lat, intensity = df_o3_canada_2017$o3*100, blur = 40, max = 0.05, radius = 20)

#2018
df_o3_canada_2018 <- df_o3_canada %>% filter(Year == 2018)

o3_canada_2018 <- df_o3_canada_2018 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_o3_canada_2018$lon, lat = df_o3_canada_2018$lat, intensity = df_o3_canada_2018$o3*100, blur = 40, max = 0.05, radius = 20)

#2019
df_o3_canada_2019 <- df_o3_canada %>% filter(Year == 2019)

o3_canada_2019 <- df_o3_canada_2019 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_o3_canada_2019$lon, lat = df_o3_canada_2019$lat, intensity = df_o3_canada_2019$o3*100, blur = 40, max = 0.05, radius = 20)

#2020
df_o3_canada_2020 <- df_o3_canada %>% filter(Year == 2020)

o3_canada_2020 <- df_o3_canada_2020 %>%
  leaflet() %>%
  addTiles() %>%
  addHeatmap(lng = df_o3_canada_2020$lon, lat = df_o3_canada_2020$lat, intensity = df_o3_canada_2020$o3*100, blur = 40, max = 0.05, radius = 20)

o3_canada_2015
o3_canada_2016
o3_canada_2017
o3_canada_2018
o3_canada_2019
o3_canada_2020


### China

### CO
co_china <- ggplot(df_china_dataset, aes(x = year, y = co, color = station)) + geom_point(size = 4) + geom_smooth(method='loess')

### NO2
no2_china <- ggplot(df_china_dataset, aes(x = year, y = NO2, color = station)) + geom_point(size = 4) + geom_smooth(method='loess') 

### O3
o3_china <- ggplot(df_china_dataset, aes(x = year, y = O3, color = station)) + geom_point(size = 4) + geom_smooth(method='loess')

co_china
no2_china
o3_china



c1 <- ggplotly(co_china)
c2 <- ggplotly(no2_china)
c3 <- ggplotly(o3_china)

fig <- subplot(c1, c2,c3,titleY = TRUE, titleX = TRUE) %>% 
  layout(title = 'Air quality in China')

fig
saveWidget(fig,"/home/bruno/Documentos/Visualizacion_informacion/html_files/China/china_air_quality.html",selfcontained = FALSE)

### USA

## CO
df_co_us_2014 <- df_co_us %>% filter(year == 2014)
df_co_us_2015 <- df_co_us %>% filter(year == 2015)
df_co_us_2016 <- df_co_us %>% filter(year == 2016)


p1 <- plot_usmap(data = df_co_us_2014, values = "CO", color = "red") + 
  scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right")
p2 <- plot_usmap(data = df_co_us_2015, values = "CO", color = "red") + 
  scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right")
p3 <- plot_usmap(data = df_co_us_2016, values = "CO", color = "red") + 
  scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right")

co_us_14 <- ggplotly(p1) %>% layout(title = 'CO IN US (2014)')
co_us_15 <- ggplotly(p2) %>% layout(title = 'CO IN US (2015)')
co_us_16 <- ggplotly(p3) %>% layout(title = 'CO IN US (2016)')

co_us_14
co_us_15
co_us_16

## NO2
df_no2_us_2014 <- df_no2_us %>% filter(year == 2014)
df_no2_us_2015 <- df_no2_us %>% filter(year == 2015)
df_no2_us_2016 <- df_no2_us %>% filter(year == 2016)


p1 <- plot_usmap(data = df_no2_us_2014, values = "NO2", color = "red") + 
  scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right") 
p2 <- plot_usmap(data = df_no2_us_2015, values = "NO2", color = "red") + 
  scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right")
p3 <- plot_usmap(data = df_no2_us_2016, values = "NO2", color = "red") + 
  scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right")

no2_us_14 <- ggplotly(p1) %>% layout(title = 'NO2 IN US (2014)')
no2_us_15 <- ggplotly(p2) %>% layout(title = 'NO2 IN US (2015)')
no2_us_16 <- ggplotly(p3) %>% layout(title = 'NO2 IN US (2016)')

no2_us_14
no2_us_15
no2_us_16

## O3
df_o3_us_2014 <- df_o3_us %>% filter(year == 2014)
df_o3_us_2015 <- df_o3_us %>% filter(year == 2015)
df_o3_us_2016 <- df_o3_us %>% filter(year == 2016)


p1 <- plot_usmap(data = df_o3_us_2014, values = "O3", color = "red") + 
  scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right") 
p2 <- plot_usmap(data = df_o3_us_2015, values = "O3", color = "red") + 
  scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right")
p3 <- plot_usmap(data = df_o3_us_2016, values = "O3", color = "red") + 
  scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right")

o3_us_14 <- ggplotly(p1) %>% layout(title = 'O3 IN US (2014)')
o3_us_15 <- ggplotly(p2) %>% layout(title = 'O3 IN US (2015)')
o3_us_16 <- ggplotly(p3) %>% layout(title = 'O3 IN US (2016)')

o3_us_14
o3_us_15
o3_us_16

### India

## CO
co_india <- ggplot(df_india_dataset, aes(x = Year, y = CO, color = city)) + geom_point(size = 4) + geom_line()
co_india

## NO2
NO2_india <- ggplot(df_india_dataset, aes(x = Year, y = NO2, color = city)) + geom_point(size = 4) + geom_line()
NO2_india

## O3
O3_india <- ggplot(df_india_dataset, aes(x = Year, y = O3, color = city)) + geom_point(size = 4) + geom_line()
O3_india

c1 <- ggplotly(co_india) %>% layout(title = 'CO IN INDIA')
c2 <- ggplotly(NO2_india) %>% layout(title = 'NO2 IN INDIA')
c3 <- ggplotly(O3_india) %>% layout(title = 'O3 IN INDIA')

c1
c2
c3

### Alemania

# Quitamos los espacios vacíos que heredamos de sql
df_co_germany<- df_co_germany %>% mutate(across(where(is.character), str_trim))
df_no2_germany<- df_no2_germany %>% mutate(across(where(is.character), str_trim))
df_so2_germany<- df_so2_germany %>% mutate(across(where(is.character), str_trim))

# Hacemos unas sustituciones en nuestros dataframes sobre los nombres de los estados

# df_co_germany
df_co_germany$state_measuring_network[df_co_germany$state_measuring_network == "Bavaria"] <- "Bayern"
df_co_germany$state_measuring_network[df_co_germany$state_measuring_network == "Hesse"] <- "Hessen"
df_co_germany$state_measuring_network[df_co_germany$state_measuring_network == "Mecklenburg-West Pomerania"] <- "Mecklenburg-Vorpommern"
df_co_germany$state_measuring_network[df_co_germany$state_measuring_network == "Lower Saxony"] <- "Niedersachsen"
df_co_germany$state_measuring_network[df_co_germany$state_measuring_network == "North Rhine-Westphalia"] <- "Nordrhein-Westfalen"
df_co_germany$state_measuring_network[df_co_germany$state_measuring_network == "Rhineland-Palatinate"] <- "Rheinland-Pfalz"
df_co_germany$state_measuring_network[df_co_germany$state_measuring_network == "Saxony"] <- "Sachsen"
df_co_germany$state_measuring_network[df_co_germany$state_measuring_network == "Thuringia"] <- "Thüringen"

# df_no2_germany
df_no2_germany$state_measuring_network[df_no2_germany$state_measuring_network == "Bavaria"] <- "Bayern"
df_no2_germany$state_measuring_network[df_no2_germany$state_measuring_network == "Hesse"] <- "Hessen"
df_no2_germany$state_measuring_network[df_no2_germany$state_measuring_network == "Mecklenburg-West Pomerania"] <- "Mecklenburg-Vorpommern"
df_no2_germany$state_measuring_network[df_no2_germany$state_measuring_network == "Lower Saxony"] <- "Niedersachsen"
df_no2_germany$state_measuring_network[df_no2_germany$state_measuring_network == "North Rhine-Westphalia"] <- "Nordrhein-Westfalen"
df_no2_germany$state_measuring_network[df_no2_germany$state_measuring_network == "Rhineland-Palatinate"] <- "Rheinland-Pfalz"
df_no2_germany$state_measuring_network[df_no2_germany$state_measuring_network == "Saxony"] <- "Sachsen"
df_no2_germany$state_measuring_network[df_no2_germany$state_measuring_network == "Thuringia"] <- "Thüringen"

#df_so2_germany
df_so2_germany$state_measuring_network[df_so2_germany$state_measuring_network == "Bavaria"] <- "Bayern"
df_so2_germany$state_measuring_network[df_so2_germany$state_measuring_network == "Hesse"] <- "Hessen"
df_so2_germany$state_measuring_network[df_so2_germany$state_measuring_network == "Mecklenburg-West Pomerania"] <- "Mecklenburg-Vorpommern"
df_so2_germany$state_measuring_network[df_so2_germany$state_measuring_network == "Lower Saxony"] <- "Niedersachsen"
df_so2_germany$state_measuring_network[df_so2_germany$state_measuring_network == "North Rhine-Westphalia"] <- "Nordrhein-Westfalen"
df_so2_germany$state_measuring_network[df_so2_germany$state_measuring_network == "Rhineland-Palatinate"] <- "Rheinland-Pfalz"
df_so2_germany$state_measuring_network[df_so2_germany$state_measuring_network == "Saxony"] <- "Sachsen"
df_so2_germany$state_measuring_network[df_so2_germany$state_measuring_network == "Thuringia"] <- "Thüringen"

# Inicializamos nuestro mapa
germany <- 
  getData(country = "Germany", level = 1) %>%
  st_as_sf()

## CO
df_co_germany_2015 = df_co_germany %>% filter(Year == 2015)
df_co_germany_2016 = df_co_germany %>% filter(Year == 2016)
df_co_germany_2017 = df_co_germany %>% filter(Year == 2017)
df_co_germany_2018 = df_co_germany %>% filter(Year == 2018)
df_co_germany_2019 = df_co_germany %>% filter(Year == 2019)
df_co_germany_2020 = df_co_germany %>% filter(Year == 2020)

ger_co_2015 <- germany %>% left_join(df_co_germany_2015, by = c("NAME_1" = "state_measuring_network"))
ger_co_2016 <- germany %>% left_join(df_co_germany_2016, by = c("NAME_1" = "state_measuring_network"))
ger_co_2017 <- germany %>% left_join(df_co_germany_2017, by = c("NAME_1" = "state_measuring_network"))
ger_co_2018 <- germany %>% left_join(df_co_germany_2018, by = c("NAME_1" = "state_measuring_network"))
ger_co_2019 <- germany %>% left_join(df_co_germany_2019, by = c("NAME_1" = "state_measuring_network"))
ger_co_2020 <- germany %>% left_join(df_co_germany_2020, by = c("NAME_1" = "state_measuring_network"))

g1 <- ggplot(ger_co_2015) + geom_sf(aes(fill = CO)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
g2 <- ggplot(ger_co_2016) + geom_sf(aes(fill = CO)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
g3 <- ggplot(ger_co_2017) + geom_sf(aes(fill = CO)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
g4 <- ggplot(ger_co_2018) + geom_sf(aes(fill = CO)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
g5 <- ggplot(ger_co_2019) + geom_sf(aes(fill = CO)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
g6 <- ggplot(ger_co_2020) + geom_sf(aes(fill = CO)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")

g1_plo <- ggplotly(g1) %>% layout(title = 'CO IN GERMANY (2015)')
g2_plo <- ggplotly(g2) %>% layout(title = 'CO IN GERMANY (2016)')
g3_plo <- ggplotly(g3) %>% layout(title = 'CO IN GERMANY (2017)')
g4_plo <- ggplotly(g4) %>% layout(title = 'CO IN GERMANY (2018)')
g5_plo <- ggplotly(g5) %>% layout(title = 'CO IN GERMANY (2019)')
g6_plo <- ggplotly(g6) %>% layout(title = 'CO IN GERMANY (2020)')

g1_plo
g2_plo
g3_plo
g4_plo
g5_plo
g6_plo

## NO2
df_no2_germany_2015 = df_no2_germany %>% filter(Year == 2015)
df_no2_germany_2016 = df_no2_germany %>% filter(Year == 2016)
df_no2_germany_2017 = df_no2_germany %>% filter(Year == 2017)
df_no2_germany_2018 = df_no2_germany %>% filter(Year == 2018)
df_no2_germany_2019 = df_no2_germany %>% filter(Year == 2019)
df_no2_germany_2020 = df_no2_germany %>% filter(Year == 2020)

ger_no2_2015 <- germany %>% left_join(df_no2_germany_2015, by = c("NAME_1" = "state_measuring_network"))
ger_no2_2016 <- germany %>% left_join(df_no2_germany_2016, by = c("NAME_1" = "state_measuring_network"))
ger_no2_2017 <- germany %>% left_join(df_no2_germany_2017, by = c("NAME_1" = "state_measuring_network"))
ger_no2_2018 <- germany %>% left_join(df_no2_germany_2018, by = c("NAME_1" = "state_measuring_network"))
ger_no2_2019 <- germany %>% left_join(df_no2_germany_2019, by = c("NAME_1" = "state_measuring_network"))
ger_no2_2020 <- germany %>% left_join(df_no2_germany_2020, by = c("NAME_1" = "state_measuring_network"))

f1 <- ggplot(ger_no2_2015) + geom_sf(aes(fill = NO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
f2 <- ggplot(ger_no2_2016) + geom_sf(aes(fill = NO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
f3 <- ggplot(ger_no2_2017) + geom_sf(aes(fill = NO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
f4 <- ggplot(ger_no2_2018) + geom_sf(aes(fill = NO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
f5 <- ggplot(ger_no2_2019) + geom_sf(aes(fill = NO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
f6 <- ggplot(ger_no2_2020) + geom_sf(aes(fill = NO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")

f1_plo <- ggplotly(f1) %>% layout(title = 'NO2 IN GERMANY (2015)')
f2_plo <- ggplotly(f2) %>% layout(title = 'NO2 IN GERMANY (2016)')
f3_plo <- ggplotly(f3) %>% layout(title = 'NO2 IN GERMANY (2017)')
f4_plo <- ggplotly(f4) %>% layout(title = 'NO2 IN GERMANY (2018)')
f5_plo <- ggplotly(f5) %>% layout(title = 'NO2 IN GERMANY (2019)')
f6_plo <- ggplotly(f6) %>% layout(title = 'NO2 IN GERMANY (2020)')

f1_plo
f2_plo
f3_plo
f4_plo
f5_plo
f6_plo

## SO2
df_so2_germany_2015 = df_so2_germany %>% filter(Year == 2015)
df_so2_germany_2016 = df_so2_germany %>% filter(Year == 2016)
df_so2_germany_2017 = df_so2_germany %>% filter(Year == 2017)
df_so2_germany_2018 = df_so2_germany %>% filter(Year == 2018)
df_so2_germany_2019 = df_so2_germany %>% filter(Year == 2019)
df_so2_germany_2020 = df_so2_germany %>% filter(Year == 2020)

ger_so2_2015 <- germany %>% left_join(df_so2_germany_2015, by = c("NAME_1" = "state_measuring_network"))
ger_so2_2016 <- germany %>% left_join(df_so2_germany_2016, by = c("NAME_1" = "state_measuring_network"))
ger_so2_2017 <- germany %>% left_join(df_so2_germany_2017, by = c("NAME_1" = "state_measuring_network"))
ger_so2_2018 <- germany %>% left_join(df_so2_germany_2018, by = c("NAME_1" = "state_measuring_network"))
ger_so2_2019 <- germany %>% left_join(df_so2_germany_2019, by = c("NAME_1" = "state_measuring_network"))
ger_so2_2020 <- germany %>% left_join(df_so2_germany_2020, by = c("NAME_1" = "state_measuring_network"))

t1 <- ggplot(ger_so2_2015) + geom_sf(aes(fill = SO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
t2 <- ggplot(ger_so2_2016) + geom_sf(aes(fill = SO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
t3 <- ggplot(ger_so2_2017) + geom_sf(aes(fill = SO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
t4 <- ggplot(ger_so2_2018) + geom_sf(aes(fill = SO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
t5 <- ggplot(ger_so2_2019) + geom_sf(aes(fill = SO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
t6 <- ggplot(ger_so2_2020) + geom_sf(aes(fill = SO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")

t1_plo <- ggplotly(t1) %>% layout(title = 'SO2 IN GERMANY (2015)')
t2_plo <- ggplotly(t2) %>% layout(title = 'SO2 IN GERMANY (2016)')
t3_plo <- ggplotly(t3) %>% layout(title = 'SO2 IN GERMANY (2017)')
t4_plo <- ggplotly(t4) %>% layout(title = 'SO2 IN GERMANY (2018)')
t5_plo <- ggplotly(t5) %>% layout(title = 'SO2 IN GERMANY (2019)')
t6_plo <- ggplotly(t6) %>% layout(title = 'SO2 IN GERMANY (2020)')

t1_plo
t2_plo
t3_plo
t4_plo
t5_plo
t6_plo

## Paises con mayor huella ecològica
df_1 <- subset(df_foot, (country == 'China' | country == 'United States of America' | country == 'India' | country == 'Russian Federation' | country == 'Japan'
                    | country == 'Iran' | country == 'Germany' | country == 'Korea' | country == 'Saudi Arabia' | country == 'Canada')
               & (year >1999))

foot <- ggplot(df_1, aes(x = year, y = footprint, group = country, color = country)) + 
  geom_line() +
  geom_point() 

foot_plot <- ggplotly(foot) %>% layout(title = 'Ecological footprint of the 10 countries that pollute the most')
foot_plot

# Comparaciones de la emisión total de CO2 por paìses

df_co2_emissions_10 <- df_co2_emissions %>%
  filter(year %in% c('1960','1980','2000','2018')) %>%
  filter(Country.Name %in% c('Canada','China','Mexico','India','Iran, Islamic Rep.','Japan',"Korea, Dem. People's Rep.",'Russian Federation','Saudi Arabia','United States'))

co_emissions <- ggplot(df_co2_emissions_10, aes(x = year, y = CO2, group = Country.Name, color = Country.Name)) + 
                geom_line(size = 3) +
                geom_point(size = 6)
co_emissions_plot <- ggplotly(co_emissions) %>% layout(title = 'Comparison over time of CO2 emission')
co_emissions_plot