#install.packages(c("pharmaverseadam", "tidyverse", "gtsummary", "ggplot2", "shiny"))
library(dplyr)
library(gtsummary)
library(pharmaverseadam)

# Load data
adsl <- pharmaverseadam::adsl
adae <- pharmaverseadam::adae

# clean adsl data to remove "Screen Failure"
adsl <- adsl %>% filter(ACTARM != "Screen Failure")

# calculate treatment arm Ns for column headers
arm_n <- adsl %>%
  distinct(USUBJID, ACTARM) %>%
  filter(!is.na(ACTARM)) %>%
  count(ACTARM, name = "N")

# TEAE records
# Keep one record per subject / arm / SOC / PT to avoid duplicate counting
teae <- adae %>%
  filter(
    TRTEMFL == "Y",
    !is.na(ACTARM),
    !is.na(AESOC),
    !is.na(AEDECOD),
    !is.na(USUBJID)
  ) %>%
  distinct(USUBJID, ACTARM, AESOC, AEDECOD)

# build gtsummary table
tbl_q1 <- teae %>%
  tbl_hierarchical(
    variables = c(AESOC, AEDECOD),
    by = ACTARM,
    id = USUBJID,
    denominator = adsl, # arm-specific denominators from ADSL
    overall_row = TRUE,
    statistic = everything() ~ "{n} ({p}%)",
    digits = everything() ~ c(p = 1),
    label = list(
      AESOC = "System Organ Class",
      AEDECOD = "Preferred Term",
      ..ard_hierarchical_overall.. = "Treatment-Emergent Adverse Events"
    )
  ) %>%
  modify_header(label = "**System Organ Class / Preferred Term**",
                stat_1 = paste0("**", arm_n$ACTARM[1], "**  \nN = ", arm_n$N[1]),
                stat_2 = paste0("**", arm_n$ACTARM[2], "**  \nN = ", arm_n$N[2]),
                stat_3 = paste0("**", arm_n$ACTARM[3], "**  \nN = ", arm_n$N[3])) %>% # add to the N
  bold_labels()

# export to HTML
tbl_q1 %>%
  as_gt() %>%
  gt::gtsave("question1/output/question1_teae_summary.html")

