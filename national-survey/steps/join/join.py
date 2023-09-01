import pandas
import geopandas
import mapclassify #lets you specify classification scheme
from pathlib import Path

#Import geospatial data as a dataframe using geopandas
geo_data = geopandas.read_file("{PATH}/modalities-cleaning/national-survey/original-source-data/geo/mexico_admin1.geojson")

#Rename the join field so it matches with the statistical data
geo_data = geo_data.rename(columns={"ID_1": "CRIME_LOC"})

#Read in the statistical data
statistical_data = pandas.read_csv("https://raw.githubusercontent.com/HarvardMapCollection/modalities-cleaning/main/national-survey/steps/pivot/finished-R-export_crimes-by-state.csv") # CSV file

#Attribute join, or merge
geo_data = geo_data.merge(statistical_data, on='CRIME_LOC')

#Make a map 
#https://geopandas.org/en/stable/docs/user_guide/mapping.html
map = geo_data.plot(
    column="COUNT", 
    legend=True, 
    cmap='OrRd', 
    edgecolor="white", 
    scheme="fisher_jenks" #won't work without importing mapclassify
)
#Turn off the axis frame
map.set_axis_off()

#Save the map as an image
fig = map.get_figure()
fig.savefig("{PATH}/output.png")


# ⭐ If you want to export the JOINED .geoJSON
# geo_data.to_file(path, driver="GeoJSON")  

# ⭐ Useful print statements!
# ---------------------------
# print(geo_data.iloc[0])
# print(geo_data.dtypes)
# print(geo_data)
# print(statistical_data.dtypes)
# print(statistical_data.head(5))


