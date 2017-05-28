## Getting and Cleaning Data - Course Project

The repository is created to hold all the artifacts and the work done for the
assignment: Getting and Cleaning Data Course Project.

Following are the list of files in the repository: 

>> CodeBook.md : describes the variables, the data, and any transformations or work that was performed to clean up the data.

>> run_analysis.R: R code created to do the following tasks in the order
   1. download the zip file with data collected from the accelerometers from the Samsung Galaxy S smartphone and unzip the file.
   2. Read the features data for test - X_test.txt, for training - X_train.txt
   3. Read the feature names features.txt to be used to update the column names for features
   4. Read the activity data for test - y_test.txt, for training - y_train.txt
   5. Read the subject data for test - subject_test.txt, for training - subject_train.txt
   6. Merge all the data and provide the variable names as per the data in features.txt
   7. Extract only the measurements on the mean and standard deviation for each measurement
   8. provide descriptive activity names to name the activities in the data set by using the file activity_labels.txt
   9. Appropriately label the data set with descriptive variable names
   10. creates a second, independent tidy data set with the average of each variable for each activity and each subject and call the file tidydata.txt


>> tidydata.txt: tab delimited text file with headers, holding average of each variable for each activity and each subject
