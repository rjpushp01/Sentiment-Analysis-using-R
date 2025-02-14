install.packages('tm')            # for text mining
install.packages('SnowballC')     # for text stemming (It is an NLP method of reducing word to its base form, [running - run])
install.packages('wordcloud')     # for word cloud generation
install.packages('RColorBrewer')  # for colour palettes of word map etc.
install.packages('syuzhet')       # for sentiment analysis
install.packages('ggplot2')       # plotting graphs

# Loading all the libraries
library('tm')
library('SnowballC')
library('RColorBrewer')
library('wordcloud')
library('syuzhet')
library('ggplot2')

data <- read.csv('/home/pushp-raj/R/NLP Script/kindle_review.csv')

'Data Preprocessing'

# Loading VCOrpus (It is a large collection of text data, serves dataset for analyzing patterns (sentiment in this case))
text_doc = VCorpus(VectorSource(data$reviewText))

# Getting the number of columns
length(data)  # 4

# Getting all the column names
colnames(data)  # "X"   "rating"   "reviewText"  "summary"   

head(data,2)

# function(x,pattern) takes x and pattern as input parameter and gsub finds pattern in x and replace it with " ".
tospace <- content_transformer(function(x,pattern)gsub(pattern,' ',x))
text_doc <- tm_map(text_doc,tospace,'/')
text_doc <- tm_map(text_doc,tospace,'@')
text_doc <- tm_map(text_doc, tospace, "\\\\")  # '\' is an escape character,so '\\' is required as well as again used to escape the backslash

# Now we will try to reduce the complex text statements to simpler versions of them so that it can be easily processed

# Convert the text to lower case (no change in meanings)
text_doc <- tm_map(text_doc,content_transformer(tolower))

# remove nos. (not influence the sentiments a lot)
text_doc <- tm_map(text_doc, removeNumbers)

# remove punctuations
text_doc <- tm_map(text_doc, removePunctuation)

# remove common stopwords in English (the,it,is,in,and etc. which don't carry significant meanings)
text_doc <- tm_map(text_doc,removeWords, stopwords('en'))

# Remove extra white spaces
text_doc <- tm_map(text_doc,stripWhitespace)

# Converting words to base form (sentiment can be understood by base form itself [I am run fast - grammatically incorrect but sentiment understood])
# text stemming
text_doc <- tm_map(text_doc, stemDocument)

'Exploratory Data Analysis'

# Frequency table of different words to get the trending topics (Term Document Matrix)
text_doc_docmat <- TermDocumentMatrix(text_doc)
tdmat_m <- as.matrix(text_doc_docmat)

# Sorting by decreasing value of frequency
tdmat_f <- sort(rowSums(tdmat_m), decreasing = TRUE)
tdmat_d <- data.frame(word = names(tdmat_f), freq = tdmat_f)

head(tdmat_d,10) # book and stori are 2 highest used words

# plotting top 5 most frequent words (barplot)
barplot(tdmat_d[1:5,]$freq, width = 4, space =0.2, names.arg = tdmat_d[1:5,]$word, main = '5 most frequent words',
        xlab = 'Words', ylab = 'word frequency', col = "#FF5733")

# Pie chart
par(mar = c(6,5,3,4))
pie(tdmat_d[1:5,]$freq, labels = tdmat_d[1:5,]$word, edges = 250, radius = 1, 
    col = rainbow(length(tdmat_d[1:5,]$freq)), main = 'Top 5 most frequent words')

# Generating word cloud
set.seed(152)
wordcloud(words=tdmat_d$word, freq = tdmat_d$freq, min.freq = 3, max.words = 100, random.order = FALSE, 
          colors = brewer.pal(8,'Dark2'))

'Final Model'

# Association of words with given words (similar to correlation)
findAssocs(text_doc_docmat, terms = c("book","stori","read","one","like"), corlimit = 0.25)

# Sentiment Scores
syuzhet_vector <- get_sentiment(data$reviewText, method="syuzhet")

head(syuzhet_vector)
summary(syuzhet_vector)
# The scale for sentiment scores using syuzhet ranges from -1(-ve sentiment) to +1(+ve sentiment)
# Median is 1.6 > 0, this can be interpreted as overall response is +ve

'Other methods'
# bing (binary scale -> -1/+1 for -ve and +ve resp.)
bing_vector <- get_sentiment(data$reviewText, method="bing")
head(bing_vector)
summary(bing_vector)

#affin (integer scale from -5 to +5 [on a scale of 10 type])
afinn_vector <- get_sentiment(data$reviewText, method="afinn")
head(afinn_vector)
summary(afinn_vector)

#compare the first row of each vector using sign function
rbind(sign(head(syuzhet_vector)), sign(head(bing_vector)),sign(head(afinn_vector)))

# Emotion Classification
# get nrc sentiment analysis: classifies each row of reviews into 8 emotions
#     anger, anticipation, disgust, fear, joy, sadness, surprise, trust
d <- get_nrc_sentiment(data$reviewText)
head(d,10)

'Final Results'
# transpose matrix
d_t <- data.frame(t(d))

# Get the count of each emotion by calculating row sum of each column
d_t_new <- data.frame(rowSums(d_t[2:253]))

# Transformation & Cleaning
names(d_t_new)[1] <- "count"
d_t_new  <- cbind("sentiment" = rownames(d_t_new), d_t_new)
rownames(d_t_new) <- NULL
d_t_new2<-d_t_new[1:8,]

# Plot of count of words for each sentiment
quickplot(sentiment,data = d_t_new2, weight=count, 
          geom="bar", fill=sentiment, ylab="count")+ggtitle("Kindle Survey sentiments")


#Plot two - count of words associated with each sentiment, expressed as a percentage
barplot(
  sort(colSums(prop.table(d[, 1:8]))), 
  horiz = TRUE, 
  cex.names = 0.7, 
  las = 1, 
  main = "Emotions in Text", xlab="Percentage"
)







