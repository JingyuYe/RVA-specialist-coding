library(dplyr)
library(shiny)
library(pharmaverseadam)
# reuse plotting function from question 2
source("../R/ae_plot.R")

adae <- pharmaverseadam::adae

# arm choices for shiny filter
arm_choices <- adae %>%
  distinct(ACTARM) %>%
  filter(!is.na(ACTARM), ACTARM != "Screen Failure") %>%
  arrange(ACTARM) %>%
  pull(ACTARM)

ui <- fluidPage(
  titlePanel("AE Summary Interactive Dashboard"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        "actarm",
        "Select Treatment Arm(s):",
        choices = arm_choices,
        selected = arm_choices
      )
    ),
    mainPanel(
      plotOutput("ae_plot", width = "80%", height = "1000px")
    )
  )
)

server <- function(input, output, session) {
  output$ae_plot <- renderPlot({
    req(input$actarm)
    
    adae %>%
      filter(ACTARM %in% input$actarm) %>%
      create_ae_plot() 
  })
}

# run shinyapp
shinyApp(ui, server)