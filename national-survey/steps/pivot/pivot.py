import pandas as pd

#Import the Mexican national survey data
url = 'https://raw.githubusercontent.com/HarvardMapCollection/modalities-cleaning/main/national-survey/original-source-data/tabular/ENPOL2021_2_3.csv'
data = pd.read_csv(url, index_col=0, encoding='latin-1')
print(data.head(5))


#Let's pare the source data's 184 columns (😅) down to the only one we want to map
data = data.filter(items=['P3_6'])


#Rename the confusing column header "P3_6" to something we understand
#about the location of where crimes occurred, "CRIME_LOC"
data = data.rename(columns={"P3_6": "CRIME_LOC"})


#groupby groups the records by the recurring values within
#With .agg(), we can specify the summary statistics we want
#In this case, we want to create a new column titled "COUNT"
#And the second parameter 'count' specifies that we want to count, rather than sum or mean, etc.
data = data.groupby(['CRIME_LOC']).agg(COUNT=('CRIME_LOC', 'count'))


#Groupby messes up the column headers, this fixes it
data = data.reset_index()


