#Install tidyverse 
library(tidyverse)

#Import the Mexican national survey data
national_survey_data <- read_csv(file = "https://raw.githubusercontent.com/HarvardMapCollection/modalities-cleaning/main/original/tabular/ENPOL2021_2_3.csv")

#Let's just keep the unique ID and the column of interest
national_survey_data <- national_survey_data %>% select ("P3_6") 


national_survey_data <- national_survey_data %>%
  rename("CRIME_LOC" = "P3_6")


national_survey_data <- national_survey_data %>% group_by(CRIME_LOC) %>%
  summarise(COUNT=n())

