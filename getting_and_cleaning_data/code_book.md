
This file explains the columns in the output file `tidy_data.txt` of `run_analysis.R`


### 1. id 

A single integer, a person's id, in range 1-30

### 2. activity

The name of an activity, is one of the six listed below. They were obtained by relpacing numbers in `y_test.txt` and `y_train.txt` by corresponding activity labels in `activity_labels.txt` converted to lowercase.

* walking
* walking_upstairs
* walking_downstairs
* sitting
* standing
* laying

### 3. feature_name

For original description of feature names see `features_info.txt` in `UCI HAR Dataset`.

The original 561 features in `features.txt` were mapped as column names to the data in `X_test` and `X_train`. The features were then filtered to the 33 measurements of mean and 33 measurements standard deviation (containing either `mean()` or `std()` in their name). Then the name components `mean()` and `std()` were removed, dashes replaced by underscores. No further changes were made to keep the naming style compatible with the original and to prevent unnecessary complications.

Note, features containing `meanFreq()` and `gravityMean` were both ignored, as they don't represent the main mean and standard deviation measurements. No other features contain `mean` or `std` in their name.

* fBodyAcc_X
* fBodyAcc_Y
* fBodyAcc_Z
* fBodyAccJerk_X
* fBodyAccJerk_Y
* fBodyAccJerk_Z
* fBodyAccMag
* fBodyBodyAccJerkMag
* fBodyBodyGyroJerkMag
* fBodyBodyGyroMag
* fBodyGyro_X
* fBodyGyro_Y
* fBodyGyro_Z
* tBodyAcc_X
* tBodyAcc_Y
* tBodyAcc_Z
* tBodyAccJerk_X
* tBodyAccJerk_Y
* tBodyAccJerk_Z
* tBodyAccJerkMag
* tBodyAccMag
* tBodyGyro_X
* tBodyGyro_Y
* tBodyGyro_Z
* tBodyGyroJerk_X
* tBodyGyroJerk_Y
* tBodyGyroJerk_Z
* tBodyGyroJerkMag
* tBodyGyroMag
* tGravityAcc_X
* tGravityAcc_Y
* tGravityAcc_Z
* tGravityAccMag


### 4. mean

The average mean value recorded for the corresponding person-activity-feature observation, unitless, in range [-1,1]

### 5. std

The average standard deviation for the corresponding person-activity-feature observation, unitless, in range [-1,1]