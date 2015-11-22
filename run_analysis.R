unzip("UCI HAR Dataset.zip")

#load train data
train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names = "activity.code")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names = "subject")
#add subject data to feature data
train$subject <- train_subject$subject
#add activity.code to feature data
train$activity.code <- train_y$activity.code

#load test data
test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names = "activity.code")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names = "subject")
#add subject data to feature data
test$subject <- test_subject$subject
#add activity.code to feature data
test$activity.code <- test_y$activity.code

#combine train and test data into a single data.frame
all.data <- rbind(train, test)

#load features
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
#clean up label names
features$friendly.name <- gsub("-", ".", features$V2)
features$friendly.name <- gsub(",", ".", features$V2)
features$friendly.name <- gsub("\\(", "", features$friendly.name)
features$friendly.name <- gsub("\\)", "", features$friendly.name)

#since we will be using this master list of features to name the columns in the "all.data" data.frame,
#we include here the two additional columns added when combining the label and subject data 
#with the feature data
features <- rbind(features, 
                data.frame(V1=c(562, 563), V2=c("activity.code", "subject"), 
                friendly.name=c("activity.code", "subject")))

#subset the features such that they contain only mean and std features
#in addition to the activity.code and subject features
features.mean.std <- subset(features,  
                          grepl(glob2rx("*mean()-*"), V2) | 
                              grepl(glob2rx("*std()-*"), V2) | 
                              (V2 %in% c("activity.code", "subject")))

#use the features to assign column names
colnames(all.data) <- features$friendly.name

#subset the data to contain only the mean and std columns
all.data.mean.std <- all.data[,features.mean.std$V1]

#assign descriptive activity features to each row
activity.labels.data <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names = c("activity.code", "activity.name"))
all.data.final <- merge(all.data.mean.std, activity.labels.data, by="activity.code")[, union(names(all.data.mean.std), names(activity.labels.data))]

head(all.data.final)

#aggregate the data by subject and activity.name using the mean function
all.data.summary <- aggregate(. ~ subject+activity.name, data=all.data.final, mean)

head(all.data.summary)

write.table(all.data.summary, "tidy_data.txt", sep=",", row.names = FALSE)