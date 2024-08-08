################################################################################
################################# SET-UP #######################################
################################################################################

library(tidyverse)


################################################################################
############################## IMPORTING DATA ##################################
################################################################################


################################ MENTAL HEALTH TABLE ###########################

s10ai <- read_csv("data/S10AI.csv") %>% 
  select(hhmid, hhno, depressed, depression, s1d_1, s1d_2, s1d_4i) %>% 
  unite("id", hhno, hhmid, sep = "") %>% 
  select(id, kessler_score = depressed, depression_group = depression, sex = s1d_1,
         rship_to_hh_head = s1d_2, age = s1d_4i) %>% 
  mutate(age_group = case_when(
    
    age <= 17 ~ "child",
    age <= 34 ~ "young_adult",
    age <= 49 ~ "adult",
    age <= 64 ~ "middle_age",
    TRUE ~ "senior"
    
    
  )) %>% 
  mutate(depression_dummy = case_when(
    
    depression_group > 1 ~ "depressed"
    TRUE ~ "not_depressed"
    
  )) %>% 
  filter()


################################# HEALTH TABLE #################################

s6g <- read_csv("data/S6G.csv") %>% 
  select(hhno, hhmid, s6g_1, s6g_4)

################################ HOUSEHOLD TABLES ##############################

# Water table  

s12ai <- read_csv("data/S12AI.csv") %>% 
  select(id4, hhno, 
         s12a_9i, # Main source of drinking water
         s12a_10ai, # Distance of drinking water source
         s12a_10aii # Distance unit
        )

# Electricity and sewerage table

s12aii <- read_csv("data/S12AII") %>% 
  select(hhno, hhid,
         s12b_14, # Does your house have electricity?
         s12b_23 # Is there any open sewer,drain in/around the house?
    
  )



################################################################################
############################## DESCRIPTIVE STATS ###############################
################################################################################

