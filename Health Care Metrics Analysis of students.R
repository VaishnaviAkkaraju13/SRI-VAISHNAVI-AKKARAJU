library(readr)
library(ggplot2)
library(GGally)
library(randomForest)
install.packages("corrplot")
library(corrplot)


df <- read_csv("C:/Users/Vaish/Downloads/capstone/StressLevelDataset.csv")

#Descriptive Stats
# How many students are in the dataset?
num_students <- nrow(df)
print(num_students)

#Defining the columns
psychological_factors <- c('anxiety_level', 'self_esteem', 'mental_health_history', 'depression')
physiological_factors <- c('headache', 'blood_pressure', 'sleep_quality', 'breathing_problem')
environmental_factors <- c('noise_level', 'living_conditions', 'safety', 'basic_needs')
academic_factors <- c('academic_performance', 'study_load', 'teacher_student_relationship', 'future_career_concerns')
social_factors <- c('social_support', 'peer_pressure', 'extracurricular_activities', 'bullying')

#Students with negative experiences for each factor
num_students_with_negative_psychological <- rowSums(df[, psychological_factors] < 3)
num_students_with_negative_physiological <- rowSums(df[, physiological_factors] > 3)
num_students_with_negative_environmental <- rowSums(df[, environmental_factors] > 3)
num_students_with_negative_academic <- rowSums(df[, academic_factors] < 3)
num_students_with_negative_social <- rowSums(df[, social_factors] > 3)

#Plotting the factors
factors <- c('Psychological', 'Physiological', 'Environmental', 'Academic', 'Social')
negative_experiences <- c(
  sum(num_students_with_negative_psychological),
  sum(num_students_with_negative_physiological),
  sum(num_students_with_negative_environmental),
  sum(num_students_with_negative_academic),
  sum(num_students_with_negative_social)
)

bar_colors <- c('blue', 'green', 'orange', 'red', 'violet')

barplot(negative_experiences,
        names.arg = factors,
        horiz = TRUE,
        col = bar_colors,
        main = "Students Reporting Negative Experiences",
        xlab = "Number of Students", ylab = "Factors")

#Psychological Factors
#How many students have a self-esteem level below the average?
average_self_esteem <- mean(df$self_esteem)
students_below_average_self_esteem <- nrow(df[df$self_esteem < average_self_esteem, ])
print(students_below_average_self_esteem)

#How many students have reported experiencing depression?
# Calculate the average depression level
average_depression <- mean(df$depression)
# Count students with depression greater than the average
students_above_average_depression <- sum(df$depression > average_depression)
cat("Number of students experiencing depression above the average:", students_above_average_depression, "\n")

#Count of students experiencing anxiety issues
# Calculate the average anxiety level
average_anxiety <- mean(df$anxiety_level)
# Count students with anxiety greater than the average
students_above_average_anxiety <- sum(df$anxiety_level > average_anxiety)
cat("Number of students experiencing anxiety above the average:", students_above_average_anxiety, "\n")

# How many students have reported a history of mental health issues?
students_with_mental_health_history <- nrow(df[df$mental_health_history == 1, ])
print(students_with_mental_health_history)

#Physiological Factors
#How many students experience headaches frequently?
students_with_frequent_headaches <- nrow(df[df$headache == 1, ])
print(students_with_frequent_headaches)

#How Many Students experience blood pressure?
average_blood_pressure <- mean(df$blood_pressure)
# Count of students with blood pressure 
students_with_high_blood_pressure <- sum(df$blood_pressure > average_blood_pressure)
cat("Number of students experiencing blood pressure:", students_with_high_blood_pressure, "\n")

#How many students rate their sleep quality as poor?
students_with_poor_sleep_quality <- nrow(df[df$sleep_quality < 3, ])
print(students_with_poor_sleep_quality)

# Count students with breathing problems 
students_with_breathing_problems <- sum(df$breathing_problem > 3)
cat("Number of students experiencing breathing problems greater than 3:", students_with_breathing_problems, "\n")


#Environmental Factors
#How many students live in conditions with high noise levels?
students_in_high_noise_conditions <- nrow(df[df$noise_level > 3, ])
print(students_in_high_noise_conditions)

# How Many students feel unsafe in their living conditions?
# Count of students feeling unsafe 
students_feeling_unsafe <- sum(df$safety <= 2)

print(students_feeling_unsafe)

#How many students have reported not having their basic needs met?
students_without_basic_needs <- nrow(df[df$basic_needs == 0, ])
print(students_without_basic_needs)
#How Many Students are living in poor conditions
students_living_in_poor_Conditions<- sum(df$living_conditions < 3)

print(students_living_in_poor_Conditions)

