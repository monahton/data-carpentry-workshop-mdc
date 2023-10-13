

# Recap -------------------------------------------------------------------

# load libraries
library(tidyverse)

# load the dataset
surveys <- read_csv("data/portal_data_joined.csv")

# inspect the data
str(surveys)
colnames(surveys)
summary(surveys)

# subsetting
# df[row_index, column_index]

surveys[1,2:6]



# Selecting columns and filtering rows ------------------------------------

# check the help page of select
?select

select(surveys, plot_id, species_id, weight)

# remove columns
select(surveys, -record_id, -plot_id)
surveys_new <- select(surveys, -record_id, -plot_id)

# subset rows based on a criterion
filter(surveys, year == 1994)
filter(surveys, year !=  1977)


## filter and select at the same time

surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)
View(surveys_sml)

# to remove an object from environment
rm(surveys2)

# Pipes -------------------------------------------------------------------

surveys_sml2 <- surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

# to write a pipe (%>%): click on Ctrl + Shift +M
# Cmd + Shift + Mac

surveys_1995 <- surveys %>% 
  filter(year == 1995) %>% 
  select(year, sex, weight)



# Mutate ------------------------------------------------------------------

surveys_kg <- surveys %>% 
  mutate(weight_kg = weight / 1000)

surveys_kg_lb <- surveys %>% 
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2)

surveys_kg_0.2 <- surveys %>% 
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>% 
  filter(weight_kg < 0.2)


surveys_kg <- surveys %>% 
  mutate(weight_kg = weight / 1000)



# Handling missing values -------------------------------------------------

is.na(surveys$weight)

surveys_kg <- surveys %>%
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000)



# Exercise
# Create a new data frame from the surveys data that meets the following criteria: 
#   - contains only the species_id column and a new column called hindfoot_cm containing the hindfoot_length values (currently in mm) converted to centimeters. 
# - In this hindfoot_cm column, there are no NAs and all values are less than 3


surveys_exercise <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_cm = hindfoot_length / 10) %>% 
  filter(hindfoot_cm < 3) %>% 
  select(species_id, hindfoot_cm)



# Reshaping data ----------------------------------------------------------

mean(surveys$weight, na.rm = TRUE)

# split-apply-combine

# group_by()
# summarise()

surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys_mean_species <- surveys %>% 
  group_by(species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE))

# remove NAs then group_by and summarise
surveys %>% 
  filter(!is.na(weight)) %>% 
  filter(!is.na(sex)) %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight))


# group_by sex and species_id
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight))

surveys_sex_speciesid <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight))


# group_by sex and species_id, and summarise the mean, min and max

surveys_sex_speciesid <-  surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight), 
            min_weight = min(weight),
            maxi_weight = max(weight))
  
# arrange the min_weight column
surveys_sex_speciesid <-  surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight), 
            min_weight = min(weight),
            maxi_weight = max(weight)) %>% 
  arrange(min_weight)


# arrange the min_weight column by descing order
surveys_sex_speciesid <-  surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight), 
            min_weight = min(weight),
            maxi_weight = max(weight)) %>% 
  arrange(desc(min_weight))

# arrange the mean_weight column by descing order
surveys_sex_speciesid <-  surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight), 
            min_weight = min(weight),
            maxi_weight = max(weight)) %>% 
  arrange(desc(mean_weight))


# count the occurence of a value in the sex column

surveys %>% 
  group_by(sex) %>%
  summarise(count = n())


# or

surveys %>% 
  count(sex, sort = TRUE)


surveys %>% 
  count(sex, species)
  

# Challenge
# 1. How many animals were caught in each plot_type surveyed?
# 2. Use group_by() and summarize() to find the mean, min, and max hindfoot length for each species (using species_id). Also add the number of observations.
# 3. What was the heaviest animal measured in each year? Return the columns year, genus, species_id, and weight.


## Solution

#1.
surveys %>% 
  count(plot_type)


#2.
surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(species_id) %>% 
  summarise(mean_hindfoot = mean(hindfoot_length),
            min_hindfoot = min(hindfoot_length),
            max_hindfoot = max(hindfoot_length),
            n = n())


#3.

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(year) %>%
  filter(weight == max(weight)) %>% 
  select(year, genus, species, weight) %>% 
  arrange(year)

surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  summarise(max_weight = max(weight))



## Pivot wide and long

# pivor from long to wide
surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(plot_id, genus) %>% 
  summarise(mean_weight = mean(weight))


surveys_gw_wide <- surveys_gw %>% 
  pivot_wider(names_from = genus,
              values_from = mean_weight)


# pivor from wide to long

surveys_long <- surveys_gw_wide %>% 
  pivot_longer(names_to = "genus",
               values_to = "mean_weight",
               cols = -plot_id)




# Creating Functions ------------------------------------------------------

my_function <- function(parameters) {
  # perform something
  # do something
  # give ame an output
}


# create a function that convert a temperature from fahr to kelvin

fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

# convert 100 from fahrenheit to kelvin
fahr_to_kelvin(100)

fahr_to_kelvin <- function(temp) {
  stopifnot(is.numeric(temp))
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

fahr_to_kelvin(100)
fahr_to_kelvin(surveys)


# create a function that gives you the heaviest animal from a dataframe

heaviest_animal <- function(dataframe) {
  stopifnot(is.data.frame(dataframe))
  new_df <- dataframe %>% 
    filter(!is.na(weight)) %>% 
    group_by(year) %>% 
    filter(weight == max(weight)) %>% 
    select(year, genus, species, weight) %>% 
    arrange(year)
  return(new_df)
} 

heaviest_animal(my_name_is_monah)

# to load your function in other rstudio or new sessions
source("scripts/heaviest_animal.R")








