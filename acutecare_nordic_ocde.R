library(dplyr)
library(readxl)

setwd("/Users/wemigliari/Documents/R/tabelas")
getwd() 

# Have a look at the following webpage to change csv into xlsx
# http://help.snapizzi.com/en/articles/1089773-split-csv-data-into-different-columns

ac_ocde <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/hb_ocde.xlsx")

ac_ocde1 <- ac_ocde%>%filter(SUBJECT == "ACUTE")

ac_ocde1 <- data.frame(ac_ocde1) # Fisrt, convert the data table into data frame

ac_ocde1[,7] <- sapply(ac_ocde1[,7], as.numeric)

### Plotting

plot(ac_ocde1$TIME, ac_ocde1$Value, pch = 6, col = "steelblue")

library(plotly)
library(RColorBrewer)

plot_ly(ac_ocde1, x = ~TIME, y = ~Value, text = ~LOCATION, type = 'scatter', mode = 'markers',
        marker = list(size = ~Value/2, opacity = 0.5), 
        color = ~LOCATION,
        colors = colorRampPalette(brewer.pal(10,"Reds"))(42))%>%
  layout(title = 'Hospital beds. Total per 1,000 inhabitants, 2019 or latest available, OCDE',
         xaxis = list(title = "", gridcolor = 'rgb(255, 255, 255)'),
         yaxis = list(title = "Hospital Beds", gridcolor = 'rgb(255, 255, 255)'),
         showlegend = TRUE)
###

nordics <- c("SWE", "DNK", "NOR", "FIN")

ac_ocde2 <-  ac_ocde1%>%filter(LOCATION %in% nordics)
class(ac_ocde2)
ac_ocde2 <- data.frame(ac_ocde2) # Fisrt, convert the data table into data frame

### Plotting

plot_ly(ac_ocde2, x = ~TIME, y = ~Value, text = ~LOCATION, type = 'scatter', mode = 'lines',
        marker = list(size = ~Value, opacity = 0.5), 
        color = ~LOCATION,
        colors = colorRampPalette(brewer.pal(4,"Dark2"))(4))%>%
  layout(title = 'Hospital beds, Acute. Total per 1,000 inhabitants, 2019 or latest available, OCDE',
         xaxis = list(title = ""),
         size = 0.7,
         yaxis = list(title = "Hospital Beds"),
         size = 0.7,
         showlegend = TRUE, legend = list(font = list(size = 10)))


