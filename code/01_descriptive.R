library(here)
here::i_am("code/01_descriptive.R")

library(dplyr)
library(gtsummary)
library(labelled)
library(readr)

data2 <- readRDS(file = here::here("output/data_clean.rds"))

var_label(data2) <- list(
  Stratification2 = "Race/Ethnicity",
  Data_Value = "Heart Disease Mortality Rate(per 100,000 population",
  GeographicLevel = "Geographic_Level",
  Stratification1 = "Sex"
)

data2 <- data2 %>%
  mutate(mortality_group = ifelse(Data_Value > median(Data_Value, na.rm = TRUE), "High", "Low"))

table_one<-data2 |>
  select("Stratification2", "mortality_group", "GeographicLevel") |>
  tbl_summary(by = mortality_group) |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Mortality rate per 100,000 population**") |>
  add_overall() |>
  add_p()

saveRDS(
  table_one,
  file = here::here("output/table_one.rds")
)
