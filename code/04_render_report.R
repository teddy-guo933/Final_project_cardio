here::i_am("code/04_render_report.R")

library(rmarkdown)
render(
  here::here("Cardiovascular.Rmd"),
  output_file = here::here("output", "final_report.html"),
  params = list(production = TRUE)
)