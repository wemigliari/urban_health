library(dplyr)
library(readxl)
library(tidyverse)

## Total Deaths per Region

corona_region_sweden <- read_excel("/Users/wemigliari/Documents/R/tabelas/corona_statistik_sverige.xlsx", 
                                   sheet = "total_death_region")
corona_region_sweden2 <- as.data.frame(corona_region_sweden)

region_2018 <-corona_region_sweden2 %>% filter(Year == 2018)

region_2019 <-corona_region_sweden2 %>% filter(Year == 2019)

region_2020 <- corona_region_sweden2%>% filter(Year == 2020)

total_2018 <- region_2018%>%filter(date == "Total")
total_2019 <- region_2019%>%filter(date == "Total")
total_2020 <- region_2020%>%filter(date == "Total")

total_corona <- rbind(total_2018, total_2019, total_2020)
total_corona2 <- t(total_corona)
total_corona2 <- as.data.frame(total_corona2)
test <- total_corona2[-c(1),]

test2 <- set_names(test, nm = test[1, ])
test2 <- slice(test2, -1)

test3 <-tibble::rownames_to_column(test2, "NAME_1") 

library(curl)
library(rsconnect)
library(leaflet)
library(leaflet.extras)
library(sp)
library(plotly)
library(maps)
library(mapdata)
library(mapproj)
library(leaflet)
library(sf)
library(tmap)
library(transformr)
library(geojson)
library(rgdal)
library(raster) # union function
library(bookdown)
data("World")

sweden <- readOGR("/Users/wemigliari/Documents/R/data/SWE_adm1.shp")
class(sweden)

sweden1 <- read_sf("/Users/wemigliari/Documents/R/data/SWE_adm1.shp")
class(sweden1)

sweden_test <- merge(test3, sweden1, by = "NAME_1") ## It works!
class(sweden_test)

sweden_test1 <- st_as_sf(sweden_test) ## It works!
class(sweden_test1)

### Labels

regions <- paste(sep = "  ",
                 sweden_test$NAME_1,
                 2018,
                 sweden_test$`2018`,
                 "|",
                 2019,
                 sweden_test$`2019`,
                 "|",
                 2020,
                 sweden_test$`2020`)

### Plotting

leaflet(sweden_test$geometry)%>% 
  addPolygons(fillColor = "lightblue", color = "gray",
  opacity = 1.0, weight = .6, smoothFactor = 0.7,
  highlightOptions = highlightOptions(color="white", weight=2, bringToFront = TRUE), label= regions)%>%
  addProviderTiles(providers$CartoDB.Positron)

