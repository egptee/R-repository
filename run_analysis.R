# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#result dataset will be stored in the DIR_PATH/result.txt


run_analysis<-function(){
  #paths
  DIR_PATH <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset";
  trset_path<-paste(DIR_PATH,"/train/X_train.txt",sep="");
  trlab_path<-paste(DIR_PATH,"/train/Y_train.txt",sep="");
  teset_path<-paste(DIR_PATH,"/test/X_test.txt",sep="");
  telab_path<-paste(DIR_PATH,"/test/Y_test.txt",sep="");  
  featurename_path <-paste(DIR_PATH,"/features.txt",sep="");
  trsubject_path <-paste(DIR_PATH,"/train/subject_train.txt",sep="");  
  tesubject_path <-paste(DIR_PATH,"/test/subject_test.txt",sep="");  
  activitylabel_path <-paste(DIR_PATH,"/activity_labels.txt",sep="");
  
  write_path<-paste(DIR_PATH,"/result.txt",sep="");
  #read
  featurename<-read.table(featurename_path,header=FALSE);
  trsubject<-read.table(trsubject_path,header=FALSE);
  tesubject<-read.table(tesubject_path,header=FALSE);
  activitylabel<-read.table(activitylabel_path,header=FALSE);
  #read test set and train set
  teset<-read.table(teset_path,header=FALSE);
  telab<-read.table(telab_path,header=FALSE);
  trset<-read.table(trset_path,header=FALSE);
  trlab<-read.table(trlab_path,header=FALSE);
  
  #combines
  datasubject<-rbind(tesubject,trsubject);
  dataset<-rbind(teset,trset);
  datalab<-rbind(telab,trlab);
  
  #names
  activityname<-activitylabel[datalab[,],][,2];   #datalab is a 1dim dataframe datalab[,](with a comma)is a vector
  #重新改写名字，使他们不重复  reedit the featurenames so as to make them unique 
  fname=vector();#future col names
  for(i in 1:length(featurename[,1])){
    fname[i]<-paste(featurename[i,2],"-f",featurename[i,1],sep="");
  }
 
  #extracts
  #找到这个数组中包含特定词的位置 find the col indexs whose featurename contain the special characters mean and std
  hmean<-grep("mean",featurename[,2],fixed=TRUE); 
  hstd<-grep("std",featurename[,2],fixed=TRUE);
  hcol<-c(hmean,hstd);
  #extract the xyz-mean and xyz-std coloums
  dataset<-dataset[,hcol];
  fname<-fname[hcol];

  #cal the means 
  newdata<- aggregate(x=dataset,by=list(activityname,datasubject[,]),FUN="mean");
  #add extral "activity_name" "subject_name"
  fname<-c("activity_name","subject_name",fname);
  #add names
  dimnames(newdata)[[2]]<-fname;
  #write newdataset
  write.table(format(newdata,scientific=TRUE),write_path,row.names=FALSE,col.names=TRUE,sep="\t",quote=FALSE)  
}