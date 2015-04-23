#Step 0.Preliminary set up

setwd("D:\\GCD\\project\\UCI HAR Dataset")

#Step 1.Merges the training and the test sets to create one data set.

testSet <- read.table("./test/X_test.txt", header=FALSE)
trainingSet <- read.table("./train/X_train.txt", header=FALSE)
combinedSet <- rbind(testSet, trainingSet)

testSubjects <- read.table("./test/subject_test.txt", header=FALSE)
trainingSubjects <- read.table("./train/subject_train.txt", header=FALSE)
combinedSubjects <- rbind(testSubjects, trainingSubjects)

#Step 2.Extracts only the measurements on the mean and standard deviation for each measurement

features <- read.table("./features.txt", header=FALSE)
featuresToExtract <- sort(c(grep("mean()",features$V2), grep("std()",features$V2)))
MeanAndStandardDeviationExtract <- combinedSet[,featuresToExtract]


#Step 3.Uses descriptive activity names to name the activities in the data set

testLabels <- read.table("./test/y_test.txt", header=FALSE)
trainingLabels <- read.table("./train/y_train.txt", header=FALSE)
combinedLabels <- rbind(testLabels, trainingLabels)

activityTypes <-read.table("./activity_labels.txt", header=FALSE)
ActivityDiscription <- merge(activityTypes, combinedLabels, by="V1")

MeanAndStandardDeviationExtractWithActivities <- cbind(MeanAndStandardDeviationExtract, ActivityDiscription$V2, combinedSubjects)

#Step 4.Appropriately labels the data set with descriptive variable names.

variableNames <- c(as.character(features[featuresToExtract,2]), "Activity", "Subject")
names(MeanAndStandardDeviationExtractWithActivities) <- variableNames

#step 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subdata <- aggregate(MeanAndStandardDeviationExtractWithActivities, by=list(MeanAndStandardDeviationExtractWithActivities$Activity, MeanAndStandardDeviationExtractWithActivities$Subject), FUN=mean)
subdata <- subdata[,1:(ncol(subdata)-2)]
colnames(subdata)[1] <- "Activity"
colnames(subdata)[2] <- "Subject"

write.table(subdata, "TidyDataSet.txt", append=FALSE, row.name=FALSE, quote=FALSE)