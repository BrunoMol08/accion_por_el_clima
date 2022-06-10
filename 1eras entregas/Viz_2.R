library(ggplot2)
library(usmap)
library(plotly)

df <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/pollution_us_2000_2016.csv')

df_1 <- subset(df, select = c(2,6,9,11))

colnames(df_1) <- c('fips','full','date','NO2')
head(df_1)df_upd <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/pollution_us_group_by.csv')


vect <- list()
for(i in 1:nrow(df_1)) {
  row <- df_1[i,3]
  x <- substr(row,1,4)
  vect[i] <- strtoi(x)
}

df_1$year <- vect

df_2 <- subset(df_1, select = c(1,2,5,4))
head(df_2)

df_2 <- apply(df_2,2,as.character)

write.csv(df_2,"/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/pollution_us_2000_2016_reduced.csv",row.names = FALSE)

### Después de correrse en SQL el group by

df_upd <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/pollution_us_group_by.csv')

p <- plot_usmap(data = df_upd, values = "avg", color = "red") + 
  scale_fill_distiller(name = "Promedio de dióxido de nitrógeno NO2 en USA (2015)", label = scales::comma, palette = "RdBu") + 
  theme(legend.position = "right")

fig <- ggplotly(p)
fig

