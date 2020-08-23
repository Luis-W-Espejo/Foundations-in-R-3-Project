################################## Coursera ##################################-
########################### Getting and Cleaning Data ########################-

#Luis W. Espejo

#Week 4: Project Course
#Setting Workspace
setwd("C:/Users/Willian Espejo/Desktop/Coursera")

#Calling installed packages
library(dplyr)

#################################################################################-
################ 0. Downloading and reading the data ############################
#################################################################################-

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "UCI HAR Dataset.zip"
path <- "UCI HAR Dataset"

#Checking if data is already downloaded
if (!file.exists(file)) {
    download.file(url, file, mode = "wb")
}
#Unzipping if it's not unziped

if (!file.exists(path)) {
    unzip(file, )
}

# Training data
trainSubjects <- read.table(file.path(path, "train", "subject_train.txt"))
trainValues <- read.table(file.path(path, "train", "X_train.txt"))
trainActivity <- read.table(file.path(path, "train", "y_train.txt"))
# Test data
testSubjects <- read.table(file.path(path, "test", "subject_test.txt"))
testValues <- read.table(file.path(path, "test", "X_test.txt"))
testActivity <- read.table(file.path(path, "test", "y_test.txt"))

# Reading features
features <- read.table(file.path(path, "features.txt"), as.is = TRUE)
# Selecting only the names
features <- features[ ,2]
# Reading labels of activities
activityLabels <- read.table(file.path(path, "activity_labels.txt"))
# Selecting ID of activitie and name
activityID<- activityLabels[ ,1]
activityLabels <- activityLabels[ ,2]

##############################################################################-
#######  1. Merge the training and the test sets to create one data set ######
##############################################################################-

# Merging individual data tables
activities <- rbind(
    cbind(trainSubjects, trainValues, trainActivity),
    cbind(testSubjects, testValues, testActivity)
)

# Removing initial tables that were read
rm(trainSubjects, trainValues, trainActivity, 
   testSubjects, testValues, testActivity)

# Assigning column names
colnames(activities) <- c("subject", features, "activity")


################################################################################################-
# 2. Extract only the measurements on the mean and standard deviation for each measurement ####
###############################################################################################-

# Using grepl to find the name of the columms with these words
MeanStandard <- grepl("subject|activity|mean|std", colnames(activities))

# Selecting the data only in those columns
activities <- activities[, MeanStandard]


##############################################################################-
# 3. Use descriptive activity names to name the activities in the data set ####
##############################################################################-

# Renaming activity values with labels given
activities$activity <- factor(activities$activity, 
                                 levels = activityID, 
                              labels = activityLabels)


##############################################################################-
#### 4. Appropriately label the data set with descriptive variable names #####
##############################################################################-

# First, we create a column with all the names
# Then, we use that column to rename the dataframa

# First
# Getting column names
activitiesCol <- colnames(activities)
# Removing special characters
activitiesCol <- gsub("[\\(\\)-]", "", activitiesCol)
# Changing abbreviations to get more clear names
activitiesCol <- gsub("^f", "FrequencyDomain", activitiesCol)
activitiesCol <- gsub("^t", "TimeDomain", activitiesCol)
activitiesCol <- gsub("Acc", "Accelerometer", activitiesCol)
activitiesCol <- gsub("Gyro", "Gyroscope", activitiesCol)
activitiesCol <- gsub("Mag", "Magnitude", activitiesCol)
activitiesCol <- gsub("Freq", "Frequency", activitiesCol)
activitiesCol <- gsub("mean", "Mean", activitiesCol)
activitiesCol <- gsub("std", "StandardDeviation", activitiesCol)
# Correcting a typo
activitiesCol <- gsub("BodyBody", "Body", activitiesCol)

# Use new labels as column names
colnames(activities) <- activitiesCol


#####################################################################################################################-
## 5. Create a second, independent tidy set with the average of each variable for each activity and each subject ####
#####################################################################################################################-

# Mean by group (subject and activity)
tidyData <- activities %>% 
    group_by(subject, activity) %>%
    summarize_each(mean)
tidyData

# Saving new file "tidy_data.txt"
write.table(tidyData, "Foundations-in-R-3-Project/tidy_data.txt", 
            row.names = FALSE, 
            quote = FALSE)
