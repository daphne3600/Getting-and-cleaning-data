##Load packages
library(plyr); library(dplyr); library(downloader); library(reshape2)

##Make sure there is a folder
if(!file.exists("./Getting and cleaning data/UCI HAR dataset")) {
  dir.create("./Getting and cleaning data/UCI HAR dataset")
}

## Put the download and unzip procedure here.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(fileUrl, dest = "./Getting and cleaning data/UCI HAR dataset.zip")
unzip(zipfile = "./Getting and cleaning data/UCI HAR dataset.zip", exdir = "./Getting and cleaning data")

##Read in test data
X_test_RAW <- read.table("./Getting and cleaning data/UCI HAR dataset/test/X_test.txt")
y_test_RAW <- read.table("./Getting and cleaning data/UCI HAR dataset/test/y_test.txt")
subject_test_RAW <- read.table("./Getting and cleaning data/UCI HAR dataset/test/subject_test.txt")

##Read in train data
X_train_RAW <- read.table("./Getting and cleaning data/UCI HAR dataset/train/X_train.txt")
y_train_RAW <- read.table("./Getting and cleaning data/UCI HAR dataset/train/y_train.txt")
subject_train_RAW <- read.table("./Getting and cleaning data/UCI HAR dataset/train/subject_train.txt")

##Combine volonteerID (i.e. 'subject'), activity type (i.e.'y') and measurements (i.e.'X') into a single data frame for each set.
test_RAW <- cbind.data.frame(X_test_RAW, subject_test_RAW, y_test_RAW)[, c(562, 563, 1:561)]
train_RAW <- cbind.data.frame(X_train_RAW, subject_train_RAW, y_train_RAW)[, c(562, 563, 1:561)]

##Combine the training and test data sets into one data set (Req 1)
all_data_RAW <- rbind.data.frame(train_RAW, test_RAW)

##Read in 'features.txt' file
features <- read.table("./Getting and cleaning data/UCI HAR dataset/features.txt", stringsAsFactors = FALSE)

##Label the data set with descriptive variable names given by the 'features.txt' file (Req 4)
names(all_data_RAW) <- c("Subject", "Activity", features[,2])

##Read in 'activity_labels.txt' file
activity_labels <- read.table("./Getting and cleaning data/UCI HAR dataset/activity_labels.txt", stringsAsFactors = FALSE)

##Replace activity labels with descriptive activity names given by the 'activity_labels.txt' file (Req 3)
all_data_RAW$Activity <- as.character(all_data_RAW$Activity) ## Need 'Activity' values as char
all_data_RAW$Activity[all_data_RAW$Activity == "1"] <- activity_labels[1,2]
all_data_RAW$Activity[all_data_RAW$Activity == "2"] <- activity_labels[2,2]
all_data_RAW$Activity[all_data_RAW$Activity == "3"] <- activity_labels[3,2]
all_data_RAW$Activity[all_data_RAW$Activity == "4"] <- activity_labels[4,2]
all_data_RAW$Activity[all_data_RAW$Activity == "5"] <- activity_labels[5,2]
all_data_RAW$Activity[all_data_RAW$Activity == "6"] <- activity_labels[6,2]

##Extract columns with mean() or std() in the names given by the 'features.txt' file (Req 2)
extract_data <- all_data_RAW[,c(1:2,3:8,43:48,83:88,123:128,163:168,203:204,216:217,229:230,242:243,255:256,
                                268:273,347:352,426:431,505:506,518:519,531:532,544:545)] 

## Calculate the mean of all variables (except Subject and Activity that are IDs) (Req 5)
melted <- melt(extract_data, id = c("Subject", "Activity"))
casted <- dcast(melted, Subject + Activity ~ variable, mean)

## Write a txt file with the tidy dataset
write.table(casted, file = "./Getting and cleaning data/Course project.txt", row.names = FALSE)

