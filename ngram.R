## Import libraries
library(knitr)
library(quanteda)

## Import data
twit <- readLines("~/Desktop/final/en_US/twitter.txt", encoding = "UTF-8", skipNul = TRUE)
blog <- readLines("~/Desktop/final/en_US/blogs.txt", encoding = "UTF-8", skipNul = TRUE)
news <- readLines("~/Desktop/final/en_US/news.txt", encoding = "UTF-8", skipNul = TRUE)

## Set the seed
set.seed(456)

## Sample the data
sample <- sample(c(twit, news, blog), 500000, replace = FALSE)

## Remove non-ASCII characters
sample <- iconv(sample, "UTF-8", "ASCII", sub="")

## Clean the text
sample <- gsub("[[:punct:]]", "", sample) # removing special characters
sample <- gsub("http.* *", "", sample) # removing urls
sample <- gsub("\\d", "", sample) # removing numbers

## Create document-term matrices
dfm2 <- dfm(sample, ngrams = 2, verbose = FALSE, concatenator = " ")
dfm3 <- dfm(sample, ngrams = 3, verbose = FALSE, concatenator = " ")
dfm4 <- dfm(sample, ngrams = 4, verbose = FALSE, concatenator = " ")
dfm5 <- dfm(sample, ngrams = 5, verbose = FALSE, concatenator = " ")

## Get frequencies of each word
dfm2 <- as.data.frame(as.matrix(docfreq(dfm2)))
dfm3 <- as.data.frame(as.matrix(docfreq(dfm3)))
dfm4 <- as.data.frame(as.matrix(docfreq(dfm4)))
dfm5 <- as.data.frame(as.matrix(docfreq(dfm5)))

## Sort by frequency
dfm2 <- sort(rowSums(dfm2), decreasing=TRUE)
dfm3 <- sort(rowSums(dfm3), decreasing=TRUE)
dfm4 <- sort(rowSums(dfm4), decreasing=TRUE)
dfm5 <- sort(rowSums(dfm5), decreasing=TRUE)

## Create data frames for future plots
dfm2 <- data.frame(word = names(dfm2), freq = dfm2, row.names = 1:length(dfm2))
dfm3 <- data.frame(word = names(dfm3), freq = dfm3, row.names = 1:length(dfm3))
dfm4 <- data.frame(word = names(dfm4), freq = dfm4, row.names = 1:length(dfm4))
dfm5 <- data.frame(word = names(dfm5), freq = dfm5, row.names = 1:length(dfm5))

## Convert "word" variables to character class
dfm2$word <- as.character(dfm2$word)
dfm3$word <- as.character(dfm3$word)
dfm4$word <- as.character(dfm4$word)
dfm5$word <- as.character(dfm5$word)

## Save the data with frequencies
saveRDS(dfm2, "dfm2Freq.RData")
saveRDS(dfm3, "dfm3Freq.RData")
saveRDS(dfm4, "dfm4Freq.RData")
saveRDS(dfm5, "dfm5Freq.RData")

## Convert data to list
dfm2 <- strsplit(dfm2$word, " ")
dfm3 <- strsplit(dfm3$word, " ")
dfm4 <- strsplit(dfm4$word, " ")
dfm5 <- strsplit(dfm5$word, " ")

## Convert list to data frames
dfm2 <- data.frame(matrix(unlist(dfm2), nrow = 2981782, byrow = TRUE), stringsAsFactors = FALSE)
dfm3 <- data.frame(matrix(unlist(dfm3), nrow = 7130898, byrow = TRUE), stringsAsFactors = FALSE)
dfm4 <- data.frame(matrix(unlist(dfm4), nrow = 9201126, byrow = TRUE), stringsAsFactors = FALSE)
dfm5 <- data.frame(matrix(unlist(dfm5), nrow = 9504291, byrow = TRUE), stringsAsFactors = FALSE)

## Adjust columns
dfm2 <- data.frame(phrase = dfm2[,1], word = dfm2[,2])
dfm3 <- data.frame(phrase = paste(dfm3[,1], dfm3[,2], sep = " "), word = dfm3[,3])
dfm4 <- data.frame(phrase = paste(dfm4[,1], dfm4[,2], dfm4[,3], sep = " "), word = dfm4[,4])
dfm5 <- data.frame(phrase = paste(dfm5[,1], dfm5[,2], dfm5[,3], dfm5[,4], sep = " "), word = dfm5[,5])

## Remove duplicated rows but keep the row with the first observation
dfm2 <- dfm2[!duplicated(dfm2$phrase),]
dfm3 <- dfm3[!duplicated(dfm3$phrase),]
dfm4 <- dfm4[!duplicated(dfm4$phrase),]
dfm5 <- dfm5[!duplicated(dfm5$phrase),]

## Save the data without frequencies in data frame format
saveRDS(dfm2, "dfm2.RData")
saveRDS(dfm3, "dfm3.RData")
saveRDS(dfm4, "dfm4.RData")
saveRDS(dfm5, "dfm5.RData")
