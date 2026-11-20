# Airline Passenger Satisfaction Analysis
# Name : Nitish Singh

# Load Required Libraries
library(tidyverse)
library(caret)
library(ggplot2)

airline <- read.csv("Airline_Survey.csv") # Read Dataset

# Inspecting Dataset
dim(airline)
names(airline)
str(airline)
head(airline)

# DATA FORMATTING
# Convert Character Variables to Factors
airline <- airline %>%
  mutate_if(is.character, as.factor)

# Checking Structure Again
str(airline)

# TARGET VARIABLE CHECK
# Satisfaction Distribution
table(airline$satisfaction)
prop.table(table(airline$satisfaction))
round(prop.table(table(airline$satisfaction)) * 100, 2)

# Frequency Tables
table(airline$Seat_Comfort)
table(airline$Inflight_entertainment)
table(airline$Checkin_service)

# Convert 0 values to NA because 0 represents "Not Applicable"
# rather than dissatisfaction.
airline$Seat_Comfort[airline$Seat_Comfort == 0] <- NA
airline$Inflight_entertainment[airline$Inflight_entertainment == 0] <- NA
airline$Checkin_service[airline$Checkin_service == 0] <- NA

# Checking Missing Values Again
colSums(is.na(airline))
sum(duplicated(airline)) # Check for Duplicate Rows

# DESCRIPTIVE STATISTICS
# Categorical Variables
table(airline$Class)
prop.table(table(airline$Class))

table(airline$Type_of_Travel)
prop.table(table(airline$Type_of_Travel))

table(airline$Customer_Type)
prop.table(table(airline$Customer_Type))

# NUMERIC VARIABLES
# Age
summary(airline$Age)
mean(airline$Age, na.rm = TRUE)
median(airline$Age, na.rm = TRUE)
sd(airline$Age, na.rm = TRUE)

# Flight Distance
summary(airline$Flight_Distance)
mean(airline$Flight_Distance, na.rm = TRUE)
median(airline$Flight_Distance, na.rm = TRUE)
sd(airline$Flight_Distance, na.rm = TRUE)

# Departure Delay
summary(airline$Departure_Delay)
mean(airline$Departure_Delay, na.rm = TRUE)
median(airline$Departure_Delay, na.rm = TRUE)
sd(airline$Departure_Delay, na.rm = TRUE)

# Arrival Delay
summary(airline$Arrival_Delay)
mean(airline$Arrival_Delay, na.rm = TRUE)
median(airline$Arrival_Delay, na.rm = TRUE)
sd(airline$Arrival_Delay, na.rm = TRUE)

# DESCRIPTIVE STATISTICS FOR HYPOTHESIS VARIABLES
# Seat Comfort
summary(airline$Seat_Comfort)
mean(airline$Seat_Comfort, na.rm = TRUE)
median(airline$Seat_Comfort, na.rm = TRUE)
sd(airline$Seat_Comfort, na.rm = TRUE)

# Inflight Entertainment
summary(airline$Inflight_entertainment)
mean(airline$Inflight_entertainment, na.rm = TRUE)
median(airline$Inflight_entertainment, na.rm = TRUE)
sd(airline$Inflight_entertainment, na.rm = TRUE)

# Checkin Service
summary(airline$Checkin_service)
mean(airline$Checkin_service, na.rm = TRUE)
median(airline$Checkin_service, na.rm = TRUE)
sd(airline$Checkin_service, na.rm = TRUE)

# Visualisation 1: Distribution of Customer Satisfaction
ggplot(airline, aes(x = satisfaction, fill = satisfaction)) +
  geom_bar() +
  labs(
    title = "Distribution of Customer Satisfaction",
    x = "Satisfaction",
    y = "Number of Passengers"
  ) + 
  theme_minimal()

# Visualisation 2: Satisfaction Across Travel Classes
ggplot(airline,
       aes(x = Class,
           fill = satisfaction)) +
  geom_bar(position = "fill") +
  labs(
    title = "Customer Satisfaction by Travel Class",
    x = "Travel Class",
    y = "Proportion"
  ) +
  theme_minimal()

# Visualisation 3: Seat Comfort Ratings by Satisfaction
ggplot(airline,
       aes(x = satisfaction,
           y = Seat_Comfort,
           fill = satisfaction)) +
  geom_boxplot() +
  labs(
    title = "Seat Comfort Ratings by Satisfaction",
    x = "Satisfaction",
    y = "Seat Comfort Rating"
  ) +
  theme_minimal()

# Visualisation 4: Inflight Entertainment Ratings by Satisfaction
ggplot(airline,
       aes(x = satisfaction,
           y = Inflight_entertainment,
           fill = satisfaction)) +
  geom_boxplot() +
  labs(
    title = "Inflight Entertainment Ratings by Satisfaction",
    x = "Satisfaction",
    y = "Inflight Entertainment Rating"
  ) +
  theme_minimal()

