# GettingAndCleaningDataAssignment
Assignment - Getting and Cleaning Data
Author - B A Madhusudhan

The script for execution is "run_analysis.R"

The script requires input files to be stored in a folder called "Data" present in the same folder of run_analysis.R. The directory structure of input data  is to be preserved. The output will be stored in a file called "result.txt" present in the same diretory as run_analysis.R

The code does the following:

1. Loads data into variables with the appropriate names
2. Then the train and test set are merged to create a single data set
3. The measurements of interest here - the mean and standard deviation of each measurement - are extracted and stored in a data frame
4. Descriptive activity names are used to label the dataset
5. The variable (column names) are altered to improve readability
6. The average for each for variable for each activity have been calculated and ordered subject-wise
7. The output is then stored in a text file called "result.txt" 
