library(dplyr)
library(ggplot2)

create_ae_plot <- function(data) {
  ae_data <- data %>%
    filter(
      ACTARM != "Screen Failure",
      !is.na(USUBJID),
      !is.na(AESOC),
      !is.na(AESEV)
    ) %>%
    distinct(USUBJID, AESOC, AESEV)
  
  soc_order <- ae_data %>%
    count(AESOC) %>%
    arrange(n) %>%
    pull(AESOC)
  
  ae_data <- ae_data %>%
    mutate(
      AESOC = factor(AESOC, levels = soc_order),
      AESEV = factor(AESEV, levels = c("SEVERE", "MODERATE", "MILD"))
    )
  
  ggplot(ae_data, aes(x = AESOC, fill = AESEV)) +
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
}