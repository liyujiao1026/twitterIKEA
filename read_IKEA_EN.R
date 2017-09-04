setwd("./Desktop/twitter_Ikea/")
library(dplyr)

dataIKEA <- read.csv("./data_IKEA_en.csv",sep = ',',header = T)
dataIKEA$user_place <- c(rep("Stockholm", 204), rep("Gothenburg", 39))

dim(dataIKEA)
options(scipen = 100)

summary(dataIKEA$user_location)
date_all <- sort(unique(dataIKEA$tweet_created_at))

st_data <- subset(dataIKEA, user_place=="Stockholm")
gt_data <- subset(dataIKEA, user_place=="Gothenburg")

par(mfrow = c(1,2))
plot(x = st_data$tweet_created_at, y =st_data$tweet_EN_polarity, pch = 20, main = "Stockholm", ylab = "Users' opinion")
plot(x = gt_data$tweet_created_at, y =gt_data$tweet_EN_polarity, pch = 20, main = "Gothenburg")



meanScore <- function(date, location){
            score <- mean(subset(dataIKEA, user_place == location & tweet_created_at == date)$tweet_EN_polarity)
            return(round(score,3))
}

# meanScore_weighted <- function(date, location){
#             score <- subset(dataIKEA, user_place == location & tweet_created_at == date)
#             score_weighted <- sum(score$tweet_EN_polarity * score$tweet_EN_subjectivity) / sum(score$tweet_EN_subjectivity)
#             
#             return(round(score_weighted,3))
# }

date_all

sto <- sapply(date_all, FUN = meanScore, location = "Stockholm")
got <- sapply(date_all, FUN = meanScore, location = "Gothenburg")

plot(sto, type = "l", ylim = c(-1,1), ylab = "Averaged polarity", xaxt = "n", xlab = "Date")
lines(got, type = "l", lty =2 , ylim = c(-1,1))
axis(side = 1, labels = date_all, at = date_all)
legend("bottomright", lty = c(1,2), legend = c("Stockholm", "Gothenburg"))


library(xlsx) #load the package
write.xlsx(x = dataIKEA, file = "dataIKEA.xlsx",
           sheetName = "Tweet", row.names = FALSE)