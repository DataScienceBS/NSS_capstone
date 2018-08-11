library(shiny)
library(dplyr)
library(highcharter)


shinyServer(function(input, output) {

#### coherence img ####
  output$coherenceImage <- renderImage({
    coherencefile <- paste('./www/coherence.png')
    
    list(src = coherencefile,
         alt = ("Coherence Model"))
    
  }, deleteFile = FALSE)
  
  
#### displaying word cloud ####
  output$prepareImage <- renderImage({
    filename <- paste('./www/topic_', input$topic, '.png', sep='')
  
    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste("Topic number ", input$topic))
    
  }, deleteFile = FALSE)

#### topic performance chart ####
  topics <- c(12, 15, 17, 20, 23, 25, 28, 30, 32, 35, 37)
  coherence <- c(0.5871,0.5617,0.5948, 0.5968, 0.6016, 0.5992, 0.5800, 0.6272, 0.5840, 0.5780,0.6055)
  perplexity <- c(-8.6743,-8.6584,-8.6600,-8.6538,-8.6508,-8.6222,-8.6175,-8.6095,-8.6117,-8.6202,-8.6380)
  
  
  hc <-  highchart() %>% 
    hc_title(text = "Model performance for a given number of topics") %>% 
    hc_yAxis_multiples(
      list(lineWidth = 3, title = list(text = "Coherence")),
      list(opposite = TRUE, title = list(text = "Perplexity"))
    ) %>% 
    hc_add_series(data = coherence, name = "Coherence", color="blue") %>% 
    hc_add_series(data = perplexity, name = "Perplexity", color="black", type = "spline", yAxis = 1) %>% 
    hc_xAxis(categories = topics, title = list(text = "Number of topics in the trained model")) %>% 
    hc_add_theme(hc_theme_elementary())
  
    
  output$performance <- renderHighchart({hc})
    
  
#### displaying pyLDAvis HTML files ####
  observe({
  htmlname <- paste0("vis_",input$topic_size_selection,".html")
  
  output$topic_selected_html <- renderUI({
    tags$iframe(seamless="seamless",src=htmlname, height=800, width='100%', frameborder="0", scrolling="no")
    })
  })
  
#### text for background section ####
  output$background <- renderUI({
    HTML(paste(h3("Walking through the project"), br(),
               
               h4("Overview"),
               "Topic modeling was used to group books of common words and themes into similar categories using the long description of book titles. This long description can range from 3 words to paragraphs, and may include foreign language titles.", br(), br(),
               
               h4("Data Collection"),  
               "To accomplish the goal of this project, the ", tags$a(href = "https://developer.walmartlabs.com/", "Walmart Open API"), " was used to access Walmart's Online Catalog. Because of the API limitations of 5,000 calls per day and 25 results per call, an R script was created to run daily title collections in the background while working with small datasets separately in Python. Through data exploration, the Book category ID was identified and used to loop through 1,285 book subcategories across 50 main categories. This allowed for a comprehensive list of titles to be generated for topic modeling across a wide array of subject categories. The resulting dataset included over 250,000 obervations.", br(), br(), 

               h4("Data Cleaning"),  
               "There wasn't a huge need for data cleansing, just simple RegEx to remove html, convert contractions to words, and remove extra spaces. The text was also put in entire lowercase and duplicate records were removed. The duplicates were expected as some titles naturally fall into more than one topic (history + biography or memoirs, Law + Business + Education), and the API calls did indeed return titles with overlapping categories. This is expected to be reflected in topic modeling visuals.", br(),br(),

               h4("Topic Modeling"),  
               "Topic modeling for this project became more of an art form than scientific process. How many topics should we consider? What chunksize is best for a good mix of speed and accuracy? What's an acceptable runtime? How many passes should the model be trained? Was 250k obsesrvations too large?", p(),
               "The first few model attempts with the full dataset were only about an hour of processing, using gensim's ldamodel. THEN, I found LdaMultiCore, and quickly realized more processor power definitely sped up the modeling process. BUT, I had concerns. I decided to calculate coherence values, and while the bigger datasets definitely improved, the LdaMulticore models were significantly worse than the LdaModel.", p(),
               "In the end, the best performing model was 30 topics (from a dataset containing 40 topics), with a chunksize of 50,000 and 50 passes. The final scores were a coherence value of 0.627 and perplexity of -8.609. Total runtime was between 2-3 hours. Reducing the passes to 20 saved significant time (slightly over 1 hour) with minimal change in the scoring.", p(),               
               br(),
               
               h4("Displaying Results"),
               "Topic modeling gives insight on the salient words that help define common docs. pyLDAvis is an incredible package for visualizing the differences between topics, and it's completely interactive with only 2 lines of code. I decided to use word clouds to help visualize the topics, which is where I discovered pyLDAvis re-orders the topics and my word clouds weren't lining up. Reading through the documentation, a recent addition to the package included the sort_topics option to easily remedy this. Throwing the various topic sizes into a shiny app seemed like the best approach for giving the user ability to explore the data and determine the best application of topic modeling.", br(),br(),
               
               h4("Packages Used"),
               tags$ul(
                 tags$li("jsonlite"),
                 tags$li("gensim"),  
                 tags$li("nltk"),  
                 tags$li("spacy"), 
                 tags$li("shiny"), 
                 tags$li("matplotlib"), 
                 tags$li("pyLDAvis"), 
                 tags$li("WordCloud")
                  ),
               hr(),
               # h3("Other Information:"),
               tags$a(href = "https://www.github.com/DataScienceBS", "DataScienceBS Github Account"),
               br(),
               tags$a(href = "https://www.linkedin.com/in/BSanders21", "Brandon Sanders LinkedIn"),
               br(),
               tags$a(href = "http://nashvillesoftwareschool.com", "Nashville Software School"),
               br(),
               br()
    ))
    
    
  })
  
})
