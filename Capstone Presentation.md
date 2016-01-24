Capstone Project Presentation
========================================================
author: Nicholas Rose
date: January 23, 2016

Project Goal
========================================================

The goal of this project was to develop an application that allowed the user to provide an input in the form of an uncompleted sentence and for the application to predict the next word in the sentence.

The development process involved:

- Cleaning the data to prepare it for formatting
- Breaking the training data set into n-grams for algorithm development
- Developing an algorithm for predicting the next word
- Designing a shiny application to implement the algorithm



Data Cleaning Process
========================================================

The first step in the application development process was to obtain data and get it into a useable format (data cleaning). The data was obtained from [HC Corpa] (http://www.corpora.heliohost.org) and consisted of entries/stories from news, blogs and twitter. 

A random sample of 1% of the data was selected to be the training data set. The data was converted to all lower case letters. Then the data was cleaned with the tm package to remove the following: 

- Numbers
- Punctuation
- White Spaces
- English stop words (i.e. common words)



N-gram Development
========================================================
Following the cleaning of the data, it was further processed to develop 1-, 2-, 3-, and 4-grams. As an example a sentence "This is a test sentence" turned into 2-grams would be "this is", "is a", "a test", and "test sentence". 

The frequency of 1-grams was counted and the collection of words that appeared more than once was turned into a dictionary. The 2-, 3-, and 4- grams were split into individual words. Any word not in the dictionary was turned into "UKN". This allowed the algorithm to predict words that were not in the training set.    


Algorithm Development
========================================================

Following the generation of N-grams, a predictive algorithm was developed. First, the split n-grams were combined back into n-grams plus the next word. For example, the 4-gram "this is a test" was combined into the 3-gram "this is a" and the outcome "test". 

The next step was to examine each unique n-gram and look at the frequency of different outcomes for that n-gram. Continuing our example, the 3-gram "this is a" could have had the outcomes test (5), movie (3), video (2). A 2-column table was developed with the n-gram and the most frequent outcome. In our example it would be "this is a" and "test". These 1-, 2-, and 3-gram outcome tables were used to predict the next word in the series.    

The Shiny Application
========================================================

The [shiny application] (https://nab2000.shinyapps.io/Data_Science_Capstone/) was developed with a user interface allowing for the input of a sentence and a submit button to ensure the user submitted the sentence they wanted before running the application. 

The shiny application then processed the given input using the same steps as the data cleaning and n-gram development.

The number of words was used to compare it to the respective outcome table, with the last 3 words used for longer sentences.  If the unique n-gram combination wasn't in the output table a smaller n-gram was evaluated. If none of the n-gram combinations were in the outcome table(s), then the most frequently used word (will) was given.  
