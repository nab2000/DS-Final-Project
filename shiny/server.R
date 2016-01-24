library(shiny)
library(tm)
library(RWeka)
tri <- read.csv("trigram_final.csv", stringsAsFactors=FALSE)
duo <- read.csv("duogram_final.csv", stringsAsFactors=FALSE)
uni <- read.csv("unigram_final.csv", stringsAsFactors=FALSE)
dict <- read.csv("single_word.csv")
dict <- dict[, 2:3]
dict <- dict[dict$Freq != 1, ]
dict <- dict[, 1]

shinyServer(
    function(input, output) {
            output$word <- renderText({ 
                    if (input$sent != "Input Sentence"){ 
                    sentence <- tolower(input$sent)
                    sentence <- Corpus(VectorSource(list(sentence)))
                    sentence <- tm_map(sentence, removeNumbers)
                    sentence <- tm_map(sentence, removePunctuation)
                    sentence <- tm_map(sentence, stripWhitespace)
                    sentence <- tm_map(sentence, removeWords, stopwords("english"))
                    tkn <- NGramTokenizer(sentence, Weka_control(min = 1, max = 1,delimiters = " \\r\\n\\t.,;:\"()?!"))
                    stp <- grep("meta", tkn)
                    stp <- stp -1
                    tkn <- tkn[5:stp]
                    num <- length(tkn)
                    end3 <- num -2
                    end2 <- num -1
                    for (i in 1:num) {
                            if(!any(tkn[i] == dict)) {tkn[i] <- "<UKN>"}
                    }
                    
                    word <- NULL
                    if (num == 1) { 
                            word <- uni$outcome[uni$unigram == tkn]
                            ## if the single word isn't in the unigram list it 
                            ##returns the most common word in the dictionary 
                            if (identical(word, character(0))) {
                                    word <- "will"
                            }
                        }
                    
                    if (num == 2) { 
                            word <- duo$outcome[duo$duogram == paste(tkn, collapse = " ")]
                            if (identical(word, character(0))) {
                                    word <- uni$outcome[uni$unigram == tkn]
                                    ## if the single word isn't in the unigram list it 
                                    ##returns the most common word in the dictionary 
                                    if (identical(word, character(0))) {
                                            word <- "will"
                                    }
                            }
                            }
                    
                    if (num >= 3) { 
                            word <- tri$outcome[tri$trigram == paste(tkn[end3:num], collapse = " ")]
                            if (identical(word, character(0))) {
                                    word <- duo$outcome[duo$duogram == paste(tkn, collapse = " ")]
                                    if (identical(word, character(0))) {
                                            word <- uni$outcome[uni$unigram == tkn]
                                            ## if the single word isn't in the unigram list it 
                                            ##returns the most common word in the dictionary 
                                            if (identical(word, character(0))) {
                                                    word <- "will"
                                            }
                                    }
                            }
                    }
                    
                    if (stp == 4) { word <- "will"}
                    
                    word
                    }
                    })
           
          
            output$test <- renderText({if (input$sent != "Input Sentence") {
                    input$sent}
                    })
    }
)