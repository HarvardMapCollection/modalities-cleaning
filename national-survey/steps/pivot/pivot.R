#Install tidyverse 
library(tidyverse)

#Import the Mexican national survey data
national_survey_data <- read_csv(file = "https://raw.githubusercontent.com/HarvardMapCollection/modalities-cleaning/main/original/tabular/ENPOL2021_2_3.csv")

#Let's pare the source data's 184 columns (😅) down to the only one we want to map
national_survey_data <- national_survey_data %>% select ("P3_6") 

#Rename the confusing column header "P3_6" to something we understand
#about the location of where crimes occurred, "CRIME_LOC"
national_survey_data <- national_survey_data %>%
  rename("CRIME_LOC" = "P3_6")

#group_by groups the records by the recurring values within
#With summarise(), we can specify the summary statistics we want
#In this case, we want to create a new column titled "COUNT"
#And the "=n" specifies that we want to count, rather than sum or mean, etc.
national_survey_data <- national_survey_data %>% group_by(CRIME_LOC) %>%
  summarise(COUNT=n())


