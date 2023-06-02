library(dplyr)
library(stringr)
library(ggplot2)
library(shiny)
library(plotly)

df <- read.csv("Final_Clean_DF.csv")
new_df <- df[, c("Year", "Life.Ladder", "Social.Support", "Freedom.To.Make.Life.Choices", "avg_temperature", "avg_oxygen", "avg_tco2")]
new_df <- group_by(new_df, Year, avg_temperature, avg_oxygen, avg_tco2)
avg_df <- summarize(new_df, life_ladder = mean(Life.Ladder, na.rm=TRUE), social_support = mean(Social.Support, na.rm=TRUE), freedom = mean(Freedom.To.Make.Life.Choices, na.rm=TRUE))
avg_df$avg_temperature <- (1.8*avg_df$avg_temperature) + 32
avg_df$life_ladder <- 10*avg_df$life_ladder
avg_df$social_support <- 100*avg_df$social_support
avg_df$freedom <- 100*avg_df$freedom
avg_df$avg_tco2 <- avg_df$avg_tco2 / 10

colnames(avg_df) <- c("Year", "Ocean Temperature", "Oxygen Levels", "CO2 Levels", "Life Ladder", "Social Support", "Freedom")


filter_choice_df <- data.frame(filter_choices = c("All", "Ocean Temperature", "Silicate Levels", "Nitrate Levels", "Life Ladder", "Social Support", "Freedom"))


data_05 <- filter(avg_df, Year == 2005)
data_05 <- as.data.frame(t(data_05))
data_05$Categories <- rownames(data_05)
data_05 <- subset(data_05, V1 < 1000 )

data_18 <- filter(avg_df, Year == 2018)
data_18 <- as.data.frame(t(data_18))
data_18$Categories <- rownames(data_18)
data_18 <- subset(data_18, V1 < 1000)

column_names <- colnames(avg_df)
df_new <- data.frame(Variable = rep(column_names, each = nrow(avg_df)),
                     Value = as.vector(t(avg_df)))
df_long <- tidyr::gather(avg_df, key = "Variable", value = "Value", -Year)

