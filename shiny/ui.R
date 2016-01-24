library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Data Science Capstone Project: Word Prediction"),
    sidebarPanel(
        h3("Input a word or sentence"),
        textInput("sent", NULL, value = "Input Sentence"),
        submitButton('Submit'),
        tags$div(class="header", checked=NA,
                 tags$p("For more details on how this app was developed check out the"),
                 tags$a(href="http://.html", "presentation"))
    ),
    mainPanel(
            h3("Your Sentence:"),
           verbatimTextOutput('test'),
           h3("Your next word is:"),
           verbatimTextOutput('word')
    )
))