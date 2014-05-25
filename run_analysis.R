## read the column names
colnames <- read.table("./UCI HAR Dataset/features.txt", header=F, as.is=T, 
                       col.names=c("MeasureID", "MeasureName"))
## read the subject files
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                      header=F, col.names=c("SubjectID"))
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                           header=F, col.names=c("SubjectID"))

## read the activity labels
activitytest<- read.table("./UCI HAR Dataset/test/y_test.txt", 
                          header=F, col.names=c("ActivityID"))
activitytrain<- read.table("./UCI HAR Dataset/train/y_train.txt", 
                          header=F, col.names=c("ActivityID"))

## read the test set
test <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                   header=F, col.names=colnames$MeasureName)
## read the training set
train <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                    header=F, col.names=colnames$MeasureName)

## names of columns required
subcols <- grep(".*mean\\(\\)|.*std\\(\\)", colnames$MeasureName)
## subset the data
test <- test[, subcols]
train <- train[, subcols]

## append the activity and subject columns
test$ActivityID <- activitytest$ActivityID
test$SubjectID <- subjecttest$SubjectID

train$ActivityID <- activitytrain$ActivityID
train$SubjectID <- subjecttrain$SubjectID

## add activity names
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                             header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
activitylabels$ActivityName <- as.factor(activitylabels$ActivityName)
test <- merge(test, activitylabels)
train <- merge(train, activitylabels)

## merge the training and the test sets
mergeddata <- rbind(test, train)


## Creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject

library(reshape2)
## melt the dataset
id_vars = c("ActivityID", "ActivityName", "SubjectID")
measure_vars = setdiff(colnames(mergeddata), id_vars)
melteddata <- melt(mergeddata, id=id_vars, measure.vars=measure_vars)

## recast 
tidydata <- dcast(melteddata, ActivityName + SubjectID ~ variable, mean)

## save the tidy data to a text file
write.table(tidydata, file="tidyData.txt")