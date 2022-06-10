library(shiny)
library(leaflet)
library(geosphere)
library(dplyr) # to use select
library(ggplot2)
library(leaflet.extras)
library(gridExtra)
library(plotly)
library(htmlwidgets)
library(usmap)
library(scales)
library(sf)
library(raster)
library(stringr)

### Datasets

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

#Paises màs contaminantes y su huella ecológica
df_foot <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/Footprint_pcap_tonnes_with_melt.csv')

# Emisiones de CO2 desde 1960 al 2018
df_co2_emissions <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/CO2_Emissions_1960-2018.csv')

## Países disponibles
paises <- c('Canada')
paises_plots <- c('United States','Germany')
paises_plots_2 <- c('China','India')

## Contaminantes
contaminantes <- c('CO','NO2','O3')
contaminantes_2 <- c('CO','NO2','O3','SO2')

## Años
anios <- c(2015,2016,2017,2018,2019,2020)
anios_2 <- c(2013,2014,2015,2016,2017,2018,2019,2020)
anios_3 <- c(1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,
             1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,
             1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,
             1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,
             2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,
             2011,2012,2013,2014,2015,2016,2017,2018)

ui <- fluidPage(
  navbarPage("Acción por el clima", id="Indice",
             tabPanel("Mapas de calor de Canadá",
                      mainPanel(
                        selectInput("pais", "País disponible", choices = paises),
                        selectInput("contaminante", "Contaminante a visualizar", choices = contaminantes),
                        selectInput("anio","Año a visualizar", choices = anios),
                        leafletOutput("plot")
                      )
             ),
             tabPanel("Mapas de USA y Alemania sobre contaminantes", 
                      mainPanel(
                        selectInput("pais_2do", "Países disponibles", choices = paises_plots),
                        selectInput("contaminante_2do", "Contaminante a visualizar", choices = contaminantes_2),
                        selectInput("anio_2do","Año a visualizar", choices = anios_2),
                        plotlyOutput("plot_2")
                      )
             ),
             tabPanel("Gráficas de China e India sobre contaminantes", 
                      mainPanel(
                        selectInput("pais_3ero", "Países disponibles", choices = paises_plots_2),
                        selectInput("contaminante_3ero", "Contaminante a visualizar", choices = contaminantes),
                        plotlyOutput("plot_3")
                      )
             ),
             tabPanel("Footprint", 
                      mainPanel(
                        plotlyOutput("plot_4")
                      )
             ),
             tabPanel("Comparación de emisiones de CO2", 
                      mainPanel(
                        selectInput("val1","Elige el 1er año",choices = anios_3),
                        selectInput("val2","Elige el 2do año",choices = anios_3),
                        selectInput("val3","Elige el 3er año",choices = anios_3),
                        selectInput("val4","Elige el 4to año",choices = anios_3),
                        plotlyOutput("plot_5")
                      )
             ),
             tabPanel("Reporte técnico",includeMarkdown("/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/reporte_tecnico.md")))
)

