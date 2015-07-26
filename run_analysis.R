#### Prepared  by Andrii Krasnyi for Coursera - 

## getwd()

###### Data download section. 
#######################################################################################


## Download file into ./data folder.
## This section is commented because need to done once  for the load of initial dataset.
## You need to un comment when performing data load
## Once data down loaded please refer to destination  forlder
##if(!file.exists("data")){dir.create("data")}
##   fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##   download.file(fileUrl,destfile="./data/UCI HAR Dataset.zip",method="auto")
   
## Unzip files into working directory
##unzip(zipfile="./data/UCI HAR Dataset.zip",exdir="./data")

## Clear working environment

##Data manipulation section. 

remove(list = ls())

#### Reading  data section
######################################################################################
pathref <- file.path("./data" , "UCI HAR Dataset")

## Read test data
data_X_test <- read.table(file.path(pathref, "test", "X_test.txt"), header = FALSE)
data_y_test <- read.table(file.path(pathref, "test", "Y_test.txt"), header = FALSE)
Sbj_test <- read.table(file.path(pathref, "test", "subject_test.txt"), header = FALSE)


## Read train data
data_X_train <- read.table(file.path(pathref, "train", "X_train.txt"), header = FALSE)
data_y_train <- read.table(file.path(pathref, "train", "y_train.txt"), header = FALSE)
Sbj_train <- read.table(file.path(pathref, "train", "subject_train.txt"), header = FALSE)

## Create full set of data

data_x_full <- rbind(data_X_train,data_X_test)
data_y_full <- rbind(data_y_train, data_y_test)
datasubj  <- rbind (Sbj_train, Sbj_test)

## Read names
Activity_names <- read.table(file.path(pathref, "activity_labels.txt"), header = FALSE)
Features_names<- read.table(file.path(pathref, "features.txt"), header = FALSE)

## Assign variables name
names (data_x_full) <- Features_names$V2
names(data_y_full) <- c("Activity")
names(datasubj) <- c("Subject")

names(Activity_names) <-c("Activity_ID", "Activity_Decs")

## select columns  for mean and standard deviation by selecting all  variables the  contans mean or std not depending on case and position in the name.

library(dplyr)

data_x_full1 <- data_x_full[!duplicated(names(data_x_full))]

####m1 <- grep("mean()" && !"meanFreq", names(data_x_full1), ignore.case = TRUE)
####s <- grep("std()", names(data_x_full1), ignore.case = TRUE)
####data_x_mean_std <- select(data_x_full1, s,m1 )

m <- grep("-(mean|std)\\(\\)", names(data_x_full1))
data_x_mean_std <- select(data_x_full1, m)

## Creating full data set by binding  Features with subject and Activities with 
####### full_data <- cbind(data_x_mean_std, datasubj)
####### full_data <- cbind(full_data, data_y_full)
full_data <- data_x_mean_std %>% cbind(datasubj) %>% cbind(data_y_full)

## Add  description of activities by activity ID from activity_labels.txt for all measures even if not present in the refering data.frame

full_data <- full_data %>% merge(Activity_names, by.x = "Activity", by.y = "Activity_ID", all.x = TRUE)


## Rename full data frame with meaningfull names 
names(full_data)<-gsub("^t", "time", names(full_data))
names(full_data)<-gsub("^f", "frequency", names(full_data))
names(full_data)<-gsub("Acc", "Accelerometer", names(full_data))
names(full_data)<-gsub("Gyro", "Gyroscope", names(full_data))
names(full_data)<-gsub("Mag", "Magnitude", names(full_data))
names(full_data)<-gsub("BodyBody", "Body", names(full_data))

## Create summary table by Subject variable

tidy_data <- full_data %>% group_by( Activity, Subject) %>% summarise_each(funs(mean))


## Write  tidy data set to txt using write.table

write.table(tidy_data, file = "tidydata.txt",row.name=FALSE)

