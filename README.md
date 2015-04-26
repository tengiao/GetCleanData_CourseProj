# Course:	Getting and Cleaning Data
# Coursework:	Peer Assessment / Course Project
# File:		README.md
# Purpose:	Explains how the scripts (R Code and data files) work and are connected.

1. The Human Activity Recognition (HAR) raw data files from UCI are available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
2. The raw data files used for this project (to ensure they don’t change and remain consistent), however, are downloaded from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
3. The R code script is “run_analysis.R”.
4. The R script assumes the downloaded raw data files exist in the same working directory as the R script in a directory path: "./UCI HAR Dataset/“.
5. “CodeBook.md” describes the variables, data, and transformations performed by the R script to clean up the raw data.
6. The final output from the R script is the tidy data set “meanStdDataAvrg.txt”. 