# Visualisation 5: Customer Satisfaction by Check-in Service Rating
ggplot(airline,
       aes(x = factor(Checkin_service),
           fill = satisfaction)) +
  geom_bar(position = "fill") +
  labs(
    title = "Customer Satisfaction by Check-in Service Rating",
    x = "Check-in Service Rating",
    y = "Proportion"
  ) +
  theme_minimal()


# PART 5 — MEASURES OF ASSOCIATION
# Association Between Seat Comfort and Satisfaction
t.test(
  Seat_Comfort ~ satisfaction,
  data = airline)

# Association Between Inflight Entertainment and Satisfaction
t.test(
  Inflight_entertainment ~ satisfaction,
  data = airline)

# Association Between Check-in Service and Satisfaction
t.test(
  Checkin_service ~ satisfaction,
  data = airline)

# Association Between Departure Delay and Satisfaction
t.test(
  Departure_Delay ~ satisfaction,
  data = airline)

# Association Between Travel Class and Satisfaction
class_table <- table(
  airline$Class,
  airline$satisfaction)
class_table

chisq.test(class_table)

# TRAINING AND TEST DATA SPLIT
set.seed(40524741)

# Creating Training Sample
train_index <- createDataPartition(
  airline$satisfaction,
  p = 0.7,
  list = FALSE)
# Train-test split performed using createDataPartition()
# as demonstrated in lecture materials

# Creating Training and Test Sets
train_data <- airline[train_index, ]
test_data <- airline[-train_index, ]

# Checking Dataset Dimensions
dim(train_data)
dim(test_data)

# Check Satisfaction Distribution
prop.table(table(train_data$satisfaction))
prop.table(table(test_data$satisfaction))

# Releveling Target Variable
train_data$satisfaction <- relevel(
  train_data$satisfaction,
  ref = "dissatisfied")

test_data$satisfaction <- relevel(
  test_data$satisfaction,
  ref = "dissatisfied")

# LOGISTIC REGRESSION MODEL 1
# Hypothesis Variables
model1 <- glm(
  satisfaction ~
    Seat_Comfort +
    Inflight_entertainment +
    Checkin_service +
    Class +
    Departure_Delay,
  
  data = train_data,
  family = "binomial"
)
# Model Summary
summary(model1)

# LOGISTIC REGRESSION MODEL 2
# Enhanced Model
model2 <- glm(
  satisfaction ~
    Seat_Comfort +
    Inflight_entertainment +
    Checkin_service +
    Class +
    Departure_Delay +
    Type_of_Travel +
    Customer_Type,
  
  data = train_data,
  family = "binomial"
)
# Model Summary
summary(model2)

# PREPARE TEST DATA FOR PREDICTION
test_model <- test_data %>%
  drop_na(
    Seat_Comfort,
    Inflight_entertainment,
    Checkin_service,
    Class,
    Departure_Delay,
    Type_of_Travel,
    Customer_Type
  )

# GENERATING PREDICTED PROBABILITIES
predicted_probabilities <- predict(
  model2,
  newdata = test_model,
  type = "response"
)
# CLASSIFYING PREDICTIONS
predicted_class <- ifelse(
  predicted_probabilities > 0.5,
  "satisfied",
  "dissatisfied"
)
# CONVERTING TO FACTOR
predicted_class <- as.factor(predicted_class)

# CONFUSION MATRIX
confusionMatrix(
  predicted_class,
  test_model$satisfaction
)


# COMPARE BOTH LOGISTIC REGRESSION MODELS

# Predict using Model 1
prob_model1 <- predict(
  model1,
  newdata = test_model,
  type = "response"
)

class_model1 <- factor(
  ifelse(prob_model1 > 0.5, "satisfied", "dissatisfied"),
  levels = levels(test_model$satisfaction)
)

# Predict using Model 2
class_model2 <- factor(
  ifelse(predicted_probabilities > 0.5, "satisfied", "dissatisfied"),
  levels = levels(test_model$satisfaction)
)

# Compare accuracy
comparison <- data.frame(
  Model = c("Model 1", "Model 2"),
  Accuracy = c(
    mean(class_model1 == test_model$satisfaction),
    mean(class_model2 == test_model$satisfaction)
  )
)

print(comparison)


#Generative AI tools were used selectively during this project to 
#support understanding of R syntax, data preprocessing approaches, 
#logistic regression workflow, and interpretation of statistical outputs.
#All analytical decisions, variable selection, preprocessing choices, 
#interpretation of results, and final code implementation were independently 
#reviewed, modified, and validated by myself in accordance with module guidance
#and academic integrity requirements.

