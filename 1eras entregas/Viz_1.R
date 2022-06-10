library(ggplot2)

df <- read.csv('/home/bruno/Documentos/Visualizacion_informacion/proyecto_vizualizaciones_13/Footprint_pcap_tonnes_with_melt.csv')

head(df)

df_1 <- subset(df, (country == 'China' | country == 'United States of America' | country == 'India' | country == 'Russian Federation' | country == 'Japan'
                    | country == 'Iran' | country == 'Germany' | country == 'Korea' | country == 'Saudi Arabia' | country == 'Canada')
               & (year >1999))

ggplot(df_1, aes(x = year, y = footprint, group = country, color = country)) + 
  geom_line() +
  geom_point() 