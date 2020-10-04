The run_analysis.R script performs the data preparation and followed by the 5 steps described in the course project’s definition.

* Download the dataset

    Dataset downloaded under the folder called Dataset

* Assign each data to variables
    
    features <- features.txt

* The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

    activities <- activity_labels.txt

* List of activities performed when the corresponding measurements were taken and its codes
    
    subject_test <- test/subject_test.txt

* contains test data of 9/30 volunteer test subjects being observed

    X_test <- test/X_test.txt

* contains recorded features test data

    y_test <- test/y_test.txt 

* contains test data of activities’code labels

    subject_train <- test/subject_train.txt

* contains train data of 21/30 volunteer subjects being observed

    X_train <- test/X_train.txt

* contains recorded features train data

    y_train <- test/y_train.txt

* Merges the training and the test sets to create one data set

    X is created by merging X_train and X_test using rbind() function
    
    Y is created by merging y_train and y_test using rbind() function
    
    subject is created by merging subject_train and subject_test using rbind() function
    
    merged_data is created by merging subject, X and Y using cbind() function

* Extracts only the measurements on the mean and standard deviation for each measurement

* tidy_data is created by subsetting merged_data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

* Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the tidy_data replaced with corresponding activity taken from second column of the activities variable

* Appropriately labels the data set with descriptive variable names

    code column in TidyData renamed into activities

    All Acc in column’s name replaced by Accelerometer
    
    All Gyro in column’s name replaced by Gyroscope
    
    All BodyBody in column’s name replaced by Body
    
    All Mag in column’s name replaced by Magnitude
    
    All start with character f in column’s name replaced by Frequency
    
    All start with character t in column’s name replaced by Time

* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
* final_data is created by sumarizing tidy_data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
* Export final_data into FinalData.txt file.
