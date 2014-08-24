##Code to transform files for Class Assignment in "Get and Use Data"
##Assumes files are in subdirectories Test and Train off of the working directory

##Read in label files
activityCodes <- read.table("activity_labels.txt")
valueNames <- read.table("features.txt")

##Read in sample files
trainValues <- read.table("train/X_train.txt")
trainActivities <- read.table("train/Y_train.txt")
trainSubjects <- read.table("train/subject_train.txt")

testValues <- read.table("test/X_test.txt")
testActivities <- read.table("test/Y_test.txt")
testSubjects <- read.table("test/subject_test.txt")

##STEP 1 MERGE TRAINING AND TEST
mergeValues <- rbind(trainValues, testValues)
mergeActivities <- rbind(trainActivities, testActivities)
mergeSubjects <- rbind(trainSubjects, testSubjects)

##STEP 2 Get the columns that have mean() and std()
##also STEP 4, give the columns meaningful names
colnames(mergeValues) <- valueNames$V2
MSCols <- sort(c(grep("mean()", valueNames$V2, fixed=TRUE), grep("std()", valueNames$V2, fixed=TRUE)))
subValues <- mergeValues[,MSCols]

##STEP 3 Use descriptive activity names
colnames(mergeActivities) <- "Activity.Type"
colnames(mergeSubjects) <- "Subject"
for(i in 1:6){
  mergeActivities$Activity.Type[mergeActivities$Activity.Type==i] <- toString(activityCodes[i, 2])
}

fullSet <- cbind(mergeSubjects, mergeActivities, subValues)

##STEP 5 Create the tidy data set
meanSet <- aggregate(x=fullSet, by=list(fullSet$Subject, fullSet$Activity.Type), FUN="mean")
meanSet <- cbind(meanSet[,1:2],meanSet[,5:length(meanSet)])
colnames(meanSet)[1] <- "Subject"
colnames(meanSet)[2] <- "Activity.Type"
write.table(meanSet, file="tidy_data.txt", row.names=FALSE)


