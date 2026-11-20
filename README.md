# Airline-Customer-Satisfaction-Analysis
Exploratory data analysis, statistical hypothesis testing and logistic regression for airline customer satisfaction using R.

## Project Overview

This project examines the factors associated with airline customer satisfaction using exploratory data analysis, statistical hypothesis testing and logistic regression in R.

The analysis investigates how service-related factors, travel class and flight delays relate to customer satisfaction, and evaluates the predictive performance of two logistic regression models.

## Objectives

- Explore the airline passenger survey dataset.
- Examine customer satisfaction patterns across key service attributes.
- Test five research hypotheses.
- Analyse associations between selected variables.
- Develop and evaluate logistic regression models.
- Interpret the findings from a business perspective.

## Tools and Technologies

- R
- RStudio
- Statistical Analysis
- Data Visualisation
- Logistic Regression

## Repository Structure

```text
airline-customer-satisfaction-analysis/
│
├── R/
│   └── Airline_Satisfaction_Analysis.R
│
├── data/
│   └── Airline_Survey.csv
│
├── visualisations/
│   ├── 01_satisfaction_distribution.png
│   ├── 02_seat_comfort_satisfaction.png
│   ├── 03_inflight_entertainment_satisfaction.png
│   ├── 04_checkin_service_satisfaction.png
│   └── 05_travel_class_satisfaction.png
├── outputs/
│   └── .gitkeep
│
└── README.md
```

## Methodology

1. Data inspection and preparation
2. Exploratory data analysis
3. Data visualisation
4. Statistical hypothesis testing
5. Logistic regression modelling
6. Model evaluation and interpretation

## Model Evaluation

Two logistic regression models were developed and evaluated using a test dataset.

| Metric | Model 1 | Model 2 |
|---|---:|---:|
| Accuracy | 80.24% | 81.54% |

Model 2 achieved an improvement of approximately 1.31 percentage points in classification accuracy over Model 1.

## Key Findings

The analysis evaluates the relationship between airline service attributes and customer satisfaction, with particular attention to seat comfort, inflight entertainment, check-in service, travel class and departure delay.

## Academic Context

This project was developed as part of the MSc Business Analytics programme at Queen’s University Belfast.

## Reproducibility

The R analysis script is available in the `R/` directory. The dataset is stored in `data/`, and the generated visualisations are available in `visualisations/`.

## Visualisations

### 1. Customer Satisfaction Distribution
![Customer Satisfaction Distribution](visualisations/Distribution%20of%20Customer%20Satisfaction.png)

### 2. Seat Comfort and Satisfaction
![Seat Comfort](visualisations/Seat%20Comfort%20Ratings%20by%20Satisfaction.png)

### 3. Inflight Entertainment and Satisfaction
![Inflight Entertainment](visualisations/Inflight%20Entertainment%20Ratings%20by%20Satisfaction.png)

### 4. Check-in Service and Satisfaction
![Check-in Service](visualisations/Customer%20Satisfaction%20by%20Check-in%20Service%20Rating.png)

### 5. Travel Class and Satisfaction
![Travel Class](visualisations/Customer%20Satisfaction%20by%20Travel%20Class.png)

## Author

Nitish Kumar Singh
