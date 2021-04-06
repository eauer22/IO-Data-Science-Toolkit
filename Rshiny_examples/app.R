# load libraries
library(shiny)
library(tidyverse)
library(peopleanalyticsdata)

# read in fake data from peopleanalyticsdata package (https://cran.r-project.org/web/packages/peopleanalyticsdata/index.html)

# create composites for items with some added noise
data <- peopleanalyticsdata::employee_performance


# Define UI ---------------------------------------------------------------


ui <- fluidPage(# Application title
    titlePanel("Employee Performance Data"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            varSelectInput(
                "grouping_var",
                "Choose a grouping variable:",
                data = select(data, gender, `region`)
            )
            ,
            varSelectInput(
                "survey_var",
                "Choose a survey variable:",
                data = select(data, rating, sales , new_customers)
                
            )
        )
        ,
        
        # Show a plot based on selected variable
        mainPanel(plotOutput("Plot"))
    ))


# Define Server Logic -----------------------------------------------------

server <- function(input, output) {
    output$Plot <- renderPlot({
        summarized_data <- data %>% group_by(!!input$grouping_var) %>%
            summarize(mean = mean(!!input$survey_var))
        ggplot(
            summarized_data,
            aes(!!input$grouping_var, mean, fill = !!input$grouping_var)
        ) +
            geom_bar(stat = "identity") +
            theme_classic() 
    })
}
# Run the Application -----------------------------------------------------

shinyApp(ui = ui, server = server)
