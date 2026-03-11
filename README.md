# RVA-specialist-coding
This assessment includes practical coding exercises focused on clinical trial reporting in the pharmaceutical industry

## Repository Structure

- `R/`
  - `ae_plot.R`: reusable function that prepares AE data and generates the severity stacked bar chart used in Question 2 and Question 3

- `question1/`
  - `question1.R`: creates the treatment-emergent adverse event (TEAE) summary table
  - `output/question1_teae_summary.html`: HTML output for Question 1

- `question2/`
  - `question2.R`: generates a stacked bar chart showing adverse event distribution by System Organ Class and Severity
  - `output/question2_ae_severity_plot.png`: PNG output for Question 2

- `question3/`
  - `app.R`: interactive Shiny application that visualizes the AE severity chart with a treatment arm filter


# Question 1

## Overview
Creates a Treatment-Emergent Adverse Event (TEAE) summary table using `pharmaverseadam::adsl` and `pharmaverseadam::adae`.
- HTML output

## Implementation

- Screen Failures are excluded from the analysis population.
- TEAEs are defined as records where `TRTEMFL == "Y"`.
- Counts are based on unique subjects (`USUBJID`) within each treatment arm and event category.
- Percentages are calculated using the corresponding treatment arm denominator from `ADSL`.


# Question 2

## Overview
Creates a stacked bar chart visualizing adverse events by System Organ Class and severity level using `pharmaverseadam::adae`.

## Implementation

- The visualization logic is implemented through the reusable function `create_ae_plot()` located in `R/ae_plot.R`.
- Screen Failures are excluded from the analysis population.
- Each subject (`USUBJID`) is counted at most once per severity level within each System Organ Class (`AESOC`).
- Bars are stacked by severity level (`AESEV`).
- System Organ Classes are ordered by increasing total frequency of unique subjects.
- Visualization is implemented using `ggplot2`.


# Question 3

## Overview
Creates an interactive Shiny dashboard that displays the adverse event severity visualization from Question 2.

## Implementation Details

- Uses `pharmaverseadam::adae` as the input dataset.
- Allows users to filter the visualization by treatment arm (`ACTARM`).
- The plot updates reactively based on the selected treatment arms.
- The visualization logic is reused through the shared function `create_ae_plot()` in `R/ae_plot.R`.

## Packages Used

- `dplyr`
- `gtsummary`
- `pharmaverseadam`
- `ggplot2`
- `shiny`