
library(shiny)

shinyServer(function(input, output) {

  output$prepareImage <- renderImage({
    filename <- normalizePath(file.path('./images',
                                        paste('topic_', input$topic, '.png', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste("Topic number ", input$topic))
    
  }, deleteFile = FALSE)

  #preparing HTML files for display
  htmlname <- function(){
    return(includeHTML(paste0("html/vis_",input$topic_size_selection,".html")))
  }
  output$topic_selected_html <- renderUI({htmlname()})
  
  output$background <- renderUI({
    HTML(paste(h3("Project Phases:"), br(),
               h4("Data Collection"),  
               "The goal of this project was to access Walmart's Online Catalog using the ", tags$a(href = "https://developer.walmartlabs.com/", "Walmart Open API"), ". Because of the API limitations of 5,000 calls per day, I set this up in R so that I could run it daily in the background while working with small datasets separately in Python. Through data exploration, I identified the Book category ID and setup a process to loop through 1,285 book subcategories across the 50 main categories. This allowed for me to get a comprehensive list of titles for topic modeling.", br(),  

               h4("Data Cleaning"),  
               "Data cleansing required ", br(),

               h4("Topic Modeling"),  
               "modeling the models. How many topics? chunksize? runtime? passes?", br(),
               
               h4("Displaying Results"),
               "pyLDAvis, wordclouds, shiny, exploration abilities", br(),
               
               h4("Packages Used"),
               "jsonlite, gensim, nltk, spacy, matplotlib, shiny", br(),
               
               hr(),
               h3("Other Information:"),
               tags$a(href = "https://www.github.com/DataScienceBS", "DataScienceBS Github Account"),
               br(),
               tags$a(href = "https://www.linkedin.com/in/BSanders21", "Brandon Sanders LinkedIn"),
               br(),
               tags$a(href = "http://nashvillesoftwareschool.com", "Nashville Software School")))

    
  })
  
})
