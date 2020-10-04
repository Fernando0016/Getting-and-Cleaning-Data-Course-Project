# Author : KERAGHEL Imed
#last modification : Sun Oct 4th 2020

# load libraries

library(dplyr)

filename <- "Coursera.zip"

# Checking if archieve already exists in our working directory
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("Dataset")) { 
  unzip(filename) 
}

features <- read.table("Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("Dataset/train/y_train.txt", col.names = "code")
X <- rbind(X_train, X_test)
Y <- rbind(y_train, y_test)

subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, Y, X)

tidy_data <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

tidy_data$code <- activities[tidy_data$code, 2]

names(tidy_data)[2] = "activity"
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<-gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("angle", "Angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", "Gravity", names(tidy_data))

final_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# to save table in a txt file
write.table(final_data, "FinalData.txt", row.name=FALSE)

str(final_data)

View(final_data)
