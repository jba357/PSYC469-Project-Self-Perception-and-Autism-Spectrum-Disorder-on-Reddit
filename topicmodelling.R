

########### IMPORTANT NOTE ###########

# I wanted to create a topic model for both of my sets of data, but I did not get any interesting results from either of my topic models. Most of the words were prepositions or interjections.
# I tried restricting the number of topics and also filtering out common words that did not provide any interest, but this did not help.
# However, I wanted to still include the script as it was part of my process and it works, even if the results are not of interest to my study.



# I will load the necessary packages.
library(stringr)
library(quanteda)
library(readr)
library(tidyr)

# First, I will load the CSV file that I need, which I created earlier by filtering out posts that do not contain I or me.
autisminwomen_filtered <- read_csv("C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\autisminwomen_filtered.csv")

# I am now setting it as a data frame
autisminwomen_filtered <- data.frame(autisminwomen_filtered)


# Next, I am removing posts which are too short, as topic modelling works better the text it is using is longer.


# I will count the words in the column combined_text_title using the function str_count() and store this information in a new column.
autisminwomen_filtered$combined_text_title_nwords <- str_count(autisminwomen_filtered$combined_text_title, "\\w+")

# I am subsetting the data so that the subset only includes texts with 20 or more words, using the subset() function.
autisminwomen_filtered_long <- subset(autisminwomen_filtered, combined_text_title_nwords >= 20)


# I will now set the combined_text_title column as a character variable using the function as.character()
autisminwomen_filtered$combined_text_title <- as.character(autisminwomen_filtered$combined_text_title)

# Tokenisation breaks down text into smaller components or words, called tokens. In this step, I am also removing removing superfluous details: punctuation, numbers, and URLs.
tokens <- autisminwomen_filtered$combined_text_title %>%
  tokens(what = "word",
         remove_punct = TRUE,
         remove_numbers = TRUE,
         remove_url = TRUE) %>%
  tokens_tolower() %>%
  tokens_remove(stopwords("english"))


# Now I am making a document-feature matrix, which represents the frequency of words that occur in the text.
dfm <- tokens %>%
  dfm()
summary(dfm)

# We can now examine the 20 most common words in our text.
topfeatures(dfm, n = 20, scheme = "docfreq") 

# I will remove further terms that do not provide meaning.
dfm <- dfm_remove(dfm, c(">", "_", "=", "<")) 


# Now, I will load the package I need for topic modelling.
library(stm)

# The dfm needs to be converted into a recognisable format for the stm package to process.
dfm_stm <- convert(dfm, to = "stm")

# I want to know how many topic is optimal for my topic model. Therefore, we need to find the appropriate level of K. 
fit <- searchK(dfm_stm$documents, dfm_stm$vocab, K = c(6,8,10), verbose = TRUE)

# Now, we can examine the fit statistics for our model, aiming to maximise semantic coherence and exclusivity.
fit$results 
plot(fit) # This provides a visual representation of the fit statistics for our model.





####### Now, I will repeat these steps using the data I scraped from r/Autism. ########



# First, I will load the CSV file that I need, which I created earlier by filtering out posts that do not contain I or me in my r/Autism dataset.
autism_filtered <- read_csv("C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\autism_filtered.csv")

# Next, I am removing posts which are too short, as topic modelling works better the text it is using is longer.

# I will count the words in the column combined_text_title using the function str_count() and store this information in a new column.
autism_filtered$combined_text_title_nwords <- str_count(autism_filtered$combined_text_title, "\\w+")

# I am subsetting the data so that the subset only includes texts with 20 or more words, using the subset() function.
autism_filtered_long <- subset(autism_filtered, combined_text_title_nwords >= 20)


# I will now set the combined_text_title column as a character variable using the function as.character()
autism_filtered$combined_text_title <- as.character(autism_filtered$combined_text_title)

# Tokenisation breaks down text into smaller components or words, called tokens. In this step, I am also removing removing superfluous details: punctuation, numbers, and URLs.
tokens <- autism_filtered$combined_text_title %>%
  tokens(what = "word",
         remove_punct = TRUE,
         remove_numbers = TRUE,
         remove_url = TRUE) %>%
  tokens_tolower() %>%
  tokens_remove(stopwords("english"))

# Now I am making a document-feature matrix, which represents the frequency of words that occur in the text.
dfm <- tokens %>%
  dfm()
summary(dfm)


# We can now examine the 20 most common words in our text.
topfeatures(dfm, n = 20, scheme = "docfreq") 

# I will remove further terms that do not provide meaning.
dfm <- dfm_remove(dfm, c(">", "_", "=", "<")) 


# Now, I will load the package I need for topic modelling.
library(stm)

# The dfm needs to be converted into a recognisable format for the stm package to process.
dfm_stm <- convert(dfm, to = "stm")

# I want to know how many topic is optimal for my topic model. Therefore, we need to find the appropriate level of K. 
fit <- searchK(dfm_stm$documents, dfm_stm$vocab, K = c(6,8,10), verbose = TRUE)

# Now, we can examine the fit statistics for our model, aiming to maximise semantic coherence and exclusivity.
fit$results
plot(fit) # This provides a visual representation of the fit statistics for our model.

