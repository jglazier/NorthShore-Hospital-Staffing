"Load packages"
require(MASS)
"Below we have the average hours of demand per location for each respective 
room. Keep in mind the 5 observations are from a given month and day for the years 2012-2016. This is
for fridays in december. We take this data and then are able to create our inverse covariance matrix, 
which we will use in our Julia optimization program"


room1= c(8, 9, 8.25, 6.5, 8.2); 
room1<-data.frame(room1);

room2=c(6.5, 6.75, 6.75, 5.75, 6);
room2<-data.frame(room2);

room3=c(6.25, 3.5, 5.75, 4.5, 4.4); 
room3<-data.frame(room3);

room4=c(3.25, 1.75, 4, 3.75, 2.2);
room4<-data.frame(room4);

room5=c(.25, .5, .75, .25, 0);
room5<-data.frame(room5);

room6=c(0,0,0,0,0); 
room6<-data.frame(room6);

full=cbind(room1,room2,room3,room4,room5,room6); 

av1=mean(full$room1);
av2=mean(full$room2); 
av3=mean(full$room3);
av4=mean(full$room4);
av5=mean(full$room5); 
av6=mean(full$room6);


u=c(u1,u2,u3,u4,u5,u6); 

psq=10.645; 

cvr<-cov(full);
invcvr<-ginv(cvr);
inv<-as.data.frame(invcvr)

write.csv(inv, file="inversematrixfridec1.csv")

