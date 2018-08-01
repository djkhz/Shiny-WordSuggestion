## Import libraries
library(shiny)

## Import data
dfm2 <- readRDS("./data/dfm2.RData")
dfm3 <- readRDS("./data/dfm3.RData")
dfm4 <- readRDS("./data/dfm4.RData")
dfm5 <- readRDS("./data/dfm5.RData")

## Define UI
ui <- fluidPage(
   
   ## Application title
   titlePanel("Word Suggestion"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        textInput("phrase",
                  "Phrase:",
                  "Enter a phrase here")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        h4("Suggested word:"),
        textOutput("word")
      )
   )
)

## Define server logic
server <- function(input, output) {
   
  ## Clean the phrase
  predictedNextWord <- reactive({
    
    ## Clean input text
    phrase <- gsub("\\d", "", input$phrase) # removing numbers
    phrase <- gsub("[[:punct:]]", "", phrase) # removing special characters
    phrase <- gsub("\\s+", " ", phrase) # removing extra spaces
    phrase <- tolower(phrase) # removing capital letters
    
    ## Get number of words in the phrase
    phrase <- strsplit(phrase, " ")[[1]]
    nWords <- length(phrase)
    
    ## Get the last four or less words in the phrase
    #phrase <- tail(phrase, n = 4)
    phrase <- tail(phrase, n = 2)
    
    ## Convert to a string
    phrase <- paste(phrase, collapse = " ")
    
    ## Predict the next word given a phrase
    if (nWords == 0) {
      "the" # most common unigram
    } else if (nWords == 1) {
      dfm2[dfm2$phrase == phrase,][1,2]
    } else if (nWords == 2) {
      dfm3[dfm3$phrase == phrase,][1,2]
    } else if (nWords == 3) {
      dfm4[dfm4$phrase == phrase,][1,2]
    } else {
      dfm5[dfm5$phrase == phrase,][1,2]
    }
  })
  
  ## Output suggested word
  output$word <- renderText({
    predictedNextWord()
  })
}

## Run application 
shinyApp(ui = ui, server = server)

