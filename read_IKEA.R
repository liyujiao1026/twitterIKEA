setwd("./Desktop/twitter_Ikea/")
library(dplyr)

dataIKEA <- read.csv("./Aug_IKEA_all_0903.csv",sep = ',',header = T)
dim(dataIKEA)
options(scipen = 100)


summary(dataIKEA$user_location)

city = names(sort(table(dataIKEA$user_location), decreasing = T))[-1]

stockholm_th <- which( sapply(X = city, FUN = function(x){grep("stockholm",tolower(x))}) == 1)
gothenburg_th_en <- which(sapply(X = city, FUN = function(x){grep("gothenburg",tolower(x))}) == 1)
gothenburg_th_sv <- which(sapply(X = city, FUN = function(x){grep("göteborg",tolower(x))}) == 1)
gothenburg_th <- c(gothenburg_th_en, gothenburg_th_sv)


#sweden_th <- which(sapply(X = city, FUN = function(x){grep("sweden",tolower(x))}) == 1)


stockholm_names <- names(stockholm_th)
stockholm_users <- which(dataIKEA$user_location %in% stockholm_names)

gothenburg_names <- names(gothenburg_th)
gothenburg_users <- which(dataIKEA$user_location %in% gothenburg_names)

length(stockholm_users)
length(gothenburg_users)
dataIKEA$tweet_created_at <- as.Date(dataIKEA$tweet_created_at)

ikea <- dataIKEA[c(stockholm_users, gothenburg_users),]
dim(ikea)
write.csv(ikea, "TwitterIKEA2.csv", row.names = F)

#===============#
twitterData2 <- read.csv("TwitterIKEA2.csv")

Stockholm_attention <- table(twitterData2$tweet_created_at[1:length(stockholm_users)])

Gothenburg_attention <- table(twitterData2$tweet_created_at[(length(stockholm_users) + 1):nrow(ikea)])


plot(Stockholm_attention, type = "l", ylab = "IKEA_tweets_count")
lines(Gothenburg_attention, type = "l", lty = 2)
legend("topleft", lty = c(1,2), legend = c("Stockholm" , "Gothenburg"))
# Stockholm_attention <- table(twitterData$tweet_created_at[1:length(stockholm_users)])
# Gothenburg_attention <-table(twitterData$tweet_created_at[(length(stockholm_users) + 1):nrow(twitterData)])
# 

#===============#
















