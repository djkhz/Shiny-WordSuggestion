## Description

* Author: Darius Kharazi
* Date: July 31, 2018  
* [GitHub URL](https://github.com/dkharazi/Shiny-WordSuggestion)
* [Presentation URL](http://rpubs.com/dariuskharazi/408948)
* [Shiny App](https://dariuskharazi.shinyapps.io/WordSuggestion)

## Overview

The Coursera Data Science Specialization Capstone project from Johns Hopkins University allows 
students to create a usable public data product that can show their skills to potential 
employers. Projects are drawn from real-world problems and are conducted with industry, government, 
and academic partners. In this part of course, Johns Hopkins University is partnering with SwiftKey 
(https://swiftkey.com/) to apply data science in the area of natural language processing.

The goal of this exercise is to create a product that deals with natural language processing in some way. The application needs to include a user-implemented prediction algorithm and an interface that can be accessed by others. I decided to create a Shiny app that receives an input phrase in a text box input and outputs a prediction of the next word. The prediction algorithm is based on an N-gram model with "Stupid Backoff" ([Brants et al 2007](http://www.cs.columbia.edu/~smaskey/CS6998-0412/supportmaterial/langmodel_mapreduce.pdf)). The algorithm checks to see if the highest-order (in this case, n=5) n-gram has been seen. If the highest-order is not applicable, the predicted word will "degrade" to a lower-order model (n=4, then 3, then 2). For additional prediction accuracy, common linguistic tweaks were implemented, as well.

## Dataset

The underlying dataset for this word prediction app was gathered from three sources:

* Blogs
* News
* Twitter

The original english corpus combined over 580 MB of language information. Which summed up to over half a billion characters. After processing the data our model consists out of **millions of ngram tokens**.

Dataset: [NLP Data](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) [580 MB]

## The 6-Step Process

  1. Getting the data
  2. Data splitting
  3. Data cleaning and tokenization
  4. Building n-gram model
  5. Building predictive model
  6. Building shiny app
  
## Running the App

To use the Shiny app, simply run the Shipy app server from the Shiny directory or URL. In order to run the Shiny app locally, you will need to build your own prediction model. In order to do this, run the "app.R" file and configure the directories for the "dfm2," "dfm3," "dfm4," and "dfm5" variables within the script. If you would like a step-by-step process of preprocessing the data, building the prediction model, and using it for example phrase, go to the rmarkdown file and configure the "data" directories, as noted. To generate the cleaned data locally, run the "n-gram.R" file.

## Additional Information

All R scripts, files, presentations, etc. in this repository are materials for the capstone project of the Coursera Data Science specialization held by professors of the Johns Hopkins University and in cooperation with SwiftKey. Learn more about the Coursera Data Science Specialization: [https://www.coursera.org/specialization/jhudatascience](https://www.coursera.org/specialization/jhudatascience).
