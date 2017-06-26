
# load and clean the data

# configure ---------------------------------------------------------------

rm(list = ls())
source("0-config.R")


# load --------------------------------------------------------------------

# load
df_in <- iris



# explore -----------------------------------------------------------------

input <- list(Species = iris$Species[1])

app <- shinyApp(
  
  ui = fluidPage(
    # title
    h1("Chart"),
    
    fluidRow(
      column(2,
             selectInput(inputId = "Species", label = "Species",
                         choices = df_in$Species %>% 
                           unique,
                         selected = 1))
      
    ),
    
    fluidRow(
      plotOutput("chartout")
    ),
    
    fluidRow(
      dataTableOutput(outputId = "tableout")
    )
    
  ),
  
  server = function(input, output) {
    
    output$chartout <- renderPlot({
      df_in %>% 
        filter(Species == input$Species) %>% 
        ggplot(aes(x = Sepal.Length, y = Sepal.Width)) +
        geom_point() +
        ggtitle(sprintf("sepal scatterplot for %s", input$Species))
    })
    
    output$tableout <- renderDataTable({
      df_in %>% 
        filter(Species == input$Species)
    })
    
  }
  
)

runApp(app)


