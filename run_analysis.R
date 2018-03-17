
> fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> download.file(fileUrl,destfile="./Desktop/Dataset.zip")
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
==================================================
downloaded 59.7 MB

> unzip(zipfile="./Desktop/Dataset.zip",exdir="./Desktop")
> x_train <- read.table("./Desktop/UCI HAR Dataset/train/X_train.txt")
> y_train <- read.table("./Desktop/UCI HAR Dataset/train/y_train.txt")
> subject_train <- read.table("./Desktop/UCI HAR Dataset/train/subject_train.txt")
> x_test <- read.table("./Desktop/UCI HAR Dataset/test/X_test.txt")
> y_test <- read.table("./Desktop/UCI HAR Dataset/test/y_test.txt")
> subject_test <- read.table("./Desktop/UCI HAR Dataset/test/subject_test.txt")
> features <- read.table('./Desktop/UCI HAR Dataset/features.txt')
> activityLabels = read.table('./Desktop/UCI HAR Dataset/activity_labels.txt')
> 
> 
> 
> colnames(x_train) <- features[,2] 
> colnames(y_train) <-"activityId"
> colnames(subject_train) <- "subjectId"
> 
> 
> colnames(x_test) <- features[,2] 
> colnames(y_test) <- "activityId"
> colnames(subject_test) <- "subjectId"
> 
> 
> colnames(activityLabels) <- c('activityId','activityType')
> 
> 
> mrg_train <- cbind(y_train, subject_train, x_train)
> mrg_test <- cbind(y_test, subject_test, x_test)
> allData<- rbind(mrg_train, mrg_test)
> 
> 
> colNames <- colnames(allData)
> 
> 
> 
> mean_and_std <- (grepl("activityId" , colNames) | 
+                  grepl("subjectId" , colNames) | 
+                  grepl("mean.." , colNames) | 
+                  grepl("std.." , colNames) 
+                  )
> 
> setForMeanAndStd <- allData[ , mean_and_std == TRUE]
> 
> dataWithActivityNames <- merge(setForMeanAndStd, activityLabels,
+                               by='activityId',
+                               all.x=TRUE)
> 
> 
> Tidydata <- aggregate(. ~subjectId + activityId, dataWithActivityNames, mean)
> 
> Tidydata <- Tidydata[order(Tidydata$subjectId, Tidydata$activityId),]
> 
> 
> write.table(Tidydata, "Tidydata.txt", row.name=FALSE)