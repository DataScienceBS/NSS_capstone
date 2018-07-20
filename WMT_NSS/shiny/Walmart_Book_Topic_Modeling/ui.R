library(shiny)
library(shinythemes)


shinyUI(fluidPage(theme = shinytheme("flatly"),
           
#  titlePanel("Topic Modeling with Walmart Books"),
  
  # Sidebar with a slider input for number of bins 
navbarPage(" Walmart Books",
  tabPanel("Background",
           uiOutput("background")
           ),
  tabPanel("Topic Sizes",
           sidebarLayout(
             column(3,sidebarPanel(
               radioButtons("topic_size_selection",
                           "Topic Size: ",
                           choiceNames = c("12","17","20","23","25","28","30","32","35","37"),
                           choiceValues = c("12","17","20","23","25","28","30","32","35","37"),
                           selected = "12")
             )),
             
             # Show a plot of the generated distribution
             column(9,mainPanel(
               htmlOutput("topic_selected_html")
             )
           ))),
  tabPanel("Topic WordClouds",
    sidebarLayout(
      sidebarPanel(
         sliderInput("topic",
                     "Topics:",
                     min = 1,
                     max = 30,
                     value = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       imageOutput("prepareImage")
    )
  )
))
)
)