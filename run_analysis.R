library(dplyr)
library(tidyr)
library(reshape2)
# subject
path_train_sub <- "./UCI HAR Dataset/train/subject_train.txt"
path_test_sub <- "./UCI HAR Dataset/test/subject_test.txt"

train_sub <- tbl_df(read.table(path_train_sub,col.names = "id"))
test_sub <- tbl_df(read.table(path_test_sub,col.names = "id"))
#View(sub_test)


## data
features <- tbl_df(read.table("./UCI HAR Dataset/features.txt",check.names = TRUE))
var_name <- as.vector(features[[2]])
path_train_data <- "./UCI HAR Dataset/train/X_train.txt"
path_test_data <- "./UCI HAR Dataset/test/X_test.txt"

train_data <- tbl_df(read.table(path_train_data,col.names = var_name))
test_data <- tbl_df(read.table(path_test_data,col.names = var_name))


# activity
path_train_activity <- "./UCI HAR Dataset/train/y_train.txt"
path_test_activity <- "./UCI HAR Dataset/test/y_test.txt"


train_act <- tbl_df(read.table(path_train_activity,col.names = "act_No"))
test_act <- tbl_df(read.table(path_test_activity,col.names = "act_No"))

act_label <- tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt",col.names =c("act_No","activity") ))

train_act <- left_join(train_act,act_label)
test_act <- left_join(test_act,act_label)
#View(act_train)


##create a new dataframe
train <- bind_cols(train_sub,train_act,train_data)
## View(train)
test <- bind_cols(test_sub,test_act,test_data)
## View(test)
all <- tbl_df(bind_rows(train,test))

grouped <- group_by(all,id,activity)
result <- summarise_each(grouped,funs(mean,sd),-(id:activity))

write.table(result,file = "ass1.csv",row.name=FALSE)
##ass1 <- read.table("ass1.csv",header = TRUE)
