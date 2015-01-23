##step 1
#combine test data and label
testSet <- read.table("test/X_test.txt")
testLabels <- read.table("test/y_test.txt")
testData <- data.frame(id = testLabels, data = testSet)
#combine training data and label 
trainSet <- read.table("train/X_train.txt")
trainLabels <- read.table("train/y_train.txt")
trainData <- data.frame(id = trainLabels, data = trainSet)
# combine train data and test data
data <- rbind(testData, trainData)
##step 2
features <- read.table("features.txt")
meanStdFeatureIndicator <- grepl("mean|std", features[,2])
# need to add true to include the label
overallColumns <- c(TRUE, meanStdFeatureIndicator)
filtedData <- data[, overallColumns]
#step 3
names <- c('activityId', as.character(features[meanStdFeatureIndicator , 2]))
names(filtedData) <- names
#step 4
activityLabels <- read.table("activity_labels.txt")
names(activityLabels) <- c("activityId", "activity")
result <- merge(activityLabels, filtedData , by="activityId")
result$activityId <- NULL
#names(result) <- c('activityId', 'activity', as.character(features[meanStdFeatureIndicator , 2]))
#step 5
write.table(result, "average_data.txt")