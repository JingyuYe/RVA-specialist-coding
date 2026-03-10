library(dplyr)
library(ggplot2)
library(pharmaverseadam)

# Prepare data: one record per subject per SOC per severity
ae_data <- pharmaverseadam::adae %>%
  filter(
    ACTARM != "Screen Failure",
    !is.na(USUBJID),
    !is.na(AESOC),
    !is.na(AESEV)
  ) %>%
  distinct(USUBJID, AESOC, AESEV)

# Order SOCs by increasing total frequency
soc_order <- ae_data %>%
  count(AESOC) %>%
  arrange(n) %>%
  pull(AESOC)

ae_data <- ae_data %>%
  mutate(
    AESOC = factor(AESOC, levels = soc_order),
    AESEV = factor(AESEV, levels = c("SEVERE", "MODERATE", "MILD"))
  )

# Create stacked bar chart
severity_chart <- ggplot(ae_data, aes(x = AESOC, fill = AESEV)) +
  geom_bar() +
  coord_flip() +
  scale_fill_manual(
    values = c(
      "MILD" = "#FFE4E1",
      "MODERATE" = "#FFA07A",
      "SEVERE" = "#E31A1C"
    ),
    breaks = c("MILD", "MODERATE", "SEVERE"),
    name = "Severity"
  ) +
  labs(
    title = "Unique Subjects per SOC and Severity Level",
    x = "System Organ Class",
    y = "Number of Unique Subjects",
    fill = "AE Severity"
  ) +
  theme_minimal()

# save output
ggsave(
  "question2/output/question2_ae_severity_plot.png",
  plot = severity_chart,
  width = 15,
  height = 8,
  dpi = 300
)
