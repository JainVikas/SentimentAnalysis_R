#25-5-2017||Vikas jain || vikasjain081291@live.com
#Sentiment analysis on #IndiaFirstNoCompromise hashtag following Arundhattt's comments on Indian Army.
#over a sample to 10000 tweets.

library(twitteR)
library(ROAuth)
library(tm)
library(dplyr)
library(syuzhet)
library(ggplot2)

setup_twitter_oauth('Azah0mdcPDrFv9oiPHIGoivYT','0SJPCLyIWM8aiVJ0Kemzw6SwZcDb3QvWWRwGszP0DZH8fEsSL0',
                   '3326095525-YTkP0LLXEZb9cT8PqzxdOyE7CBRQCdETF2tZu3o', 'rSwzXrIu6yJZw7F8ZJwyMFe8nmZIQKXvQt8ftJs4PZxzR')

IndiaFirstNoCompromise<-  twListToDF(searchTwitteR('#IndiaFirstNoCompromise',n = 10000))

q1 <- Corpus(VectorSource(IndiaFirstNoCompromise$text))
head(q1)
# Performing the Text cleaning
#To avoid duplicacy converting all to lower case tolower
q1 <- tm_map(q1, tolower)

#given that we get a lot of extra data, such as hashtag, retweet and link in it first lets remvoe stop words
q1 <- tm_map(q1, removeWords, c(stopwords("english"),"rt","IndiaFirstNoCompromise","republic"))   

#Removing punctuations
q1 <- tm_map(q1, removePunctuation)   
#inspect(q1)
# To remove punctuations on the text data

#Removing Numbers removeNumbers
q1 <- tm_map(q1, removeNumbers)   
#inspect(q1)


# removing common word endings stemDocument
q1 <- tm_map(q1, stemDocument)   

# to remove white space stripWhitespace
q1 <- tm_map(q1, stripWhitespace)   
#inspect(q1)
#Removing Stop Words as they don't add any value
#Smart is inbuilt, which gives a set of pre-defined stop words.  removeWords, stopwords("english")
q1 <- tm_map(q1, removeWords, c(stopwords("english"),"rt","IndiaFirstNoCompromise","republic"))   
#inspect(q1)
# to convert documents into text documents...this tells R to treat preprocessed document as text documents PlainTextDocument

q1 <- tm_map(q1, PlainTextDocument)   
#content of the plaintet document
q1$content$content

#extracting setiments using syuzhet package.

sentiments <- sapply(q1$content$content,get_sentiment)

qplot(sentiments)