server <- function(input, output, session) {
  
  ### Elementos reactivos
  pais <- reactive({
    input$pais
  })
  
  pais_2 <- reactive({
    input$pais_2do
  })
  
  pais_3 <- reactive({
    input$pais_3ero
  })
  
  contaminante <- reactive({
    input$contaminante
  })
  
  contaminante_2 <- reactive({
    input$contaminante_2do
  })
  
  contaminante_3 <- reactive({
    input$contaminante_3ero
  })
  
  anio <- reactive({
    input$anio
  })
  
  anio_2 <- reactive({
    input$anio_2do
  })
  
  val_anio_1 <- reactive({
    input$val1
  })
  
  val_anio_2 <- reactive({
    input$val2
  })
  
  val_anio_3 <- reactive({
    input$val3
  })
  
  val_anio_4 <- reactive({
    input$val4
  })
  
  ### Outputs
  
  output$plot <- renderLeaflet({
    if (contaminante() == 'CO'){
      df_co_canada_year <- df_co_canada %>% filter(Year == anio())
      df_co_canada_year %>%
        leaflet() %>%
        addTiles() %>%
        addHeatmap(lng = df_co_canada_year$lon, lat = df_co_canada_year$lat, intensity = df_co_canada_year$co*100, blur = 40, max = 0.05, radius = 20)
    } else if (contaminante() == 'NO2'){
      df_no2_canada_year <- df_no2_canada %>% filter(Year == anio())
      df_no2_canada_year %>%
        leaflet() %>%
        addTiles() %>%
        addHeatmap(lng = df_no2_canada_year$lon, lat = df_no2_canada_year$lat, intensity = df_no2_canada_year$no2*100, blur = 40, max = 0.05, radius = 20)
    } else {
      df_o3_canada_year <- df_o3_canada %>% filter(Year == anio())
      df_o3_canada_year %>%
        leaflet() %>%
        addTiles() %>%
        addHeatmap(lng = df_o3_canada_year$lon, lat = df_o3_canada_year$lat, intensity = df_o3_canada_year$o3*100, blur = 40, max = 0.05, radius = 20)
    }
  })
  
  output$plot_2 <- renderPlotly({
    if (pais_2() == 'United States'){
      if (contaminante_2() == 'CO'){
        df_co_us_year <- df_co_us %>% filter(year == strtoi(anio_2()))
        p1 <- plot_usmap(data = df_co_us_year, values = "CO", color = "red") + 
          scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
          theme(legend.position = "right")
        stri_ <- 'CO IN USA IN'
        stri <- paste(stri_,anio_2(),sep = " ")
        ggplotly(p1) %>% layout(title = stri)
      } else if (contaminante_2() == 'NO2'){
        df_no2_us_year <- df_no2_us %>% filter(year == strtoi(anio_2()))
        p1 <- plot_usmap(data = df_no2_us_year, values = "NO2", color = "red") + 
          scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
          theme(legend.position = "right")
        stri_ <- 'NO2 IN USA IN'
        stri <- paste(stri_,anio_2(),sep = " ") 
        ggplotly(p1) %>% layout(title = stri)
      } else{
        df_o3_us_year <- df_o3_us %>% filter(year == strtoi(anio_2()))
        p1 <- plot_usmap(data = df_o3_us_year, values = "O3", color = "red") + 
          scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + 
          theme(legend.position = "right")
        stri_ <- 'O3 IN USA IN'
        stri <- paste(stri_,anio_2(),sep = " ")
        ggplotly(p1) %>% layout(title = stri)
      }
    } else{
      germany <- 
        getData(country = "Germany", level = 1) %>%
        st_as_sf()
      if (contaminante_2() == 'CO'){
        df_co_germany_year <- df_co_germany %>% filter(Year == strtoi(anio_2()))
        ger_co_year <- germany %>% left_join(df_co_germany_year, by = c("NAME_1" = "state_measuring_network"))
        g1 <- ggplot(ger_co_year) + geom_sf(aes(fill = CO)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
        stri_ <- 'CO IN GERMANY IN'
        stri <- paste(stri_,anio_2(),sep = " ")
        ggplotly(g1) %>% layout(title = stri)
      } else if (contaminante_2() == 'NO2'){
        df_no2_germany_year <- df_no2_germany %>% filter(Year == strtoi(anio_2()))
        ger_no2_year <- germany %>% left_join(df_no2_germany_year, by = c("NAME_1" = "state_measuring_network"))
        g1 <- ggplot(ger_no2_year) + geom_sf(aes(fill = NO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
        stri_ <- 'NO2 IN GERMANY IN'
        stri <- paste(stri_,anio_2(),sep = " ")
        ggplotly(g1) %>% layout(title = stri)
      } else{
        df_so2_germany_year <- df_so2_germany %>% filter(Year == strtoi(anio_2()))
        ger_so2_year <- germany %>% left_join(df_so2_germany_year, by = c("NAME_1" = "state_measuring_network"))
        g1 <- ggplot(ger_so2_year) + geom_sf(aes(fill = SO2)) + scale_fill_distiller(name = "Quantity", label = scales::comma, palette = "RdBu") + theme(legend.position = "right")
        stri_ <- 'SO2 IN GERMANY IN'
        stri <- paste(stri_,anio_2(),sep = " ")
        ggplotly(g1) %>% layout(title = stri)
      }
    }
  })
  
  output$plot_3 <- renderPlotly({
    if (pais_3() == 'China'){
      if (contaminante_3() == 'CO'){
        co_china <- ggplot(df_china_dataset, aes(x = year, y = co, color = station)) + geom_point(size = 4) + geom_smooth(method='loess')
        ggplotly(co_china) %>% layout(title="CO OVER THE TIME IN CHINA")
      } else if (contaminante_3() == 'NO2'){
        no2_china <- ggplot(df_china_dataset, aes(x = year, y = NO2, color = station)) + geom_point(size = 4) + geom_smooth(method='loess') 
        ggplotly(no2_china) %>% layout(title="NO2 OVER THE TIME IN CHINA")
      } else {
        o3_china <- ggplot(df_china_dataset, aes(x = year, y = O3, color = station)) + geom_point(size = 4) + geom_smooth(method='loess')
        ggplotly(o3_china) %>% layout(title="O3 OVER THE TIME IN CHINA")
      }
    } else {
      if (contaminante_3() == 'CO'){
        co_india <- ggplot(df_india_dataset, aes(x = Year, y = CO, color = city)) + geom_point(size = 4) + geom_line()
        ggplotly(co_india) %>% layout(title = 'CO OVER THE TIME IN INDIA')
      } else if (contaminante_3() == 'NO2'){
        no2_india <- ggplot(df_india_dataset, aes(x = Year, y = NO2, color = city)) + geom_point(size = 4) + geom_line()
        ggplotly(no2_india) %>% layout(title = 'NO2 OVER THE TIME IN INDIA')
      } else {
        o3_india <- ggplot(df_india_dataset, aes(x = Year, y = O3, color = city)) + geom_point(size = 4) + geom_line()
        ggplotly(o3_india) %>% layout(title = 'O3 OVER THE TIME IN INDIA')
      }
    }
  })
  
  output$plot_4 <- renderPlotly({
    df_1 <- subset(df_foot, (country == 'China' | country == 'United States of America' | country == 'India' | country == 'Russian Federation' | country == 'Japan'
                             | country == 'Iran' | country == 'Germany' | country == 'Korea' | country == 'Saudi Arabia' | country == 'Canada')
                   & (year >1999))
    
    foot <- ggplot(df_1, aes(x = year, y = footprint, group = country, color = country)) + 
      geom_line() +
      geom_point() 
    ggplotly(foot) %>% layout(title = 'Ecological footprint of the 10 countries that pollute the most')
  })

  output$plot_5 <- renderPlotly({
    df_co2_emissions_10 <- df_co2_emissions %>%
      filter(year %in% c(val_anio_1(),val_anio_2(),val_anio_3(),val_anio_4())) %>%
      filter(Country.Name %in% c('Canada','China','Mexico','India','Iran, Islamic Rep.','Japan',"Korea, Dem. People's Rep.",'Russian Federation','Saudi Arabia','United States'))
    ggplot(df_co2_emissions_10, aes(x = year, y = CO2, group = Country.Name, color = Country.Name)) + 
      geom_line(size = 3) +
      geom_point(size = 6)
  })
  
}

shinyApp(ui, server)























