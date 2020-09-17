

origin <- read_excel("/Users/wemigliari/Documents/R/tabelas/corona_statistik_sverige.xlsx", 
                                   sheet = "total_death_origin_2020")

origin_2 <- read_excel("/Users/wemigliari/Documents/R/tabelas/corona_statistik_sverige.xlsx", 
                     sheet = "total_death_origin_2015_19")

origin_3 <- cbind(origin, origin_2)

### 2020

par(mar = c(5,5,10,5), cex = 0.8)
plot(origin_3$total2020, type = "b", bty = "l", pch = 6, col = "turquoise", 
     main ="Number of Deaths, Place of Birth, 2020. Statistik centralbyrån (SCB)",
     xlab = "",
     ylab = "",
     ylim = c(0,5500))
text(origin_3$total2020, labels = origin_3$origin1, 
     cex=0.8, font=2, srt = 25, pos = 3, col = "darkgray")

par(mar = c(5,5,10,5), cex = 0.8)
plot(origin_3$women2020, type = "b", bty = "l", pch = 17, col = "gold", 
     main ="Number of Deaths, Place of Birth, Gender, 2020. Statistik centralbyrån (SCB)",
     xlab = "",
     ylab = "",
     ylim = c(0,2700))
lines(origin_3$men2020, type = "b", bty = "l", pch = 18, col = "orange")
text(origin_3$women2020, labels = origin_3$origin1, 
     cex=0.8, font=2, srt = 25, pos = 3, col = "darkgray")
legend("topright", legend=c("Women", "Men"),
       col=c("gold", "orange"), pch = c(17,18), cex=1,
       box.lty=0)


### 2015-19

par(mar = c(5,5,10,5), cex = 0.8)
plot(origin_3$total1519, type = "b", bty = "l", pch = 13, col = "darkgreen", 
     main ="Number of Deaths, Place of Birth, 2015-19. Statistik centralbyrån (SCB)",
     xlab = "",
     ylab = "",
     ylim = c(0,3800))
text(origin_3$total1519, labels = origin_3$origin2, 
     cex=0.8, font=2, srt = 25, pos = 3, col = "darkgray")

par(mar = c(5,5,10,5), cex = 0.8)
plot(origin_3$women1519, type = "b", bty = "l", pch = 19, col = "steelblue", 
     main ="Number of Deaths, Place of Birth, Gender, 2015-19. Statistik centralbyrån (SCB)",
     xlab = "",
     ylab = "",
     ylim = c(0,2000))
lines(origin_3$men1519, type = "b", bty = "l", pch = 20, col = "lightblue")
text(origin_3$women1519, labels = origin_3$origin2, 
     cex=0.8, font=2, srt = 25, pos = 3, col = "darkgray")
legend("topright", legend=c("Women", "Men"),
       col=c("steelblue", "lightblue"), pch = c(19,20), cex=1,
       box.lty=0)

library(finalfit)

class(origin_3)

