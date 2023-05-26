library(dplyr)
library(stringr)
library(ggplot2)
library(shiny)
library(plotly)

df <- read.csv("Final_Clean_DF.csv")
new_df <- df[, c("Year", "Life.Ladder", "Social.Support", "Freedom.To.Make.Life.Choices", "avg_temperature", "avg_oxygen", "avg_nitrate")]
#new_df$life_ladder <- mean(df$Life.Ladder, na.rm=TRUE)
#new_df$social_support <- mean(df$Social.Support, na.rm=TRUE)
#new_df$generosity <- mean(df$Generosity, na.rm=TRUE)
new_df <- group_by(new_df, Year, avg_temperature, avg_oxygen, avg_nitrate)
avg_df <- summarize(new_df, life_ladder = mean(Life.Ladder, na.rm=TRUE), social_support = mean(Social.Support, na.rm=TRUE), freedom = mean(Freedom.To.Make.Life.Choices, na.rm=TRUE))
data_05 <- filter(avg_df, Year == 2005)
