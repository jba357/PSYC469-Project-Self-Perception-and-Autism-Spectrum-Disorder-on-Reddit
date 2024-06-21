# Now, I want to compare both sets of data using t-tests, which will tell me if there is a significant effect of group (i.e. r/AUtism or r/autisminwomen). 


# First, I will load the necessary libraries

library(tidyverse)

# I will now load the NRC sentiment analysis percentage results that I created earlier.
autisminwomengroup <- read.csv("C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\nrc_autisminwomen_detected_percentage.csv")
autismgroup <- read.csv("C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\nrc_autism_detected_percentage.csv")

# Extract the sentiment columns
sentiments <- c("anger", "joy", "positive", "negative", "anticipation", "disgust", "fear", "surprise", "trust", "sadness")

# Now I am making a list to store the p-values
p_values <- list()

# Next, I will perform t-tests for each sentiment using a for loop.
for (sentiment in sentiments) {
  t_test <- t.test(autisminwomengroup[[sentiment]], autismgroup[[sentiment]], var.equal = TRUE)
  p_values[[sentiment]] <- t_test$p.value
}

# Convert p-values list to a vector
p_values_vector <- unlist(p_values)

# As I am performing multiple t-tests, I need to adjust the p-values for multiple comparisons using Bonferroni correction to avoid false positive results.
adjusted_p_values <- p.adjust(p_values_vector, method = "bonferroni")

# Create a data frame to display results
results <- data.frame(
  Sentiment = sentiments,
  P_Value = p_values_vector,
  Adjusted_P_Value = adjusted_p_values
)

# Add a column for significance
results$Significant <- ifelse(results$Adjusted_P_Value < 0.05, "Yes", "No")


# Print the results
print(results)

# We can examine the p-values in a graph using a square root scale.
ggplot(results, aes(x = Sentiment, y = Adjusted_P_Value, fill = Significant)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_hline(yintercept = 0.05, linetype = "dashed", color = "red") +
  scale_fill_manual(values = c("Yes" = "blue", "No" = "grey")) +
  scale_y_sqrt() +  # Apply square root transformation to the y-axis
  labs(title = "P-Values of Different Sentiments (Square Root Scale)",
       x = "Sentiment",
       y = "Adjusted P-Value (Square Root Scale)") +
  theme_minimal()
