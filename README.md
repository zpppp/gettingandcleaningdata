# gettingandcleaningdata

This repo is created for the coursework of the module "getting and cleaning data".

Using data from link (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip),
our project objective is as follow:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script does the following:
1. Set working directory
2. Reading all the text files with data, and giving meaningful names to the columns
3. Combining the datasets for Test and Train for subject, x and y
4. Extract only the mean and standard deviation measurements from x
5. Combining all the datasets into 1 table, renaming column names for the measurements
6. Create tidy table
7. Output text file for tidy table
