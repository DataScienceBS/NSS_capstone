library(shiny)
library(shinythemes)
library(highcharter)

shinyUI(fluidPage(theme = shinytheme("flatly"),
                                    
#  titlePanel("Topic Modeling with Walmart Books"),
  
  # Nav Bar with side panel and main panels 
navbarPage(" Walmart Books",
  tabPanel("Background",
           uiOutput("background")
           ),
  
  tabPanel("Model Performance",
           fluidRow(
             column(4,
                    p(),
                    ("The performance of each topic was graded on two metrics, coherence and perplexity. See below for the technical details, but essentially you want a higher coherence and lower perplexity. Perplexity is a measure of how well the model describes a set of documents."), 
                    p(), 
                    ("As shown in the chart, a model with 30 topics resulted in the best performance. All models in this visual performed with either 40,000 or 50,000 chunksize and 50 passes using the gensim LDA model. Since this model appeared to perform best, word clouds were generated for each topic in this model to give a better visual.")),
             column(8,
                    highchartOutput("performance"))),
           fluidRow(
             column(4,
                    h3("Coherence score calculation:"),
                    tags$ul(),
                    tags$li("t : Topics coming in from the topic model"),
                    tags$li(" S : Segmented topics"),
                    tags$li("P : Calculated probilities"),
                    tags$li("Phi vector : A vector of the “confirmed measures” coming out from the confirmation module"),
                    tags$li("c : The final coherence value"),
                    "Source: ", tags$a(href = "http://svn.aksw.org/papers/2015/WSDM_Topic_Evaluation/public.pdf", "Exploring the Space of Topic Coherence Measures (pdf)")
             ),
             column(8,
                    imageOutput("coherenceImage"))
           )),
  
  
  tabPanel("Topic Sizes",
                fluidRow(
                  h3("Select the number of topics you wish to categorize Walmart's book catalog:"),
                  br(),
                  column(1,
                         radioButtons("topic_size_selection",
                             "Topic Size: ",
                             choiceNames = c("12","15","17","20","23","25","28","30","32","35","37"),
                             choiceValues = c("12","15","17","20","23","25","28","30","32","35","37"),
                             selected = "30")
               ),
               # Display the pyLDAvis HTML file
                      column(11,
                        htmlOutput("topic_selected_html")
                   )
           )),
  
  tabPanel("Topic WordClouds",
    fluidRow(
      h4("Word clouds shown are for a 30-topic model, where size represents that words contribution to that topic. Color is purely aesthetic."),
      column(3,
         sliderInput("topic",
                     "Topic Cluster:",
                     min = 1,
                     max = 30,
                     value = 1)
    ),
    
    # Display word clouds for selected topic number
    column(9,
       imageOutput("prepareImage")
    )
  )
))
)
)