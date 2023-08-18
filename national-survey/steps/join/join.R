library(tidyverse)
library(geojsonR)

mexico_states = "https://raw.githubusercontent.com/HarvardMapCollection/modalities-cleaning/master/mex_adm1.geojson"

mexico_states = FROM_GeoJson(url_file_string = mexico_states)

str(mexico_states)