#Academic Factors
#How many students rate their academic performance as below average?
students_below_average_academic_performance <- nrow(df[df$academic_performance < 3, ])
print(students_below_average_academic_performance)
#High study load reported by students?
High_study_load <- sum(df$study_load > 3)
print(High_study_load)
#How many students have concerns about their future careers?
students_with_future_career_concerns <- sum(df$future_career_concerns >= 3)
print(students_with_future_career_concerns)
#How Many Students have good relationships with their teacher
Students_With_Good_Teacher_Relationship <- sum(df$teacher_student_relationship > 3)
print(Students_With_Good_Teacher_Relationship)

#Social Factors
#How many students feel they have strong social support?
students_requiring_social_support = nrow(df[df$social_support <3,])
print(students_requiring_social_support)

#Count of  students have experienced bullying?
Count_students_experiencing_bullying <-(sum(df$bullying > 3))
print(Count_students_experiencing_bullying)
#How Many Students are under Peer Pressure
Students_under_peer_pressure <- (sum(df$peer_pressure > 3))
print(Students_under_peer_pressure)
#Comparative Analysis
#Is there a correlation between anxiety level and academic performance?
correlation_anxiety_academic <- cor(df$anxiety_level, df$academic_performance)

#Do students with poor sleep quality also report higher levels of depression?
correlation_sleep_depression <- cor(df$sleep_quality, df$depression)

#Correlation plot
matrix <- cor(df)

?corrplot()

corrplot(matrix , method = "circle")

#Are students who experience bullying more likely to have a history of mental health issues?
students_with_bullying_history <- df[df$bullying == 1, ]
students_with_bullying_history_and_mental_health_history <- students_with_bullying_history[
  students_with_bullying_history$mental_health_history == 1, ]
percentage_students_with_bullying_and_mental_health_history <-
  (nrow(students_with_bullying_history_and_mental_health_history) / nrow(students_with_bullying_history)) * 100

cat("1) Correlation between anxiety level and academic performance:", correlation_anxiety_academic, "\n")
cat("2) Correlation between sleep quality and depression:", correlation_sleep_depression, "\n")
cat("3) Percentage of students with bullying history and mental health history:", percentage_students_with_bullying_and_mental_health_history, "\n")

#General Exploration
#Which factor (Psychological, Physiological, Environmental, Academic, Social) has the highest number of students reporting negative experiences or conditions?
factors <- c('Psychological', 'Physiological', 'Environmental', 'Academic', 'Social')
negative_experiences <- c(students_below_average_self_esteem, 
                          students_with_frequent_headaches, 
                          students_in_high_noise_conditions, 
                          students_without_basic_needs, 
                          nrow(students_with_bullying_history))

factor_with_most_negatives <- factors[which.max(negative_experiences)]

#Are there any noticeable trends or patterns when comparing different factors?
#Which specific feature within each factor has the most significant impact on student stress, based on the dataset?

theme_set(theme_minimal())
factors_to_plot <- data.frame(
  anxiety_level = c(1, 2, 3, 4, 5),
  self_esteem = c(2, 3, 4, 5, 1),
  depression = c(3, 4, 1, 2, 5),
  sleep_quality = c(4, 5, 1, 2, 3),
  academic_performance = c(5, 1, 2, 3, 4)
)


ggpairs(factors_to_plot) +
  theme_minimal() +
  ggtitle("Pairplot of Key Factors")

#use perform feature importance analysis To determine which specific feature within each factor has the most significant impact.
# Define factors
factors <- c('Psychological', 'Physiological', 'Environmental', 'Academic', 'Social')

# Define feature sets for each factor

psychological_features <- c('anxiety_level', 'self_esteem', 'mental_health_history', 'depression')
physiological_features <- c('headache', 'blood_pressure', 'sleep_quality', 'breathing_problem')
environmental_features <- c('noise_level', 'living_conditions', 'safety', 'basic_needs')
academic_features <- c('academic_performance', 'study_load', 'teacher_student_relationship', 'future_career_concerns')
social_features <- c('social_support', 'peer_pressure', 'extracurricular_activities', 'bullying')

# Initialize a linear regression model
model <- lm(stress_level ~ ., data = df)
predictor_variables <- df[, c(psychological_features, physiological_features, environmental_features, academic_features, social_features)]
pair_plot_data <- cbind(predictor_variables, stress_level = df$stress_level)
pairs(pair_plot_data, pch = 16, col = "blue", labels = colnames(pair_plot_data))
title("Pair Plot of Stress Level Predictors")

summary(model)

new_data <- df[, setdiff(names(df), "stress_level")]

predictions <- predict(model, newdata = new_data)
set.seed(123)
train_index <- sample(1:nrow(df), 0.8 * nrow(df))
test_index <- setdiff(1:nrow(df), train_index)

train_data <- df[train_index, ]
test_data <- df[test_index, ]

model <- lm(stress_level ~ ., data = train_data)

predictions <- predict(model, newdata = test_data)
mse <- mean((predictions - test_data$stress_level)^2)
print(paste("Mean Squared Error:", mse))
coefficients <- coef(model)[-1]
barplot(abs(coefficients), names.arg = names(coefficients), col = "blue", main = "Feature Importance")
?lm