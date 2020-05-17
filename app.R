library(shiny)
library(leaflet)
library(readxl)
library(rgdal)
library(sf)
library(data.table) ### Download the tables from a website
library(tidyverse)

###layers
metro_brazil <- st_read("/Users/wemigliari/Documents/R/Rshiny/metro_corona_brazil/AglomeradosSubnormais2010_Limites.shp")
class(metro_brazil)
metro_layer <- st_transform(metro_brazil, "+proj=longlat +datum=WGS84")

###Converting multipolygons into two columns
sf_centers <- metro_brazil %>%
    dplyr::mutate(geometry = st_centroid(geometry))
sf_centers1 <- sf_centers %>% mutate(lat = unlist(map(sf_centers$geometry,2)), long = unlist(map(sf_centers$geometry,1)))

### Data on coronavirus
brazil_corona <- read_excel("corona_brazil.xlsx")
nm_municip <- brazil_corona$municipio
nm_municip1 <- paste0(c("2020-05-16", nm_municip), collapse = "|")
brazil_corona1 <- cbind(brazil_corona, nm_municip1)

sf_centers2 <- merge(sf_centers1, brazil_corona1, by= "nm_municip1", all=T)
rownames(sf_centers2) <- sf_centers2$Row.names; sf_centers2$Row.names <- NULL
sf_centers2

###Labels
tocan <- makeAwesomeIcon(icon = 'flag', markerColor = 'red', library='fa', iconColor = 'black')
deaths <- paste(
    "Municipality: ", brazil_corona1$nm_municip, "<br/>", 
    sep="") %>%
    lapply(htmltools::HTML)

###

brazil <- leaflet(sf_centers2) %>% addTiles() %>%
    addProviderTiles(providers$Stamen.Toner)%>%
    setView(-46.625290, -23.533773, zoom = 4)%>%
    addCircleMarkers(lng = sf_centers2$long, lat = sf_centers2$lat, weight = 1, 
                     radius = 5,
                     label = deaths,
                     color = "green",
                     fillOpacity = 0.3)%>%
    addCircleMarkers(lng = sf_centers2$long, lat = sf_centers2$lat, weight = 1, 
                     radius = 5,
                     label = sf_centers2$obitosAcumulado,
                     color = "green",
                     fillOpacity = 0.3)%>%
    addAwesomeMarkers(-48.32766, -10.16745, label = "Berg e Cíntia, fiquem em casa!", icon = tocan)

brazil

addPolygons(data = sf_centers1, color = "#004a7d")


