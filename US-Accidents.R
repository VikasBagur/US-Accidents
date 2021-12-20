library(tidyverse)
us_accidents <- read_csv("C:/Users/vikas/Desktop/My files/Course/Alex the Analyst - SQL course/US Accidents/Dataset/US_Accidents_Dec20_updated.csv")

head(us_accidents)

# 1. Which US state has the highest number of accidents

high_state <- group_by(us_accidents, State) %>% 
  summarise(no_of_accidents = n()) %>% 
  arrange(-no_of_accidents)

head(high_state)

# 2. Which US state had the highest number of accidents with severity 3 or 4
severe_34 <- us_accidents %>% 
  filter(Severity == "3" | Severity == "4") %>% 
  select(State) %>% 
  group_by(State) %>% 
  summarise(no_of_accidents_34 = n()) %>% 
  arrange(-no_of_accidents_34)
head(severe_34)

# 3. Percentage of accidents with severity 3 & 4 in each state compared to all the accidents in the US with severity 3 & 4

severe_34_per <- us_accidents %>% 
  filter(Severity == "3" | Severity == "4") %>% 
  select(State) %>% 
  group_by(State) %>% 
  summarise(no_of_accidents_34 = n()) %>% 
  mutate(percent = no_of_accidents_34 * 100 / sum(no_of_accidents_34)) %>% 
  arrange(-no_of_accidents_34)
head(severe_34_per)


# 4. Description and count of Top 10 accidents with severity 3 and 4 in CA.

severe_describe <- us_accidents %>% 
  filter(Severity == "3" | Severity == "4", State == "CA") %>% 
  select(State, Description) %>% 
  group_by(Description) %>% 
  summarise(no_of_accidents_desc = n()) %>% 
  arrange(-no_of_accidents_desc) %>% 
  slice(1:10)
view(severe_describe)

# 5. Next we have to find the time at which most accidents occur with severity 3 and 4

#Extracting hour from the Start_Time column and converting it into an integer for future calculations.

us_accidents$hours <- format(as.POSIXct(us_accidents$Start_Time),format = "%H")

us_accidents$hours <- as.integer(us_accidents$hours)
str(us_accidents)

#Converting 24hour time format to 12 hour time format
severe_time <- us_accidents %>% mutate(starting_hour_ampm = case_when(
  (hours - 12) > 0 ~ paste(hours - 12, "PM"),
  (hours - 12) == -12 ~ paste("12 AM"),
  (hours - 12) < 0 ~ paste(hours, "AM"),
  (hours - 12) == 0 ~ paste(hours, "PM"))) %>% 
  filter(Severity == "3" | Severity == "4", State == "CA") %>% 
  select(starting_hour_ampm) %>% 
  group_by(starting_hour_ampm) %>% 
  summarise(no_of_accidents_time = n()) %>% 
  arrange(-no_of_accidents_time)

head(severe_time)

#Since the above conversion is needed for the next set of codes, I'm adding a new column with the 12hour format data to the original dataset us_accidents
us_accidents <- mutate(us_accidents,starting_hour_ampm = case_when(
  (hours - 12) > 0 ~ paste(hours - 12, "PM"),
  (hours - 12) == -12 ~ paste("12 AM"),
  (hours - 12) < 0 ~ paste(hours, "AM"),
  (hours - 12) == 0 ~ paste(hours, "PM")))

select(us_accidents, starting_hour_ampm)

#6 At what time of day does 'At I-605 - Accident' occur most

severe_34_description <- us_accidents %>% 
  filter(Severity == "3" | Severity == "4", State == "CA", Description == 'At I-605 - Accident.') %>% 
  group_by(starting_hour_ampm) %>% 
  summarise(no_of_occurance = n()) %>% 
  arrange(-no_of_occurance, starting_hour_ampm)

view(severe_34_description)

#7 Find the description and count of accident with Severity 3 and 4 during the hours of commute. 

severe_34_commute <- us_accidents %>% 
  filter(Severity == "3" | Severity == "4", State == "CA", starting_hour_ampm %in% c('6 AM','7 AM','8 AM','9 AM','2 PM','3 PM','4 PM','5 PM','6 PM')) %>% 
  group_by(Description, starting_hour_ampm) %>% 
  summarise(no_of_occurance = n()) %>% 
  arrange(-no_of_occurance, starting_hour_ampm)

head(severe_34_commute, 10)