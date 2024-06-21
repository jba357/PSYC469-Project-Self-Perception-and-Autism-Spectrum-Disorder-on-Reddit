

# I will first load the necessary packages

library(readr)
library(dplyr)
library(syuzhet)
library(tidyr)
library(ggplot2)
library(tidyverse)

# Now, I will use the read.csv() function to load the data I previously scraped from r/autisminwomen and set it as a dataframe
autisminwomen = read.csv("C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\reddit_posts_comments_women.csv")

# I will now use the filter() function to filter for rows in my dataframe which contain either "I" or "me" in the title or text column. This is because I am interested in self-perceptio, and this will give me posts relevant to my research question. 
# The grepl() function checks if a specific pattern, in this case the words "I" or "me", exists in a string.
autisminwomen_filtered <- autisminwomen %>% filter(grepl('I|me', title, text))

View(autisminwomen_filtered) #Now, we can view our filtered dataframe.

write.csv(autisminwomen_filtered, "C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\autisminwomen_filtered.csv")


# Next, I will repeat these steps with data from r/Autism.


# I will use the read.csv() function to load the data I previously scraped from r/Autism and set it as a dataframe
autism = read.csv("C:\\Users\\Jamil\\OneDrive\\Desktop\\Autismpsyc460project\\reddit_posts_comments_general.csv")


# I will now use the filter() function to filter for rows in my dataframe which contain either "I" or "me" in the title or text column. This is because I am interested in self-perceptio, and this will give me posts relevant to my research question. 
# The grepl() function checks if a specific pattern, in this case the words "I" or "me", exists in a string.
autism_filtered <- autism %>% filter(grepl('I|me', title, text))

View(autism_filtered) # Now, we can view our filtered dataframe

write.csv(autism_filtered, "C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\autism_filtered.csv")


# Now, I want to conduct a sentiment analysis. I will begin with r/AutismInWomen.


# I will create a column that combines both the title and text of the posts in order to conduct a sentiment analysis on both aspects.
autisminwomen_filtered$combined_text_title <- paste(autisminwomen_filtered$title, autisminwomen_filtered$text, sep = " ")

# Now I am using the function get_nrc_sentiment(), which analyses sentiment using the NRC dictionary.
nrc_autisminwomen <- get_nrc_sentiment(autisminwomen_filtered$combined_text_title)

# This provides the sentiment analysis in terms of raw scores, but for the purpose of this study I would prefer to have percentages.
# Therefore, I will convert these to percentage scores.
nrc_autisminwomen_detected_percentage <- nrc_autisminwomen/rowSums(nrc_autisminwomen)

View(nrc_autisminwomen_detected_percentage) 

# In order to run analyses on my data, I must remove rows in which there are NaN values. This is achieved using the function na.omit()
nrc_autisminwomen_detected_percentage <- na.omit(nrc_autisminwomen_detected_percentage)

# I will save the file as a CSV.
write.csv(nrc_autisminwomen_detected_percentage, "C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\nrc_autisminwomen_detected_percentage.csv") # We will use this later!


# These steps will be repeated for r/Autism.


# Create a column that combines both the title and text of the posts in order to conduct a sentiment analysis on both aspects.
autism_filtered$combined_text_title <- paste(autism_filtered$title, autism_filtered$text, sep = " ")

# Now I am using the function get_nrc_sentiment(), which analyses sentiment using the NRC dictionary.
nrc_autism <- get_nrc_sentiment(autism_filtered$combined_text_title)

# This provides the sentiment analysis in terms of raw scores, but for the purpose of this study I would prefer to have percentages.
# Therefore, I will convert these to percentage scores.
nrc_autism_detected_percentage <- nrc_autism/rowSums(nrc_autism)
View(nrc_autism_detected_percentage) 

# In order to run analyses on my data, I must remove rows in which there are NaN values. This is achieved using the function na.omit()
nrc_autism_detected_percentage <- na.omit(nrc_autism_detected_percentage) 

write.csv(nrc_autism_detected_percentage, "C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\nrc_autism_detected_percentage.csv") # This will also be used later.


# Next, I want to run several analyses on each data set, so that they can be compared.


# First, I will calculate the means of each data set, starting with r/autisminwomen and create a dataframe that contains this information.
autisminwomen_sentiment_means <- colMeans(nrc_autisminwomen_detected_percentage)
autisminwomen_sentiment_means <- data.frame(autisminwomen_sentiment_means)
View(autisminwomen_sentiment_means)
write.csv(autisminwomen_sentiment_means, "C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\autisminwomen_sentiment_means.csv") # Saving as a CSV

# Now, the r/autism data set.
autism_sentiment_means <- colMeans(nrc_autism_detected_percentage)
autism_sentiment_means <- data.frame(autism_sentiment_means)
View(autism_sentiment_means)
write.csv(autism_sentiment_means, "C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\autism_sentiment_means.csv") # Saving as a CSV


data_autisminwomen <- read.csv("C:\\Users\\Jamil\\OneDrive\\Desktop\\Autismpsyc460project\\autisminwomen_sentiment_means.csv")

# Rename columns for easier reference
colnames(data_autisminwomen) <- c("Sentiment", "Mean")

# Repeat for r/Autism
data_autism <- read.csv("C:\\Users\\Jamil\\OneDrive\\Desktop\\Autismpsyc460project\\autism_sentiment_means.csv")

# Rename columns for easier reference
colnames(data_autism) <- c("Sentiment", "Mean")

# Add a column to distinguish the sources
data_autisminwomen$Source <- "r/autisminwomen"
data_autism$Source <- "r/Autism"

# Combine the data
combined_data <- rbind(data_autisminwomen, data_autism)

# Create the combined bar plot of the mean sentiments.
ggplot(combined_data, aes(x = Sentiment, y = Mean, fill = Source)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Sentiment", y = "Mean", fill = "Source") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("r/autisminwomen" = "skyblue", "r/Autism" = "palegreen"))


