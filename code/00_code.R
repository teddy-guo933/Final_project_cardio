library(here)
here::i_am("code/00_code.R")

library(dplyr)
library(labelled)

data_url <- "https://data.cdc.gov/api/views/jiwm-ppbh/rows.csv?accessType=DOWNLOAD"
data <- read.csv(data_url, header = TRUE)

var_label(data) <- list(
  Stratification2 = "Race/Ethnicity",
  Data_Value = "Heart Disease Mortality Rate(per 100,000 population",
  GeographicLevel = "Geographic_Level",
  Stratification1 = "Sex"
)

data2 <- data %>%
  mutate(mortality_group = ifelse(Data_Value > median(Data_Value, na.rm = TRUE), "High", "Low"))

saveRDS(
  data2, 
  file = here::here("output/data_clean.rds")
)