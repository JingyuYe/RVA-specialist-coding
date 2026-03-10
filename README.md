# RVA-specialist-coding
This assessment includes practical coding exercises focused on clinical trial reporting in the pharmaceutical industry

## Repository Structure

- `question1/`
  - `question1.R`: creates the treatment-emergent adverse event (TEAE) summary table
  - `output/question1_teae_summary.html`: HTML output for Question 1

## Question 1

Question 1 uses `pharmaverseadam::adsl` and `pharmaverseadam::adae` to create a TEAE summary table with:

- rows by System Organ Class (`AESOC`) and Preferred Term (`AEDECOD`)
- columns by treatment arm (`ACTARM`)
- cells displayed as `n (%)`
- a top overall row for Treatment-Emergent Adverse Events
- HTML output

## Analysis Notes

- Screen Failures are excluded from the analysis population.
- TEAEs are defined as records where `TRTEMFL == "Y"`.
- Counts are based on unique subjects (`USUBJID`) within each treatment arm and event category.
- Percentages are calculated using the corresponding treatment arm denominator from `ADSL`.

## Packages Used

- `dplyr`
- `gtsummary`
- `pharmaverseadam`