# set working dir
setwd("./UCI HAR Dataset")

#read features and activity label txt files
features <- read.table("./features.txt", header=FALSE)
actLabels <- read.table("./activity_labels.txt",header=FALSE)

#read subject,x,y from test folder
subTest <- read.table("./test/subject_test.txt", header=FALSE)
xTest <- read.table("./test/X_test.txt", header=FALSE)
yTest <- read.table("./test/Y_test.txt", header=FALSE)

#read subject,x,y from train folder
subTrain <- read.table("./train/subject_train.txt", header=FALSE)
xTrain <- read.table("./train/X_train.txt", header=FALSE)
yTrain <- read.table("./train/Y_train.txt", header=FALSE)

#give column names
colnames(actLabels) <- c("actLabel","act")
colnames(yTest) <- "actLabel"
colnames(yTrain) <- "actLabel"
colnames(subTest) <- "subID"
colnames(subTrain) <- "subID"
colnames(xTest) <- features[,2]
colnames(xTrain) <- features[,2]

#combine test and train datasets
subTestTrain <- rbind(subTest,subTrain)
yTestTrain <- rbind(yTest,yTrain)
xTestTrain <- rbind(xTest,xTrain)

#add activity name
yTestTrain <- merge(yTestTrain, actLabels, by="actLabel")

#extract only mean and std measurements
xcolNames <- colnames(xTestTrain)
meanstdLogic <- (grepl("-mean",xcolNames) & !grepl("-meanFreq",xcolNames) | grepl("std", xcolNames))
xMeanStd <- xTestTrain[,meanstdLogic]

#put together subject,x,y data
data <- cbind(subTestTrain,yTestTrain,xMeanStd)

#make column names more readable
dataColNames <- colnames(data)
for (i in 1:length(dataColNames)){
  dataColNames[i] <- gsub("\\()","",dataColNames[i])
  dataColNames[i] <- gsub("^(t)","time",dataColNames[i])
  dataColNames[i] <- gsub("^(f)","freq",dataColNames[i])
  dataColNames[i] <- gsub("BodyBody","Body",dataColNames[i])
  dataColNames[i] <- gsub("-mean","Mean",dataColNames[i])
  dataColNames[i] <- gsub("-std","Std",dataColNames[i])
}
colnames(data)<-dataColNames

#create tidy dataframe
tidy <- tbl_df(data)
tidy <- tidy %>% group_by(subID,act) %>% summarise_each(funs(mean))

#write tidy table to file
write.table(tidy, file="./tidy.txt", row.names =FALSE)
