
# Read this shape file with the rgdal library. 
library(leaflet)
library(rgdal)
library(maps)
library(readxl)
library(dplyr)
library(sf)
library(tmap)
library(tidyverse)

world_shape <- st_read("/Users/wemigliari/Documents/R/Rshiny/covid_world/World_Countries__Generalized_.shp")

world_shape_geo <- st_transform(world_shape, "+proj=longlat +datum=WGS84")

world_shape_geo1 <- world_shape_geo %>%
    dplyr::mutate(geometry = st_centroid(world_shape_geo$geometry))

### Use tidyverse to pass mutate argument. 
world_shape_geo2 <- world_shape_geo1%>%  
    mutate(lat = unlist(map(world_shape_geo1$geometry,2)), long = unlist(map(world_shape_geo1$geometry,1)))

####Data on Corona19
covid_data <- read_excel("/Users/wemigliari/Documents/R/tabelas/covid_world.xlsx")
COUNTRYAFF<- covid_data$location
location1 <- cbind(covid_data, COUNTRYAFF)


### Merging the two tables

world_covid <- merge(world_shape_geo2, location1, by= "COUNTRYAFF", all=T)
rownames(world_covid) <- world_covid$Row.names; world_covid$Row.names <- NULL
summary(world_covid)

qpal <- colorQuantile("Blues", covid_data$population, n = 9)

# Prepare the text for tooltips:
mytext <- paste(
    "Country: ", world_covid$COUNTRYAFF,"<br/>", 
    "Population: ",round(world_covid$population, 2),"<br/>", 
    "Total Cases (per million): ", world_covid$total_cases_per_million, "<br/>",
    "Total Deaths (per million): ", world_covid$total_deaths_per_million,"<br/>",
    "Aged 70 Older (% Population): ", world_covid$aged_70_older,"<br/>", 
    sep="") %>%
    lapply(htmltools::HTML)

```{r, echo = FALSE, comment = FALSE, warning = FALSE}

# Final Map

leaflet(world_covid) %>% addTiles()%>% 
    addProviderTiles(providers$CartoDB)%>%
    setView( lat=10, lng=0 , zoom=2) %>%
    addCircleMarkers(lng = world_covid$long, lat = world_covid$lat, weight = 1, 
                     radius = 5,
                     label = mytext,
                     color = ~qpal(population),
                     fillOpacity = 0.3)%>%
    addLegend("bottomright", pal = qpal, values = ~population, 
              title = "COVID-19 Scale (%)", opacity = 1)
```

