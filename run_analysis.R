## Course:      Getting and Cleaning Data
## Coursework:  Peer Assessment / Course Project

#####################################################################
#### 1. Merges the training and the test sets to create one data set.
#####################################################################

## Piece together data on test subjects, activity labels and feature data.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

testData <- X_test
testData$Activity <- Y_test[, 1]
testData$Subjects <- subject_test[, 1]

## Piece together data on train subjects, activity labels and feature data.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

trainData <- X_train
trainData$Activity <- Y_train[, 1]
trainData$Subjects <- subject_train[, 1]

## Merge test and training sets.
allData <- rbind(testData, trainData)

###############################################################################################
#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
###############################################################################################

features <- read.table("./UCI HAR Dataset/features.txt")
meanStdCols <- grep("mean()|std()", features[, 2]) # Returns a numeric vector of positions in features.
# Data frame containing activity data with non-descriptive variable names.
meanStdData <- data.frame(allData[, meanStdCols], "Subjects" = allData$Subjects, "Activity" = allData$Activity)

###############################################################################
#### 3. Uses descriptive activity names to name the activities in the data set.
###############################################################################

actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = c("integer", "character"))
library(dplyr)
actLabels <- dplyr::rename(actLabels, Activity = V1, ActivityNames = V2) # If plyr is also loaded. Conflict between the same function "rename".
meanStdData$Activity <- actLabels$ActivityNames[match(meanStdData$Activity, actLabels$Activity)] # Match and replace with activity description.

##########################################################################
#### 4. Appropriately labels the data set with descriptive variable names. 
##########################################################################

featCols <- features[, 2]
newVarNames <- as.character(featCols[meanStdCols]) # Get variable names of mean/sd features.
names(meanStdData) <- append(newVarNames, c("Subjects", "Activity")) # Assign new variable names for data set.

######################################################################################################################################################
#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
######################################################################################################################################################

subjects <- 1:length(unique(meanStdData$Subjects)) # List of subject names (in numbers).
activity <- sort(actLabels$ActivityNames) # List of activity names.
numofFeat <- length(newVarNames) # Number of mean/sd features.

# Instantiate new data frame for mean values.
meanStdData.mean <- NULL

# Subset data frame rows conditioned on each combination of "Subjects" and "Activity".
for (i in subjects) {
        for (j in activity) {
                # Subset dataset and exclude "Subjects" and "Activity" columns.
                meanStdData.sub <- meanStdData[(meanStdData$Subjects == i & meanStdData$Activity == j), 1:numofFeat] 
                # Calculate column means and return a 79-elements vector. 
                colMeansVal <- as.data.frame(colMeans(meanStdData.sub))
                # Add each vector of column means as rows to new data set.
                newrow <- append(colMeansVal[, 1], c(i, j))
                meanStdData.mean <- rbind(meanStdData.mean, as.vector(newrow))
        }
}
meanStdData.mean <- as.data.frame(meanStdData.mean) 
names(meanStdData.mean) <- names(meanStdData) # Add back variable names.

# Save table as meanStdDataAvrg.txt
write.table(meanStdData.mean, file = "meanStdDataAvrg.txt", row.names = FALSE)


