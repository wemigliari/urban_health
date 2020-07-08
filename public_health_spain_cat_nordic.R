library(readxl)
library(dplyr)


model <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/tour_gov_health_barna.xlsx",
                   sheet = "esp_cat_swedes")
library(GGally)
ggpairs(model) # Plot all the correlations + normal distributions


## Model 1

model_mlr_ar <- lm(model$Arrivals_n_s ~ model$Arrivals_cat_total_nordics)
summary(model_mlr_ar)
confint(model_mlr_ar)

## Model 2



model_mlr_ar_n <- lm(model$Arrivals_cat ~ model$Arrivals_cat_dk + 
                     model$Arrivals_cat_nor + model$Arrivals_cat_se + 
                     model$Arrivals_cat_fin, data = model)
summary(model_mlr_ar_n)
confint(model_mlr_ar_n)


####
library(extrafont)
par(mfrow = c(2,3), family= "Arial", cex = 0.5, oma = c(4, 1, 1, 4))

qqnorm(model$Arrivals_n_s/1000, pch = 1, frame = FALSE, main = "Normal Q-Q Plot Arrivals of Nordics in Spain") +
  qqline(model$Arrivals_n_s/1000, col = "steelblue", lwd = 2)

qqnorm(model$Arrivals_cat_total_nordics/1000, pch = 1, frame = FALSE,  main = "Normal Q-Q Plot Arrivals of Nordics in Catalonia") +
  qqline(model$Arrivals_cat_total_nordics/1000, col = "steelblue", lwd = 2)

qqnorm(model$Arrivals_cat_dk/1000, pch = 1, frame = FALSE, main = "Normal Q-Q Plot Arrivals of Danish in Catalonia") +
  qqline(model$Arrivals_cat_dk/1000, col = "steelblue", lwd = 2)

qqnorm(model$Arrivals_cat_fin/1000, pch = 1, frame = FALSE, main = "Normal Q-Q Plot Arrivals of Finnish in Catalonia") +
  qqline(model$Arrivals_cat_fin/1000, col = "steelblue", lwd = 2)

qqnorm(model$Arrivals_cat_nor/1000, pch = 1, frame = FALSE, main = "Normal Q-Q Plot Arrivals of Norwegians in Catalonia") +
  qqline(model$Arrivals_cat_nor/1000, col = "steelblue", lwd = 2)

qqnorm(model$Arrivals_cat_se/1000, pch = 1, frame = FALSE, main = "Normal Q-Q Plot Arrivals of Swedes in Catalonia") +
  qqline(model$Arrivals_cat_se/1000, col = "steelblue", lwd = 2)



####

max(model$Accumulated_arrivals_n_s/1000000)
#[1] 5.826548
min(model$Accumulated_arrivals_n_s/1000000)
#[1] 0
mean(model$Accumulated_arrivals_n_s/1000000)
#[1] 2.81716
sd(model$Accumulated_arrivals_n_s/1000000)
#[1] 1.803582


x <- seq(0, 5.826548, by = 0.05)
y <- dnorm(x, mean = 2.81716, sd = 1.803582)
z <- qnorm(x, mean = 2.81716, sd = 1.803582)

par(family= "Arial", cex = 0.6, oma = c(4, 1, 1, 4))
plot(x, z, col = "gray", type = "l", xlim = c(0,1))










