# Original Data

* Data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Full description of the data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Transformation Steps
* Following data transformation steps are carried out by the `run_analysis.R` script.
1. Read the test the training sets
	* read `X_test.txt` and `X_train.txt`
	* read the column names in `feature.txt` and assign them to the columns in the `X` files
	* subset the data by selecting columns representing only the mean and standard deviation for each measurement
	* read the subject id in `subject_test.txt` and `subject_train.txt`
	* read the activity id in `y_test.txt` and `y_train.txt`
	* read the activity labels `activity_labels.txt`
	* add three columns representing activity id, subject id and activity name to the data sets

2. Merge the test the training sets

3. Reshape the data
	* melt the dataset using `ActivityID`, `ActivityName`, `SubjectID` as ID variables
	* recast the dataset using `mean` as the aggregation function
	
4. Save the tidy dataset as `tidy.txt`

# Variables
1. The analysis is based on the original dataset. To see full descriptions of the variables please refer to the links in *Original Data*.
2. Only the features on the mean and standard deviation for each measurement are selected in this dataset. Three columns are added to make the data more readable.
