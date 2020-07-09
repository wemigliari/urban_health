library(readxl)
library(pastecs) # Summary of descriptive statistics

model <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/tour_gov_health_barna.xlsx",
                   sheet = "esp_cat_swedes")

model_mlr_ar_n <- lm(model$Arrivals_cat ~ model$Arrivals_cat_dk + 
                       model$Arrivals_cat_nor + model$Arrivals_cat_se + 
                       model$Arrivals_cat_fin, data = model) 

summary(model_mlr_ar_n)
confint(model_mlr_ar_n)

### Prediction based on the max value found in the model

max(predict(model_mlr_ar_n, interval = "prediction"))

### Curiosities
max(model$Arrivals_cat) # [1] 2567612 per month
max(model$Arrivals_cat_total_nordics) #[1] 130088 per month
max(model$Arrivals_cat_dk)            #[1] 49407 per month
max(model$Arrivals_cat_fin)           #[1] 16724 per month
max(model$Arrivals_cat_nor)           #[1] 48904 per month
max(model$Arrivals_cat_se)            #[1] 61076 per month

sum(model$Arrivals_cat_total_nordics)
#[1] 2618605
sum(model$Arrivals_cat_dk)
#[1] 682093
sum(model$Arrivals_cat_fin)
#[1] 130626
sum(model$Arrivals_cat_nor)
#[1] 791467
sum(model$Arrivals_cat_se)
#[1] 1014419

sum(model$Arrivals_cat_dk, 
    model$Arrivals_cat_fin, 
    model$Arrivals_cat_nor, 
    model$Arrivals_cat_se)

#[1] 2618605

###

prediction_total_nordics <- data.frame(model$Arrivals_cat_total_nordics)
stat.desc(prediction_total_nordics)
prediction_total_dk <- data.frame(model$Arrivals_cat_dk)
prediction_total_fin <- data.frame(model$Arrivals_cat_fin)
prediction_total_nor <- data.frame(model$Arrivals_cat_nor)
prediction_total_se <- data.frame(model$Arrivals_cat_se)

p1 <- predict(model_mlr_ar_n, prediction_total_nordics) # No matter variable we use, all the results will be the same.
p2 <- predict(model_mlr_ar_n, prediction_total_dk) # No matter variable we use, all the results will be the same.
p3 <- predict(model_mlr_ar_n, prediction_total_fin) # No matter variable we use, all the results will be the same.
p4 <- predict(model_mlr_ar_n, prediction_total_nor) # No matter variable we use, all the results will be the same.
p5 <- predict(model_mlr_ar_n, prediction_total_se) # No matter variable we use, all the results will be the same.

#####


