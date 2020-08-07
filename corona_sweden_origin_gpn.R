

origin <- read_excel("/Users/wemigliari/Documents/R/tabelas/corona_statistik_sverige.xlsx", 
                                   sheet = "total_death_origin_2020")

origin_2 <- read_excel("/Users/wemigliari/Documents/R/tabelas/corona_statistik_sverige.xlsx", 
                     sheet = "total_death_origin_2015_19")

origin_3 <- cbind(origin, origin_2)

### 2020

par(mar = c(5,5,10,5), cex = 0.7)
plot(origin_3$total2020, type = "b", bty = "l", pch = 6, col = "darkgray", 
     main ="Number of Deaths, Place of Birth, 2020. Statistik centralbyrån (SCB)",
     xlab = "",
     ylab = "",
     ylim = c(0,5500))
text(origin_3$total2020, labels = origin_3$origin1, 
     cex=0.6, font=2, srt = 45, pos = 3, col = "darkgray")


### 2015-19

par(mar = c(5,5,10,5), cex = 0.7)
plot(origin_3$total1519, type = "b", bty = "l", pch = 13, col = "darkgreen", 
     main ="Number of Deaths, Place of Birth, 2015-19. Statistik centralbyrån (SCB)",
     xlab = "",
     ylab = "",
     ylim = c(0,5500))
text(origin_3$total1519, labels = origin_3$origin2, 
     cex=0.6, font=2, srt = 45, pos = 3, col = "darkgray")




