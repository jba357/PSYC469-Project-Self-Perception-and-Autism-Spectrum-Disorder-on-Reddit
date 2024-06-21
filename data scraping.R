

# I will be scraping data from the subreddit r/AutismInWomen. Firstly, I will load the necessary packages.

library(RedditExtractoR)
library(dplyr)

# I will now collect 1000 posts from r/AutismInWomen from the past month, as this is the maximum number of posts that can be collected without applying for academic access to the Reddit API.
reddit_posts_women <- find_thread_urls(subreddit = 'AutismInWomen', # specifies the subreddit which I want to collect data from
                                 sort_by = 'top', # specifies which category of posts I want to collect
                                 period = 'all') # specifies the period of time you want posts from; either: hour, day, week, month, year, all


# Now I will organise the data into a dataframe, which ensures it is in a format that is compatible with functions used in R.

reddit_posts_women <- data.frame(reddit_posts_women)
str(reddit_posts_women)

View(reddit_posts_women)

# I am cleaning the data using the function filter() which allows me to specify types of variables I don't want to include, in this case posts without titles.
reddit_posts_comments_women <- filter(reddit_posts_women, !is.na(title))
reddit_posts_comments_women <- subset(reddit_posts_comments_women,comments != 0) # Now I am using the subset function to give me only posts which meet my condition of having more than zero comments.
View(reddit_posts_comments_women)

# Now, I will save my data as a CSV file, so I can use it for further analysis.
write.csv(reddit_posts_comments_women, "C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\reddit_posts_comments_women.csv")


#Now, I will be scraping data from the subreddit r/autism.


# I will now collect 1000 posts from r/autism from the past month, as this is the maximum number of posts that can be collected without applying for academic access to the Reddit API.
reddit_posts_general <- find_thread_urls(subreddit = 'autism', # specifies the subreddit which I want to collect data from
                                 sort_by = 'top', # specifies which category of posts I want to collect
                                 period = 'all') # specifies the period of time you want posts from; either: hour, day, week, month, year, all

# Now I will organise the data into a dataframe, which ensures it is in a format that is compatible with functions used in R.
reddit_posts_general <- data.frame(reddit_posts_general)
str(reddit_posts_general)

View(reddit_posts_general)


# I am also cleaning the data using the function filter() which allows me to specify types of variables I don't want to include, in this case posts without titles.
reddit_posts_comments_general <- filter(reddit_posts_general, !is.na(title))
reddit_posts_comments_general <- subset(reddit_posts_comments_general,comments != 0) # Now I am using the subset function to give me only posts which meet my condition of not having more than zero comments.
View(reddit_posts_comments_general)

# Now, I will save my data as a CSV file, so I can use it for further analysis.
write.csv(reddit_posts_comments_general, "C:\\Users\\jamil\\OneDrive\\Desktop\\Autismpsyc460project\\reddit_posts_comments_general.csv")
