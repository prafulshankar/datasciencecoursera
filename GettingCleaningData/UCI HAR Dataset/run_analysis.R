library(plyr)
library(dplyr)


##1 combining
#main logs to help name and classify the data
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

#cleaning activity_labels
activity_labels$V2 <- gsub("_","", as.character(activity_labels$V2))

#extract training data
set_train <- read.table("train/X_train.txt")
label_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

#extract test data
set_test <- read.table("test/X_test.txt")
label_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

#combine sets and separate mean and std columns
sets_combine <- rbind(set_train, set_test)
names(sets_combine) <- as.character(features$V2)

#combine labels
labels_combine <- rbind(label_train, label_test)
names(labels_combine) <- c("activity_label")

#combind subjects
subjects_combine <- rbind(subject_train, subject_test)
names(subjects_combine) <- c("Subject")



## 2 obtain mean and standard deviation related information
#subset sets that have columns related to mean or std
sets_combine_meanstd <-sets_combine[,grepl("mean|std", names(sets_combine), ignore.case = T)]

#final combination with subjects and labels
final_combined_meanstd <- cbind(subjects_combine, labels_combine, sets_combine_meanstd)


## 3 Using descriptve activity names
#making use of the activity_label to name activities
for (a in 1:length(final_combined_meanstd$activity_label))
{final_combined_meanstd$activity_label[a] <- as.character(activity_labels[final_combined_meanstd$activity_label[a] , 2])}


## 4 setting descriptive labels for each column(variable)
#cleaning names and variables
names(final_combined_meanstd) <- tolower(names(final_combined_meanstd))
names(final_combined_meanstd) <- gsub("_","",names(final_combined_meanstd))
names(final_combined_meanstd) <- gsub('\\(|\\)',"",names(final_combined_meanstd))
names(final_combined_meanstd) <- make.names(names(final_combined_meanstd))
names(final_combined_meanstd) <- gsub('^t',"timedomain\\.",names(final_combined_meanstd), ignore.case = T)
names(final_combined_meanstd) <- gsub('^f',"frequencydomain\\.",names(final_combined_meanstd), ignore.case = T)
names(final_combined_meanstd) <- gsub('Mag',"\\.magnitude",names(final_combined_meanstd), ignore.case = T)
names(final_combined_meanstd) <- gsub('angle',"angle\\.",names(final_combined_meanstd), ignore.case = T)

## 5 creating tidy data set with averages for subject-activity pair
## create a split based on subject and label
split_ans_init <- sapply(split(final_combined_meanstd[, 3:88], list(final_combined_meanstd$subject, final_combined_meanstd$activitylabel)),colMeans)
#split_ans_init <- as.data.frame(split_ans_init)
split_ans_init <- as.table(split_ans_init)
write.table(split_ans_init, file = "answer.txt", row.names = F)