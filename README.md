# RVA-specialist-coding
This assessment includes practical coding exercises focused on clinical trial reporting in the pharmaceutical industry

## Repository Structure

- `question1/`
  - `question1.R`: creates the treatment-emergent adverse event (TEAE) summary table
  - `output/question1_teae_summary.html`: HTML output for Question 1
  
- `question2/`
  - `question2.R`: creates a stacked bar chart showing adverse event distribution by System Organ Class and Severity
  - `output/question2_ae_severity_plot.png`: PNG output for Question 2

# Question 1

## Overview
Creates a Treatment-Emergent Adverse Event (TEAE) summary table using `pharmaverseadam::adsl` and `pharmaverseadam::adae`.
- HTML output

## Implementation

- Screen Failures are excluded from the analysis population.
- TEAEs are defined as records where `TRTEMFL == "Y"`.
- Counts are based on unique subjects (`USUBJID`) within each treatment arm and event category.
- Percentages are calculated using the corresponding treatment arm denominator from `ADSL`.

---

# Question 2

## Overview
Creates a stacked bar chart visualizing adverse events by System Organ Class and severity level using `pharmaverseadam::adae`.

## Implementation

- Screen Failures are excluded from the analysis population.
- Each subject (`USUBJID`) is counted at most once per severity level within each System Organ Class (`AESOC`).
- Bars are stacked by severity level (`AESEV`).
- System Organ Classes are ordered by increasing total frequency of unique subjects.
- Visualization is implemented using `ggplot2`.

---

## Packages Used

- `dplyr`
- `gtsummary`
- `pharmaverseadam`
- `ggplot2`