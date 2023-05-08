#Ashley Smith 
#Working to combine two datasets: Pacific Ocean Data and Mental Health Data

library(dplyr)
library(stringr)

ocean_df <- read.csv("Pacific Ocean Dataset.csv")
happiness_df <- read.csv("World Happiness Report.csv")


#Let's start by grouping both datasets to accumulate by years

ocean_df <- filter(ocean_df, G2year >= 2005)
happiness_df <- filter(happiness_df, Year <= 2018)
ocean_group <- group_by(ocean_df, G2year)
clean_ocean_df <- summarize(ocean_group, avg_pressure = mean(G2pressure, na.rm = TRUE), avg_depth = mean(G2depth, na.rm = TRUE), avg_temperature = mean(G2temperature, na.rm = TRUE), avg_salinity = mean(G2salinity, na.rm = TRUE), avg_oxygen = mean(G2oxygen, na.rm = TRUE), avg_nitrate = mean(G2nitrate, na.rm = TRUE), avg_nitrite = mean(G2nitrite, na.rm = TRUE), avg_silicate = mean(G2silicate, na.rm = TRUE), avg_phosphate = mean(G2phosphate, na.rm = TRUE), avg_tco2 = mean(G2tco2, na.rm = TRUE))
happiness_group <- group_by(happiness_df, Year)
clean_happiness_df <- summarize(happiness_group, avg_life_ladder = mean(Life.Ladder, na.rm = TRUE), avg_log_gdp_per_cap = mean(Log.GDP.Per.Capita, na.rm = TRUE), avg_social_support = mean(Social.Support, na.rm = TRUE), avg_health_life_expectancy = mean(Healthy.Life.Expectancy.At.Birth, na.rm = TRUE), avg_freedom_to_make_life_choices = mean(Freedom.To.Make.Life.Choices, na.rm = TRUE), avg_generosity = mean(Generosity, na.rm = TRUE), avg_perceived_corruption = mean(Perceptions.Of.Corruption, na.rm = TRUE), avg_positive_affect = mean(Positive.Affect, na.rm = TRUE), avg_confidence_in_gov = mean(Confidence.In.National.Government, na.rm = TRUE))

df_summary <- merge(x = clean_happiness_df, y = clean_ocean_df, by.x="Year", by.y="G2year", all=TRUE)

df <- merge(x = happiness_df, y = clean_ocean_df, by.x="Year", by.y="G2year", all.x=TRUE)

pacific_states <- str_detect(df$Country.Name, "Chile|Ecuador|Peru|Papua New Guinea|Japan|Australia|United States")
new_cat_df <- mutate(df, Is_Pacific_Country = pacific_states)

affect_diff <- df$Positive.Affect - df$Negative.Affect
new_cont_df <- mutate(new_cat_df, Difference_In_Affect = affect_diff)

final_df <- new_cont_df

write.csv(final_df, "C:/Users/ashsm/Downloads/Final_Clean_DF.csv")

