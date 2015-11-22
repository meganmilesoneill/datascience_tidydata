# datascience_tidydata

## Summary
This repository contains code that transforms data from the "Human Activity Recognition Using Smartphones Data Set" available on the UCI Machine Learning Repository site here: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

The goal of the script is to combine train and test data into a single dataset, and then use the mean and standard deviation features to generate summary data for each user and activity type.

## Steps to reproduce the data
The following steps were created on a Mac/OSX Yosemite (10.10.5) using RStudio Version 0.99.485. 

* Execute the code in "run_analysis.R" in order to reproduce the data.
* The output of this script is a comma-delimited text file including headers.  The file is called "tiny_data.txt"
* The script unzips the "UCI HAR Dataset.zip" file which contains the files used by "run_analysis.R".  The files used by the script are outlined in the CodeBook.md file.
