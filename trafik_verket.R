library(dplyr)
library(readxl)
library(plotly)
##options(error=recover) Use it to track the errors.

alkohol <- read_excel("/Users/wemigliari/Documents/R/tabelas/total_alkoholanskaff.xlsx")

class(alkohol)
alkohol <- data.frame(alkohol)

alkohol[, c(3,6,9,12,15,18)] <- sapply(alkohol[, c(3,6,9,12,15,18)], as.numeric)
alkohol[, c(2,5,8,11,14,17)] <- sapply(alkohol[, c(2,5,8,11,14,17)], as.character)

trafik <- read_excel("/Users/wemigliari/Documents/R/tabelas/trafikolyckor.xlsx",
                     sheet = "Omkomna_totalt")

trafik <- data.frame(trafik)
trafik[,1] <- sapply(trafik[,1], as.character)

trafik2 <- read_excel("/Users/wemigliari/Documents/R/tabelas/trafikolyckor.xlsx",
                      sheet = "Omkomna_kön")

trafik2 <- data.frame(trafik2)
trafik2[,1] <- sapply(trafik2[,1], as.character)

library(plotly)
library(dplyr)

### Graph Alkohol

plot_ly(alkohol, x = ~Years1, y = ~Riket1, type = "scatter", mode = "markers", color = I("black"), marker = list(size = ~Riket6, opacity = 0.5, color = "lightgreen"), name = 'Sprit') %>%
  add_markers(y = ~Riket2, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "lightgray"), name = 'Vin') %>%
  add_markers(y = ~Riket3, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "gray"), name = 'Starköl') %>%
  add_markers(y = ~Riket4, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "darkgreen"), name = 'Cider') %>%
  add_markers(y = ~Riket5, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "purple"), name = 'Folköl')%>%
  add_markers(y = ~Riket6, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "steelblue"), name = 'Alkoholanskaffning')%>%
  layout(title = "Antal liter ren alkohol per person 15 år eller äldre",
         xaxis = list(title = ""),
         yaxis = list (title = "Riket (liter)"))

### Boxplots Alkohol

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
  layout(title = "",
         xaxis = list(title = ""),
         yaxis = list (title = "Liter (per år)"))


### Trafikolyckor

plot_ly(trafik, x = ~År, y = ~Januari, type = "scatter", mode = "markers", color = I("black"), marker = list(size = ~Totalt/200, opacity = 0.5, color = "lightgreen"), name = 'Januari') %>%
  add_markers(y = ~Februari, type = "box", mode = "markers", color = I("black"), marker = list(color = "lightgray"), name = 'Februari') %>%
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

### Trafikolyckor Totalt

plot_ly(trafik, x = ~År, y = ~Totalt, name = ~År,
        type = "scatter", mode = "markers", 
        size = ~Totalt/100, 
        colors = 'Paired',
        marker = list(opacity = 0.5, sizemode = 'diameter'))%>%
  layout(title = "Omkomna enligt underlag till officiell statistik per år",
         xaxis = list(title = ""),
         yaxis = list (title = "Totalt"))

### Boxplots Trafik/ Alkoholanskaffning, total efter dryck. Antal liter ren alkohol per person 15 - månad/år

plot_ly(trafik, type = "box",
        text = trafik$År,
        quartilemethod="linear",
        boxpoints = "all", jitter = 0.2,
        pointpos = -1.8,
        color = I("lightgray"))%>%
  add_trace(y = ~Januari, type = "box", color = I("lightgray"), marker = list(color = "lightgray"), name = 'Januari') %>%
  add_trace(y = ~Februari, type = "box", color = I("lightgray"), marker = list(color = "lightgray"), name = 'Februari') %>%
  add_trace(y = ~Mars, type = "box", color = I("lightgray"), marker = list(color = "lightgray"), name = 'Mars') %>%
  add_trace(y = ~April, type = "box", color = I("lightgray"), marker = list(color = "lightgray"), name = 'April') %>%
  add_trace(y = ~Maj, type = "box", color = I("lightgray"), marker = list(color = "lightgray"), name = 'Maj')%>%
  add_trace(y = ~Juni, type = "box", color = I("steelblue"), marker = list(color = "steelblue"), name = 'Juni')%>%
  add_trace(y = ~Juli, type = "box", color = I("steelblue"), marker = list(color = "steelblue"), name = 'Juli')%>%
  add_trace(y = ~Augusti, type = "box", color = I("steelblue"), marker = list(color = "steelblue"), name = 'Augusti')%>%
  add_trace(y = ~September, type = "box", color = I("lightgray"), marker = list(color = "lightgray"), name = 'September')%>%
  add_trace(y = ~Oktober, type = "box", color = I("lightgray"), marker = list(color = "lightgray"), name = 'Oktober')%>%
  add_trace(y = ~November, type = "box", color = I("lightgray"), marker = list(color = "lightgray"), name = 'November')%>%
  add_trace(y = ~December, type = "box", color = I("lightgray"), marker = list(color = "lightgray"), name = 'December')%>%
  layout(title = "",
         xaxis = list(title = ""),
         yaxis = list (title = "Liter (per år)"))


