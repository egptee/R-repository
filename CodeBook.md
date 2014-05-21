this file is the codebook tidy data got from the dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
by using the r script run_analysis.R 

this data processing r script was tested in R version 3.1, with only one variable needed to be set, which is the DIR_PATH in the first line in the function code, which should be the directory where the raw data locates. And the result will be written in the same directory as result.txt,too. 

the r scrip will do the processing below:

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement to the new dataset. 

use the combination of corresponding featurename+"-f"+corresponding colIndex to name each coloum of the new dataset

add corresponding activitynames to each row of the new dataset ,as a new coloum,in the first col place, with a colname of activity_name

add corresponding subjectnum to each row of the new dataset, as a new coloum,in the second col place,with a colname of subject_name

aggregate the new dataset , by the activitynames and the subjectnum, using the mean function. then you get the tidy dataset  with the average of each variable for each activity and each subject.

the result.txt has a format as this:

the first line is the corresponding coloum variable names , separated by '\t'

form the second line, each line corresponding a record , with corresponding coloum variable value separated by '\t'

