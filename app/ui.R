library(shiny)
library(readr)
subject_ids = read_csv("subject_ids.csv", col_types = cols(x = col_integer()))[[1]]

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("The ALS Prognosis Predictor"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    selectInput("subject_ID", "Choose a subject", subject_ids, selected = 13165L),
    width = 2
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    
    tabsetPanel(type = "tabs",
                id = "tabs",
                tabPanel(
                  "Overview",
                  textOutput("instructions1"),
                  tags$hr(),
                  textOutput("subject_summary"),
                  p(),
                  textOutput("instructions1.5"),
                  plotOutput(
                    "all_symptoms", 
                    height = "400px",
                    click = "showTab", 
                    hover = "decimal"
                  )
                ),
                tabPanel(
                  "Daily Tasks", 
                  selectInput("symptom", 
                              label = "Choose a daily task", 
                              c("Speech", "Salivation", "Swallowing", "Handwriting", "Cutting/eating food", 
                                "Dressing and hygiene", "Turning in bed", "Walking", "Climbing stairs", 
                                "Respiratory")),
                  h3(textOutput("h3")), 
                  textOutput("instructions2"),
                  plotOutput(
                    "distPlot", 
                    hover = hoverOpts("symptom_hover", delay = 50),
                    height = "400px"
                  ),
                  htmlOutput("description")
                ),
                tabPanel(
                  "About this app",
                  textOutput("About")
                )
    ),
    width = 10
  )
))