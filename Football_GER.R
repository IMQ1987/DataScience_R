#http://www.football-data.co.uk/data.php
#http://www.football-data.co.uk/notes.txt
devtools::install_github('jalapic/engsoccerdata', username = "jalapic")
library(engsoccerdata)
library(ggplot2)
library(nycflights13)
library(dplyr)
library(reshape2)
# https://www.r-bloggers.com/reshape-and-aggregate-data-with-the-r-package-reshape2/
library(GGally) # erstellen von scatterplot matrix um einen ersten eindruck zu erhalten
# danach ggpairs mit GGally nutzen um diesen zu erstellen
library(corrplot) # plotten von allen Korrelationen#
library(glmnet)

dim(flights)
dim(weather)
names(weather)
names(flights)
setwd("/Users/malte.quast/Documents/R/")


#flights$hour so wie in weather daten um den join zu vollziehen!
flights$hour <- ifelse(flights$hour == 24, 0, flights$hour)
#hier werden zwei tabellen gejoint und dadurch werden
#Joining, by = c("year", "month", "day", "origin", "hour", "time_hour")
verbunden
flights_weather <- left_join(flights, weather)

flights_weather$arr_delay <- ifelse(flights_weather$arr_delay >= 0,
                                    flights_weather$arr_delay, 0)
flights_weather$dep_delay <- ifelse(flights_weather$dep_delay >= 0,
                                    flights_weather$dep_delay, 0)
flights_weather$total_delay <- flights_weather$arr_delay + flights_weather$dep_delay
cor_data <- select(flights_weather, total_delay, temp, dewp, humid,
                   wind_dir, wind_speed, wind_gust, precip, pressure, visib)
corrplot(cor(na.omit(cor_data)), method = "circle", type = "upper",
         tl.srt = 25, tl.col = "Black", tl.cex = 1, title = "Correlation
         between all 'weather' variables & 'delay'", mar =c(0, 0, 4, 0) + 0.1)



data <- flights %>%  
  select(origin, month, day ,arr_delay, dep_delay) %>% 
  filter(arr_delay >= 0, dep_delay >= 0) %>%
  group_by(origin, month, day) %>%
  summarise(avg_delay =  mean(arr_delay, na.rm = TRUE) + 
              mean(dep_delay, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(-avg_delay)
head(data, 3)

data$date <- with(data, ISOdate(year = 2013, month, day))
g <- ggplot(data, aes(x = data$date, y = data$avg_delay, title = "Seasonality Trends"))
g + geom_point(aes(color = data$origin)) + xlab("Date") + ylab("Average Delay (mins)")

par(mfrow=c(2,2))

ggpairs(flights[,1:9])
plot(flights$sched_dep_time, flights$dep_delay)
hist(flights$dep_delay)
hist(flights$dep_time)
ggplot(flights, aes(x = flights$sched_dep_time , y = flights$dep_delay) )  
    + geom_point(alpha = 1/20) 
    +  geom_smooth(color = "green") 
    + geom_line(stat = 'summary', fun.y = median, color = 'blue') 
    + xlim(500, 2400) + ylim(0,500) 
    + xlab("Scheduled Departure Time") 
    + ylab("Departure Delay")

flights$date <- with(flights, ISOdate(year = 2013, month, day))
ggplot(flights, aes(x = flights$date, y = flights$dep_delay, title = "Seasonality Trends")) + geom_point()

summary(flights$dep_time)

??corrplot

#lm(I(log(x))  tilde I(y^(1/3))

#qplot(x, y, data=, color=, shape=, size=, alpha=, geom=, method=, formula=, facets=, xlim=, ylim= xlab=, ylab=, main=, sub=)

x <- data(package="engsoccerdata")    # lists datasets currently available

y <- read.csv2("D1.csv",sep = ",", header=T, dec = ".")

length(y$HomeTeam[y$HomeTeam == "Werder Bremen" & y$FTR == "H"])
length(y$HomeTeam[y$HomeTeam == "Werder Bremen" & y$FTR == "A"])

qplot(c(1:17), y$HomeTeam[y$HomeTeam == "Werder Bremen"])


y$B365H[y$HomeTeam == "Werder Bremen"] - y$BWH[ y$HomeTeam == "Werder Bremen"]

y$B365A[y$AwayTeam == "Werder Bremen"]

