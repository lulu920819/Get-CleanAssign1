# Get-CleanAssign1
#Getting and Cleaning Data Assignment

## * Load the data separately
_take the train data as an example, the test data just the same_
> ###  subject
<code>

>- set 
>>path_train_sub <- "./UCI HAR Dataset/train/subject_train.txt"

>- load

>><font color = reds> train_sub </font><- tbl_df(read.table(path_train_sub,col.names = "id"))
</code>

> ###  data
<code>

>- get the feature name
>>features <- tbl_df(read.table("./UCI HAR Dataset/features.txt",check.names = TRUE))

>>var_name <- as.vector(features[[2]])

>- set path 
>>path_train_data <- "./UCI HAR Dataset/train/X_train.txt"

>- load
>><font color = reds>train_data </font><- tbl_df(read.table(path_train_data,col.names = var_name))
</code>

> ###  activity
<code>
>- set path 

>>path_train_activity <- "./UCI HAR Dataset/train/y_train.txt"

>- load
>>train_act <- tbl_df(read.table(path_train_activity,col.names = "act_No"))

>>act_label <- tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt",col.names =c("act_No","activity")))

>- join the table

>><font color = reds>train_act </font><- left_join(train_act,act_label)
</code>

###**Now we get the dataset **

####<font color=red>**train_sub, train_data, train_act**

####**test_sub, test_data, test_act**</font>

****
## * Merge data
<code>
>train <- bind_cols(train_sub,train_act,train_data)

>test <- bind_cols(test_sub,test_act,test_data)

>all <- tbl_df(bind_rows(train,test))
</code>

****
##  * Mean and standard deviation 
<code>
>grouped <- group_by(all,id,activity)

>result <- summarise_each(grouped,funs(mean,sd),-(id:activity))

</code>
****
## * write the result
>`write.table(result,file = "ass1.txt",row.name=FALSE)`