### Graph Kön

plot_ly(trafik2 ,type = 'scatter', mode = 'lines')%>%
  add_trace(x = ~År, y = ~Kvinna, name = "Kvinna", mode = 'lines+markers', 
            line = list(dash = "dash"),
            color = I("steelblue"), marker = list(color = "steelblue"))%>%
  add_trace(x = ~År, y = ~Man, name = "Man", mode = 'lines+markers', 
            line = list(dash = "dot"),
            color = I("gray"), marker = list(color = "gray"))%>%
  add_trace(x = ~År, y = ~Totalsumma, name = "Totalt", mode = 'lines+markers', 
            color = I("darkgreen"), marker = list(color = "darkgreen"))%>%
  layout(title = "Omkomna enligt underlag till officiell statistik per kön",
         xaxis = list(title = ""),
         yaxis = list (title = "Totalt"))

### Omkomna enligt underlag till officiell statistik per kön


plot_ly(trafik2, x = ~År, y = ~Kvinna, alpha = 0.5, type = 'scatter', mode = 'markers', text = "Kvinna", marker = list(size = ~Man/10, opacity = 0.5), color = I("steelblue"), marker = list(color = "steelblue"))%>% 
  add_markers(x = ~År, y = ~Man, alpha = 0.5, 
              text = "Man", name = "Man",
              color = I("lightgray"), marker = list(color = "lightgray"))%>%
  layout(
    title = "",
    xaxis = list(domain = c(0.1, 1), title = "", tickfont = list(size = 10), tickangle = 90),
    yaxis = list(title = "Totalt", tickfont = list(size = 10)),
    updatemenus = list(
      list(
        y = 0.8,
        buttons = list(
          
          list(method = "restyle",
               args = list("type", "markers"),
               label = "Bubbles"),
          
          list(method = "restyle",
               args = list("type", "histogram2d"),
               label = "2D Histogram")))
    ))


### Cirkeldiagrammer

fig1 <- plot_ly(trafik2, labels = ~År, values = ~Kvinna, type = 'pie', text = "Kvinna")%>%
  layout(title = 'Omkomna enligt underlag till officiell statistik, kvinna',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))


fig2 <- plot_ly(trafik2, labels = ~År, values = ~Man, type = 'pie', text = "Man")%>%
  layout(title = 'Omkomna enligt underlag till officiell statistik, Man',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))



### Cirkeldiagrammer/ Omkomna enligt underlag till officiell statistik


fig <- plot_ly()
fig <- fig %>% add_pie(data = count(trafik2, trafik2$Kvinna), labels = trafik2$År, values = trafik2$Kvinna,
                       name = "Kvinna", domain = list(row = 0, column = 0))
fig <- fig %>% add_pie(data = count(trafik2, trafik2$Man), labels = trafik2$År, values = trafik2$Man,
                       name = "Man", domain = list(row = 0, column = 1))
fig <- fig %>% layout(title = "", showlegend = F,
                      grid=list(rows=1, columns=2),
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
fig

### Gifs

library(purrr)
library(magick)

list.files(path = "/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/trafikverket", pattern = "*.png", full.names = T) %>% 
  map(image_read) %>% # reads each path file
  image_join() %>% # joins image
  image_animate(fps=0.5) %>% # animates, can opt for number of loops
  image_write("/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/trafikverket.gif") # write to current dir

### Normal Distribution

x <- rnorm(sum(trafik$Totalt))
fit <- density(x)

plot_ly(x = x, type = "histogram", name = "Histogram") %>% 
  add_trace(x = fit$x, y = fit$y, type = "scatter", mode = "lines", 
            fill = "tozeroy", yaxis = "y2", name = "Density",
            color = I("lightblue")) %>% 
  layout(yaxis2 = list(overlaying = "y", side = "right"))

### Model

library(GGally)

par(mar = c(1,1,1,1), family = "Arial", cex = 0.7)
ggpairs(trafik2[(2:4)], cardinality_threshold = 17)

pairs(trafik2[,2:4], pch = c(3), col = c("lawngreen"),
      labels = c("Kvinna", "Man", "Totalsumma"), oma=c(3,3,3,15))
par(xpd = TRUE)

legend("bottomright", pch = c(3), col = c("lawngreen"), 
       legend = c("Bilolyckor"), bty = "n")

model <- lm(trafik$Augusti ~ trafik$Juli + trafik$September)

model2 <- lm(trafik$Augusti ~ trafik$Juli)

summary(model)

summary(trafik2)
summary(model2)

















