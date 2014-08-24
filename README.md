GetAndCleanData
===============

Repository for getdata-006 class project.

The run_analysis.r program will take the input data sets:

- test/subject_test.txt
- test/X_test.txt
- test/Y_test.txt
- train/subject_train.txt
- train/X_train.txt
- train/Y_train.txt
- activity_labels.txt
- features.txt

...and generate the appropriate tidy_data.txt file as output.

The following steps are part of the process:
1. Read in all of the data files.
2. Merge training and test files using rbind().
3. Assign the variables in the X_test data the names from the features file.
3. Use grep() to grab only the columns associated with mean() and std() and filter the variable columns.
4. Replace the activity codes with the activity decodes.
5. Use cbind() to merge the subject, activity and variable data.
6. Use the aggregate function to get the mean values for the variables by subject and activity.
7. Clean up the column labels after aggregate.
8. Write the file to the tidy_data.txt file.

Simply set the working directory to where your input files are located and run the script.
