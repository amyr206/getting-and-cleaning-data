# Copyright 2015 Amy Richards

# PURPOSE:
# --------
# This script fulfills a deliverable of the course project for the Johns Hopkins 
# Data Science Specialization class, Getting and Cleaning Data.
# Project description: 
# https://class.coursera.org/getdata-010/human_grading/view/courses/973497/assessments/3/submissions

# WHAT THIS SCRIPT DOES:
# ----------------------
# Fragmented data from the UCI Machine Learning Repository
# (Human Activity Recognition Using Smartphones Data Set,
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
# is read into R, and consolidated from several files into one dataset.

# The data is then subsetted to capture subject ids, activity ids, and measurements 
# where mean and standard deviation are available.

# Activities are changed from codes to descriptive names.

# Column names are cleaned up and expanded to be more descriptive.

# The data is then aggregated by subject and activity, and means are taken of all
# the measurement data. The resulting dataset is written to a text file in the 
# working directory.

# REQUIRED FILES:
# ---------------
# The script assumes that the "Human Activity Recognition Using Smartphones Data Set"
# has been downloaded from:
# http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
# and unzipped into a directory called "UCI HAR Dataset" in the user's local
# working directory.

# REQUIRED LIBRARIES:
# -------------------
# Only base R is used, no additional libraries are required.

# ADDITIONAL DETAILS:
# -------------------
# See README.md and CODEBOOK.pdf in my GitHub repo:
# https://github.com/amyr206/getting-and-cleaning-data


# --------------------------------------------------------------------
# Step 1: Merges the training and the test sets to create one data set  
# --------------------------------------------------------------------

# read test subject record identifiers
rawtestsubjects <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", colClasses = "numeric")

# read test activity record identifiers
rawtestactivities <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", colClasses = "numeric")

# read test measurement data
rawtestmeasurements <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt", colClasses = "numeric")

# read training subject record identifiers
rawtrainsubjects <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", colClasses = "numeric")

# read training activity record identifiers
rawtrainactivities <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt", colClasses = "numeric")

# read training measurement data
rawtrainmeasurements <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", colClasses = "numeric")

# bind the data identifying the test subjects and activities (as columns) to the corresponding measurement data
testrows <- cbind(rawtestsubjects, rawtestactivities, rawtestmeasurements)

# bind the data identifying the training subjects and activities (as columns) to the corresponding measurement data
trainrows <- cbind(rawtrainsubjects, rawtrainactivities, rawtrainmeasurements)

# bind all the rows of test and training data together to form one merged data frame
mergedata <- rbind(testrows, trainrows)

# ----------------------------------------------------------------------------------------------
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement 
# ----------------------------------------------------------------------------------------------

# read in the column names
rawcolumnnames <- read.table(".\\UCI HAR Dataset\\features.txt")

# create logical vector to identify mean() or std() columns
columnstokeep <- grepl("mean\\(\\)|std\\(\\)", rawcolumnnames$V2)

# create a new version of the vector that adds 2 TRUEs to the beginning of the vector to 
# capture subject and activity identifier columns added to the measurement data in step 1.
columnstokeep2 <- c(TRUE, TRUE, columnstokeep)

# use the modified logical vector to subset the merged test and training data, keeping only
# subject id, activity id, mean() and std() columns
extractdata <- mergedata[, columnstokeep2]

# ------------------------------------------------------------------------------
# Step 3: Uses descriptive activity names to name the activities in the data set
# ------------------------------------------------------------------------------

# read in the activity labels
rawactivities <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")

# Do some cleanup:
# Change the UPPERCASE descriptive values to lowercase values,
# Strip out the underscores
rawactivities$V2 <- tolower(rawactivities$V2)
rawactivities$V2 <- gsub("_", "", rawactivities$V2)

# replace the numeric activity identifications in extractdata with the descriptions
# from rawactivities
# based on approach described by Gregory D. Horne in discussion forum (thanks!):
# https://class.coursera.org/getdata-010/forum/thread?thread_id=273#comment-832
extractdata$V1.1 <- rawactivities$V2[extractdata$V1.1]

# -------------------------------------------------------------------------
# Step 4: Appropriately labels the data set with descriptive variable names
# -------------------------------------------------------------------------

# Re-use the column names read in from features.txt and the logical vector created in Step 2
# to extract only the column names we're keeping
columnstorename <- rawcolumnnames$V2[columnstokeep]

# start cleanup on the column names, with info derived from features_info.txt:

# replace leading t and f with "time" and "freq"
columnstorename <- sub("^t", "time", columnstorename)
columnstorename <- sub("^f", "frequency", columnstorename)

# strip out parentheses and dashes
columnstorename <- gsub("-", "", columnstorename)
columnstorename <- sub("\\(\\)", "", columnstorename)

# change "Acc" to "accelerometer"
columnstorename <- sub("Acc", "accelerometer", columnstorename)

# change "Gyro" to "gyroscope"
columnstorename <- sub("Gyro", "gyroscope", columnstorename)

# change "Mag" to "magnitude"
columnstorename <- sub("Mag", "magnitude", columnstorename)

# eliminate duplicate "body" in titles
columnstorename <- sub("BodyBody", "body", columnstorename)

# convert to lowercase
columnstorename <- tolower(columnstorename)

# add in descriptive names for the subject identifier and activity
columnstorename <- c("subjectid", "activity", columnstorename)

# attach the renamed columns to the measurement data
colnames(extractdata) <- columnstorename

# -------------------------------------------------------------------------
# Step 5: From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
# -------------------------------------------------------------------------

# aggregate response by activities and subjects and take average of mean and std measurements
# to achieve a tidy dataset
tidydata <- aggregate(extractdata[, 3:68], by = list(subjectid = extractdata$subjectid, activity = extractdata$activity), FUN = mean)

# save the tidy data to a file in the working directory
write.table(tidydata, "tidydata.txt", row.name = FALSE )

