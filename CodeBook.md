# Foundations-in-R-3-Project
Getting and Cleaning Data - Course Project
Luis W. Espejo

# Source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Dataset
The original dataset was prepared for Jorge L. Reyes-Ortiz, Davide Anguita(1), Alessandro Ghio, Luca Oneto and Xavier Parra.
This repo has modified the raw data into a tidy data set.

# Variables of the tidy data set
The variables follow these structure:
subject: number of the individual performing the experiment.
activity: name of the activity that was performed.
other variables: these are the mean of the variables related to mean and standard deviation of the original data. 

# Transformations to clean the data
The values of the "other variables" are the mean of the original values by activity and subject. Further details written as comments in the script "run_analysis.R".

Luis W. Espejo