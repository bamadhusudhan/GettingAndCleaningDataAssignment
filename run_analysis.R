require(dplyr)

#Load data into appropriate variables
#The following libe maybe removed when running the code elsewhere 
setwd("/Users/BAM/Desktop/R/GettingAndCleaningDataAssignment/Data")
#setwd("./Data")

xtest<-read.table("./test/X_test.txt")
ytest<-read.table("./test/y_test.txt")

testsubject<-read.table("./test/subject_test.txt")

xtrain<-read.table("./train/X_train.txt")
ytrain<-read.table("./train/y_train.txt")

trainsubject<-read.table("./train/subject_train.txt")

features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

#1 Merges the training and the test sets to create one data set.

xdata<-rbind(xtrain,xtest)
names(xdata)<-features$V2
subject<-rbind(trainsubject,testsubject)
names(subject)<-"Subject"
ydata<-rbind(ytrain,ytest)
names(ydata)<-c("Activity")
final_xy<-cbind(xdata,ydata)


#2 Extracts only the measurements on the mean and standard deviation for each measurement and stores them in a data frame called final_df.

mean_std<-grep("mean()|std()",names(xdata))
mean_std_df<-final_xy[,mean_std]
final_df<-cbind(mean_std_df,subject,ydata)


#3 Uses descriptive activity names to name the activities in the data set

names(activity_labels$V2)<-c(1,2,3,4,5,6)
final_df$activity<-activity_labels$V2[final_df$activity]


#4 Appropriately label the data set with descriptive variable names.
#The following lines are used to clean up the column names and ensure better readability

names(final_df)<-gsub("[()]","",names(final_df))
name<-sapply(names(final_df),function(x){if(grepl("^t",x)){return(gsub(x,paste(gsub("^t","",x),"(Time)"),x))} else if(grepl("^f",x)){return(gsub(x,paste(gsub("^f","",x),"(Frequency)"),x))}else {return(x)}},USE.NAMES = FALSE)
names(final_df)<-gsub("Acc","Acceleration",gsub("Gyro","Gyroscope",gsub("Mag","Magnitude",gsub("BodyBody","Body",name))))


#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activityand each subject.

result_df<-final_df%>%group_by(Subject,Activity)%>%summarise_all(mean)
write.table(result_df,"../result.txt",row.names = FALSE )


