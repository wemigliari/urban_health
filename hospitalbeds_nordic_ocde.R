
library(dplyr)
library(readxl)

setwd("/Users/wemigliari/Documents/R/tabelas")
getwd() 

# Have a look at the following webpage to change csv into xlsx
# http://help.snapizzi.com/en/articles/1089773-split-csv-data-into-different-columns

hb_ocde <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/hb_ocde.xlsx")

hb_ocde1 <- hb_ocde%>%filter(SUBJECT == "TOT")

### Plotting

plot(hb_ocde1$TIME, hb_ocde1$Value, pch = 6, col = "steelblue")

library(plotly)
library(RColorBrewer)

plot_ly(hb_ocde1, x = ~TIME, y = ~Value, text = ~LOCATION, type = 'scatter', mode = 'markers',
        marker = list(size = ~Value, opacity = 0.5), 
        color = ~LOCATION,
        colors = colorRampPalette(brewer.pal(10,"Spectral"))(42))%>%
  layout(title = 'Hospital beds. Total per 1,000 inhabitants, 2019, OECD',
         xaxis = list(title = "", gridcolor = 'rgb(255, 255, 255)'),
         yaxis = list(title = "Hospital Beds", gridcolor = 'rgb(255, 255, 255)'),
         showlegend = TRUE)

###

nordics <- c("SWE", "DNK", "NOR", "FIN")

hb_ocde2 <-  hb_ocde1%>%filter(LOCATION %in% nordics)
class(hb_ocde2)
hb_ocde2 <- data.frame(hb_ocde2) # Fisrt, convert the data table into data frame

hb_ocde2[,7] <- sapply(hb_ocde2[,7], as.numeric)


### Plotting

plot_ly(hb_ocde2, x = ~TIME, y = ~Value, text = ~LOCATION, type = 'scatter', mode = 'lines',
        marker = list(size = ~Value, opacity = 0.5), 
        color = ~LOCATION,
        colors = colorRampPalette(brewer.pal(4,"Paired"))(4))%>%
  layout(title = 'Hospital beds. Total per 1,000 inhabitants, 2019, OECD',
         xaxis = list(title = "", gridcolor = 'rgb(255, 255, 255)'),
         yaxis = list(title = "Hospital Beds", gridcolor = 'rgb(255, 255, 255)'),
         showlegend = TRUE)

###

den <- "DNK"
denmark <-  hb_ocde2%>%filter(LOCATION %in% den)
fin <- "FIN"
finland <-  hb_ocde2%>%filter(LOCATION %in% fin)
nor <- "NOR"
norway <-  hb_ocde2%>%filter(LOCATION %in% nor)
swe <- "SWE"
sweden <-  hb_ocde2%>%filter(LOCATION %in% swe)

library(gdata)

data_nordic <- cbindX(denmark, finland, norway, sweden)
names(data_nordic)[1] <- "Denmark"
names(data_nordic)[c(6, 7)] <- c("year1", "value1")
names(data_nordic)[8] <- "Finland"
names(data_nordic)[c(13, 14)] <- c("year2", "value2")
names(data_nordic)[15] <- "Norway"
names(data_nordic)[c(20, 21)] <- c("year3", "value3")
names(data_nordic)[22] <- "Sweden"
names(data_nordic)[c(27, 28)] <- c("year4", "value4")

par(cex = 0.7)
plot(data_nordic$year4, data_nordic$value4, type = "l", 
     col = "steelblue", xlab = "", ylab = "", main = "Hospital beds. Total per 1,000 inhabitants, 2019 or latest available, OCDE")
lines(data_nordic$year1, data_nordic$value2, col = "orange")
lines(data_nordic$year2, data_nordic$value2 ,col = "gold")
lines(data_nordic$year3, data_nordic$value3, col = "darkgreen")

nordics1 <- c("Sweden", "Denmark", "Finland", "Norway")

legend(2010, 14, legend=nordics1,
       col=c("steelblue", "orange", "gold", "darkgreen"), lty=1, cex=0.7,
       box.lty=0)








