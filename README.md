# Getting-and-cleaning-data course project

This README describes the script run_analysis.R that is used to process the raw data and produce the tidy data set.

Information about the raw data etc can be found in the CodeBook.md

## What run_analysis does:

First, it sets up the environment. This may or may not be relevant depending on whether the data was already downloaded or not. I included it for completeness:
* Loading packages: library(plyr); library(dplyr); library(downloader); library(reshape2)
* Making sure there is a folder (or creating one) so we can keep the data separated
* Downloading and unziping the raw data to "./Getting and cleaning data"

Then it cleans and tidies the data:
* Reading the test data, train data, subject data as well as the feature names and activity names
* Combining volonteerID (i.e. 'subject'), activity type (i.e.'y') and measurements (i.e.'X') into a single data frame for each set.
* Combining the training and test data sets into one data set (Req 1)
* Labeling the data set with descriptive variable names given by the 'features.txt' file (Req 4)
* Replacing activity labels with descriptive activity names given by the 'activity_labels.txt' file (Req 3)
* Extracting columns with mean() or std() in the names given by the 'features.txt' file (Req 2)
* Calculating the mean of all variables (except Subject and Activity that are IDs) (Req 5)
* Writing a txt file with the tidy dataset (to "./Getting and cleaning data/Course project.txt")

The data is tidy because it has rows for all (mean) obervations and columns for all variables. 

Because we are interested in a statistical analysis of mean and standard deviation of the measurements, only the features with mean() or std() in the feature name were chosen for extraction (along with Subject and Activity). Finally a tidy data set with the average of each variable for each activity and each subject was prepared. 
