# Kindle Reviews Sentiment Analysis using R

## Project Overview
This project analyzes the sentiment of customer reviews for Kindle products using **Natural Language Processing (NLP)** techniques in **R**. The aim is to understand customer emotions, extract insights from review texts, and visualize the frequency and sentiment of words.

Additionally, this project served as a **learning experience** for me to explore **text mining, sentiment analysis, and data visualization in R**.

---

## Dataset
The dataset used in this analysis contains customer reviews, including:
- **`rating`** → Numerical rating given by customers.
- **`reviewText`** → Textual review content.
- **`summary`** → Short summary of the review.

---

## Steps in Analysis

### 1. Data Preprocessing
Before performing sentiment analysis, the text data is cleaned and preprocessed using the `tm` package:
- Converted text to lowercase
- Removed special characters, numbers, and punctuations
- Eliminated common stopwords (e.g., *the, it, is, in, and*)
- Performed stemming (reducing words to their root form)

---

### 2. Exploratory Data Analysis (EDA)
To understand common themes in Kindle reviews, we analyze **word frequency and distribution**.

#### Term Document Matrix (TDM)
A **Term Document Matrix (TDM)** is created to quantify word occurrences. The most frequently used words are extracted and visualized.

#### Visualizations
- **Bar plot** → Displays the **top 5 most frequently used words**.
- **Pie chart** → Shows the **distribution of top 5 words**.
- **Word cloud** → A visual representation of word importance based on frequency.

---

### 3. Sentiment Analysis
We use the `syuzhet` package to perform **sentiment analysis** with multiple methods:

- **Syuzhet method** → Scores sentiment on a scale of `-1` (negative) to `+1` (positive).
- **Bing method** → Binary classification into **negative (`-1`)** and **positive (`+1`)**.
- **Afinn method** → Scores sentiment on a scale of `-5` (very negative) to `+5` (very positive).

#### Comparison of Sentiment Methods
To compare accuracy and consistency, we check the **sentiment classification** across the **Syuzhet, Bing, and Afinn** methods.

---

### 4. Emotion Classification
Each review is categorized into **8 emotions** using NRC lexicon-based sentiment analysis:

| Emotion       | Description                           |
|--------------|--------------------------------------|
| **Anger**    | Negative feelings of frustration    |
| **Anticipation** | Expecting something positive/negative |
| **Disgust**  | Strong negative reaction            |
| **Fear**     | Concern or apprehension             |
| **Joy**      | Positive feelings of happiness      |
| **Sadness**  | Negative feelings of sorrow         |
| **Surprise** | Unexpected reaction                 |
| **Trust**    | Confidence in something             |

#### Visualizations
- **Bar plot** → Shows the **count of words linked to each sentiment**.
- **Percentage bar chart** → Represents the **proportion of words related to each emotion**.

---

## Final Insights
- The **median sentiment score is positive**, suggesting **overall positive feedback** about Kindle products.
- The most frequently used words indicate that **“book” and “story”** dominate in reviews.
- **Joy and trust** are the most prevalent emotions, implying **customer satisfaction**.
- The **NRC method** provides a more detailed emotion analysis than binary classification.

---

## Technologies & Libraries Used
- **R programming language**
- **Libraries:**
  - `tm` – Text Mining  
  - `SnowballC` – Text Stemming  
  - `wordcloud` – Word Cloud Generation  
  - `RColorBrewer` – Color Palettes  
  - `syuzhet` – Sentiment Analysis  
  - `ggplot2` – Data Visualization  

---

## How to Run the Code?
### Prerequisites
1. Install R and RStudio.
2. Install required libraries using:

   ```r
   install.packages('tm')
   install.packages('SnowballC')
   install.packages('wordcloud')
   install.packages('RColorBrewer')
   install.packages('syuzhet')
   install.packages('ggplot2')
