# Background
Our app currently takes a query, and a list of reviews, and tries present a ranked list of the reviews, with the top being most similar to the query. However, how do we know whether this query system is performing well?

To automate this process would be have been very laborious, so instead I opted for using the Cranfield Methodology of testing, which is fairly manual.

# Cranfield Methodology
I have created 3 sets of review mock data (relevance judgement documents), each centered around a theme / query:
1. "Worst app ever"
2. "Audio Issues"
3. "Won't Load"

For each of these data sets are 10 reviews, 5 of which are positive relevance judgements, and 5 which are negative.

| Review | "Worst app ever" Data        | "Audio Issues" Data          | "Won't Load" Data                  | Relevance Judgement |
|--------|------------------------------|-----------------------------:|------------------------------------|---------------------|
| #1     | "Worst App Ever"             | "Audio Issues"               | "WON'T LOAD"                       | ✅                   |
| #2     | "Bad app"                    | "Having trouble with noise"  | "App doesn't load quickly"         | ✅                   |
| #3     | "I don't like this app"      | Volume bugs"                 | "Loading times are slow"           | ✅                   |
| #4     | "Needs work"                 | "Video playback issues"      | "Fix loading issues"               | ✅                   |
| #5     | "Audio Issues"               | "Can't hear anything"        | "Problems with loading"            | ✅                   |
| #6     | "App is decent"              | "App is decent"              | "Loading times are much improved!" | ❌                   |
| #7     | "App would be perfect if..." | "App would be perfect if..." | "App loads too quickly!"           | ❌                   |
| #8     | "Nicely designed app"        | "Nicely designed app"        | "Fast app!"                        | ❌                   |
| #9     | "Thank you"                  | "Thank you"                  | "App is too expensive"             | ❌                   |
| #10    | "Best App Ever",             | "Best App Ever"              | "App is #1"                        | ❌                   |

# My Testing Approach
Given a query, I will compare the query to the **title** of each review, creating a similarity value. Then, I will sort these values by smallest value (most similar review), then present this sorted reviews list to the user. This will be the empirical ranked list, that I will use to compare against the mock data (ideal list).

To compare these lists, I will use Average Precision. This evaluation is a good measure as it combines the power of Precision and Recall.

For a refresher on what Average Precision is and the calculations I'll be perform, please refer to [this link](https://www.coursera.org/learn/cs-410/lecture/rU7LT/lesson-3-3-evaluation-of-tr-systems-evaluating-ranked-lists-part-1)

Then, for all the queries I've performed against multiple datasets, I'll simply take the Mean Average Precision (MAP) to quantify the system as a whole.

# Performing the tests
There is no need to manually calculate Average Precision as the app built in this project will do it for you. You can switch the "DataType" to the test data you want, and enter a query. Based on the results, you'll see and "Average Precision: xx" value in the top right corner of the app.

For all the queries I'm summarizing here, please try them in the app.

# Test 1
I'll use the data set **"Worst app ever"**
The query I'll choose to use is "Worst App Ever"

**Expectations:**
- I expect to have an Average Precision score close to 1, possibly greater than 0.8, would be sufficient, as there are only 5 relevant documents.

**Outcome:**
- Average Precision was 0.74
- This was lower than what was predicted. It seems the review "Best app ever" was ranked high on the list! Even though it has the opposite meaning. This is what made the precision lower than expected.

# Test 2
I'll use the data set **"Audio Issues"**
The query I'll choose to use is "Audio Issues"

**Expectations:**
- I expect to have an Average Precision score close to 1, possibly greater than 0.8, would be sufficient, as there are only 5 relevant documents.

**Outcome:**
- Average Precision was 0.76
- This was lower than what was predicted. For reviews such as "Can't hear anything" & "Having trouble with noise" Apple's Natural Language Framework wasn't able to rank these high compared to reviews such as "Best App Ever". The reviews in this data set are a bit tricky, so I'm not surprised it's tricking Apple's framework. Reviews like "Volume Bugs" (Ranked 5th) is hard to decipher because of word ambiguity. "Bugs" here is referring software issues, not insects.

# Test 3
I'll use the data set **"Won't Load"**
The query I'll choose to use is "Won't Load"

**Expectations:**
- I expect to have an Average Precision score close to 1, possibly greater than 0.8, would be sufficient, as there are only 5 relevant documents.

**Outcome:**
- Average Precision was 0.80
- This precision was good! Even reviews such has "App Loads too quickly!" were ranked low (7th). It's good to know that Apple can use small but key differentiating words to influence their similarities.

# Mean Average Precision
MAP is 0.76. Apple's Natural Langauge Framework in totality performs decently on these sets of queries and datasets. However, this test is not comprehensive. There is a lot of more queries and datasets that can be used to evaluate this framework. 
A key in this test is that I only use the title of a review to compare a query to reviews. I could improve the accuracy by combining both the title and the content of the review, and comparing that with the query. However, this is very computationally expensive, especially as some reviews can be as large as paragraphs.

# Self Evaluation
The outcome of the project was expected, in that I was hoping for a query system of reviews that had a decent accuracy, a Mean Average Precision of around 0.8. And this was ultimately true based on the test results. The query system won't be 100% accurate because of the nuances in language that I've shown in the above test results. Even Apple's framework had a tough job doing thus. However, do note that Apple's Natural Langauage Framework is an embedded framework, meaning all NLP tasks are done on-device and not in the cloud. This makes the results really fast, however accuracy then does tend to take a hit because you can only store so much knowledge for NLP tasks on a memory constrained device.
