library(data.table) # only for fread
library(dplyr)
library(tidyr)

# ================================================================================
# part one, merge the training and the test sets to create one data set.
# ================================================================================

# for the file reading purposes, the file "UCI HAR Dataset" is assumed to be in the current working directory"
uci_dir <- file.path(".", "UCI HAR Dataset")

# read in test data
subject_test <- fread(file.path(uci_dir, "test", "subject_test.txt"))
X_test <- fread(file.path(uci_dir, "test", "X_test.txt"))
y_test <- fread(file.path(uci_dir, "test", "y_test.txt"))
test_data <- cbind(subject_test, y_test, X_test)

# read in train data
subject_train <- fread(file.path(uci_dir, "train", "subject_train.txt"))
X_train <- fread(file.path(uci_dir, "train", "X_train.txt"))
y_train <- fread(file.path(uci_dir, "train", "y_train.txt"))
train_data <- cbind(subject_train, y_train, X_train)

# merged data set, use rbind because the two sets are disjoint
data <- data.frame(rbind(test_data, train_data))

rm(subject_test, X_test, y_test, test_data, subject_train, X_train, y_train, train_data)



# ================================================================================
# part two, extract only the measurements on the mean and standard deviation for each measurement.
# ================================================================================

feature_names <- fread(file.path(uci_dir, "features.txt"))[[2]]
colnames(data) <- cbind(c("id", "activity", feature_names))
measurement_types <- grep("mean\\(\\)|std\\(\\)", feature_names, value=TRUE)
data <- data[,c("id", "activity", measurement_types)]



# ================================================================================
# part three, add descriptive activity names to name the activities in the data set
# ================================================================================

activity_labels <- fread(file.path(uci_dir, "activity_labels.txt"))[[2]]
data <- mutate(data, activity=sapply(activity, function(index) tolower(activity_labels[index])))



# ================================================================================
# part four, appropriately label the data set with descriptive variable names.
# ================================================================================

data <- gather(data, "feature_name", "value", -c("id", "activity"))



# ================================================================================
# part five, create a second data set with the average of each variable for each activity and each subject
# ================================================================================

average_data <- data %>%
        
        # find the averages
        group_by(id, activity, feature_name) %>%
        summarise(value=mean(value)) %>%
        ungroup %>%
        
        # separate mean and std into different columns
        separate(feature_name, sep="-", into=c("feature_name", "mean_or_std", "axis"), fill="right") %>%
        unite("feature_name", feature_name, axis, sep="_") %>%
        spread(mean_or_std, value) %>%
        
        # final clean-up
        rename(mean = "mean()", std = "std()") %>%
        mutate(feature_name = gsub("_NA", "", feature_name))


write.table(average_data, file="tidy_data.txt", row.names=FALSE)
