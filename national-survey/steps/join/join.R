library(geojsonsf)
library(tidyverse)
library(stringr)
library(ggplot2)
library(sf)

#Read in GIS data
geo_data <- geojson_sf("[path]]mexico_admin1.geojson")

#R imported the ID field, which we need as characters to join(merge), as a numeric field
#The way it was imported, it also dropped the leading zeroes
#Why not import dtypes? https://gis.stackexchange.com/questions/437038/specifying-dtype-of-columns-when-reading-in-data-with-geopandas
geo_data$ID_1 <- as.character(str_pad(geo_data$ID_1,2,side="left",pad="0"))
str(geo_data)

#Read in statistical data
#This is the result from taking all of the individual survey responses
#And pivoting them to be grouped by count on the state where they occurred
statistical_data <- read_csv(file = "https://raw.githubusercontent.com/HarvardMapCollection/modalities-cleaning/main/national-survey/steps/pivot/finished-R-export_crimes-by-state.csv")

#Clean up the table a little bit
geo_data <- geo_data %>% select ("ID_1", "NAME_1", "TYPE_1", "ENGTYPE_1") 

#Inner join or merge
geo_data <- merge(geo_data, statistical_data, by.x = "ID_1", by.y = "CRIME_LOC")

#Print the first record
geo_data[1, ]

#Export
st_write(geo_data, "[path]/mexstates.shp")

#Make a map with graduated symbology based on the field "count"
ggplot(geo_data) +
  geom_sf(aes(fill = COUNT), color = "white") +
  ggtitle("Map of *counts* of crimes per state") +
  # Change palette
  scale_fill_gradientn(colours = c("#fee0d2","#fc9272", "#de2d26")) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(size=13, hjust = .5, face = "bold")
  )
