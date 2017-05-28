## load the additional package required
library(dplyr)


## Download the file from the given path
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ",
                "./Getting and Cleaning Data - Project/Dataset.zip", mode='wb')

## unzip the file
unzip("./Getting and Cleaning Data - Project/Dataset.zip",
      exdir = "./Getting and Cleaning Data - Project")


##set the working directory where files are available
setwd('./Getting and Cleaning Data - Project/UCI HAR Dataset');


## read the features data for both test and training data sets 
##and verify the structure
feature_test <- read.table("./test/X_test.txt",header = FALSE)

feature_train <- read.table("./train/X_train.txt",header = FALSE)


##read the names of the feature dataset
feature_names <- read.table("./features.txt",header = FALSE)


## read the activity data for both test and training data sets 
activity_test <- read.table("./test/y_test.txt",header = FALSE)


activity_train <- read.table("./train/y_train.txt",header = FALSE)


## read the subject data for both test and training data sets 
subject_test <- read.table("./test/subject_test.txt",header = FALSE)

subject_train <- read.table("./train/subject_train.txt",header = FALSE)

###############################################################
##1. Merge the training and the test sets to create a new data set.
###############################################################

my_data <- rbind(feature_test, feature_train)
colnames(my_data) <- feature_names$V2

activity <- rbind(activity_test, activity_train)
colnames(activity) <- c("activityid")

subject <- rbind(subject_test, subject_train)
colnames(subject) <- c("subject")

mergedata <- cbind(my_data, activity, subject)

#######################################################################
##2. Extracts only the measurements on the mean and standard deviation for 
##each measurement.
#######################################################################

## get column names with mean(),std(), activityid and subject
meanstd <- grepl("mean\\(\\)|std\\(\\)|activityid|subject", colnames(mergedata))
            
  
##get the data for only mean, std with activity and subject
meanstddata <- mergedata[meanstd == TRUE]

##########################################################################
##3. Uses descriptive activity names to name the activities in the data set
###########################################################################

##firstly get the activiy labels
activity_labels <- read.table("./activity_labels.txt",header = FALSE)
colnames(activity_labels) <- c("activityid","activity")

##add additional column activity with descriptive names by using merge 
meanstddata_value <- merge(meanstddata,activity_labels, by = activityid)

##remove activityid column
meanstddata_value <- meanstddata_value[,-1]

##########################################################################
##4. Appropriately label the data set with descriptive variable names
###########################################################################

names(meanstddata_value)<-gsub("\\(\\)", "", names(meanstddata_value)) 
names(meanstddata_value)<-gsub("^t", "time", names(meanstddata_value)) 
names(meanstddata_value)<-gsub("^f", "frequency", names(meanstddata_value))
names(meanstddata_value)<-gsub("Acc", "Acceleration", names(meanstddata_value))
names(meanstddata_value)<-gsub("Gyro", "Gyroscope", names(meanstddata_value))
names(meanstddata_value)<-gsub("Mag", "Magnitude", names(meanstddata_value))
names(meanstddata_value)<-gsub("BodyBody", "Body", names(meanstddata_value))
names(meanstddata_value)<-gsub("std", "standardDeviation", names(meanstddata_value))

##########################################################################
##5. From the data set in step 4, creates a second, independent tidy 
##   data set with the average of each variable for each activity and 
##   each subject.
################################################S##########################

finaldata <- aggregate(. ~subject + activity, meanstddata_value, mean)
finaldata <- finaldata[order(finaldata$subject,finaldata$activity),]

write.table(finaldata, file = "tidydata.txt",row.name=FALSE,sep='\t')