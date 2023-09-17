library(tidyverse)
library(tidygeocoder)

# Read data
df <- read_csv("~/Desktop/de-identified_standard_addresses.csv")


df_geocoded <- df %>%
  # Add column to specify that these are in Russia
  mutate(to_geocode = paste0(City, ", Russia")) %>%
  # Geocode with OpenStreetMap
  geocode(to_geocode, method = "osm") %>%
  # Rename lat/long columns to provide clarity about what they represent
  rename(
    lat = lat,
    lon = long
  )


write_csv(df_geocoded, "~/Desktop/geocoded.csv")
