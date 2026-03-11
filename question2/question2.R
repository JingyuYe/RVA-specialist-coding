library(pharmaverseadam)
source("R/ae_plot.R")

severity_chart <- create_ae_plot(pharmaverseadam::adae)

# save output
ggsave(
  "question2/output/question2_ae_severity_plot.png",
  plot = severity_chart,
  width = 15,
  height = 8,
  dpi = 300
)
