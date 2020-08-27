library(readxl)

alkohol <- read_excel("/Users/wemigliari/Documents/R/tabelas/total_alkoholanskaff.xlsx")

class(alkohol)
alkohol <- data.frame(alkohol)

alkohol[, c(2,3,5,6,8,9,11,12,14,15,17,18)] <- sapply(alkohol[, c(2,3,5,6,8,9,11,12,14,15,17,18)], as.numeric)

library(plotly)


plot_ly(alkohol, x = ~Years1, y = ~Riket1, type = "scatter", mode = "markers", color = I("black"), marker = list(size = ~Riket6, opacity = 0.5, color = "lightgreen"), name = 'Sprit') %>%
  add_markers(y = ~Riket2, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "lightgray"), name = 'Vin') %>%
  add_markers(y = ~Riket3, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "gray"), name = 'Starköl') %>%
  add_markers(y = ~Riket4, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "darkgreen"), name = 'Cider') %>%
  add_markers(y = ~Riket5, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "purple"), name = 'Folköl')%>%
  add_markers(y = ~Riket6, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "steelblue"), name = 'Alkoholanskaffning')%>%
  layout(title = "Antal liter ren alkohol per person 15 år eller äldre",
         xaxis = list(title = ""),
         yaxis = list (title = "Riket (liter)"))


###

trafik <- read_excel("/Users/wemigliari/Documents/R/tabelas/trafikolyckor.xlsx",
                     sheet = "Omkomna_totalt")

trafik2 <- read_excel("/Users/wemigliari/Documents/R/tabelas/trafikolyckor.xlsx",
                     sheet = "Omkomna_kön")


plot_ly(trafik, x = ~År, y = ~Januari, type = "scatter", mode = "markers", color = I("black"), marker = list(size = ~Totalt/200, opacity = 0.5, color = "lightgreen"), name = 'Januari') %>%
  add_markers(y = ~Februari, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "lightgray"), name = 'February') %>%
  add_markers(y = ~Mars, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "gray"), name = 'Mars') %>%
  add_markers(y = ~April, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "darkgreen"), name = 'April') %>%
  add_markers(y = ~Maj, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "purple"), name = 'Maj')%>%
  add_markers(y = ~Juni, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "steelblue"), name = 'Juni')%>%
  add_markers(y = ~Juli, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "gold"), name = 'Juli')%>%
  add_markers(y = ~Augusti, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "red"), name = 'Augusti')%>%
  add_markers(y = ~September, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "blue"), name = 'September')%>%
  add_markers(y = ~Oktober, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "orange"), name = 'Oktober')%>%
  add_markers(y = ~November, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "green"), name = 'November')%>%
  add_markers(y = ~December, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "lightblue"), name = 'December')%>%
  layout(title = "Omkomna enligt underlag till officiell statistik per månad",
         xaxis = list(title = ""),
         yaxis = list (title = "Omkomna"))

#

plot_ly(trafik, x = ~År, y = ~Totalt, name = ~År,
        type = "scatter", mode = "markers", 
        size = ~Totalt/100, 
        colors = 'Paired',
        marker = list(opacity = 0.5, sizemode = 'diameter'))%>%
  layout(title = "Omkomna enligt underlag till officiell statistik per år",
         xaxis = list(title = ""),
         yaxis = list (title = "Totalt"))

### Boxplots

plot_ly(alkohol, type = "box", 
        quartilemethod="linear",
        boxpoints = "all", jitter = 0.3,
        pointpos = -1.8,
        color = I("steelblue"))%>%
  add_trace(y = ~Riket6, name = "Alkoholskaffning", type = "box")%>%
  add_trace(y = ~Riket5, name = "Sprit", type = "box")%>%
  add_trace(y = ~Riket4, name = "Vin", type = "box")%>%
  add_trace(y = ~Riket3, name = "Starköl", type = "box")%>%
  add_trace(y = ~Riket2, name = "Cider", type = "box")%>%
  add_trace(y = ~Riket1, name = "Folköl", type = "box")%>%
  layout(title = "Alkoholanskaffning, total efter dryck. Antal liter ren alkohol per person 15 - år",
         xaxis = list(title = ""),
         yaxis = list (title = "Liter (per år)"))




