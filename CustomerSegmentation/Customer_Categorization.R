install.packages("plotrix")
install.packages("gridExtra")
install.packages("NbClust")
install.packages("factoextra")
library(plotrix)
library(purrr)
library(cluster) 
library(gridExtra)
library(grid)
library(NbClust)
library(factoextra)

#Simple Analysis of Data#
customer_data=read.csv("Customers.csv")
str(customer_data)
names(customer_data)
head(customer_data)

summary(customer_data$Age)
sd(customer_data$Age)

summary(customer_data$Annual.Income..k..)
sd(customer_data$Annual.Income..k..)

sd(customer_data$Spending.Score..1.100.)

#Plot Gender Distribution#

#Barplot
barpl=table(customer_data$Gender)
barplot(barpl,main="Male vs Female Distribution",
        ylab="Count",
        xlab="Gender",
        col=rainbow(2),
        legend=rownames(barpl))
#Pie Chart
pct=round(barpl/sum(barpl)*100)
lbs=paste(c("Female","Male")," ",pct,"%",sep=" ")
pie3D(barpl,labels=lbs,
      main="Male vs Female Distribution")

#Plot Age Distribution#

#Histogram
hist(customer_data$Age,
     col="dark blue",
     main="Age Distibution",
     xlab="Age Class",
     ylab="Frequency",
     labels=TRUE)

#Boxplot
boxplot(customer_data$Age,
        col="red",
        main="Age Distibution")

#Plot Annual Income#

#Histogram
hist(customer_data$Annual.Income..k..,
     col="red",
     main="Annual Income Distribution",
     xlab="Income Class",
     ylab="Frequency",
     labels=TRUE)

#Density Plot
plot(density(customer_data$Annual.Income..k..),
     col="red",
     main="Annual Income Distribution",
     xlab="Annual Income Class",
     ylab="Density")

#Plot Spending Score#

#Boxplot
boxplot(customer_data$Spending.Score..1.100.,
        horizontal=TRUE,
        col="blue",
        main="Spending Score Distribution")

#Histogram
hist(customer_data$Spending.Score..1.100.,
     main="Spending Score Distribution",
     xlab="Spending Score Category",
     ylab="Frequency",
     col="blue",
     labels=TRUE)

#Define Number of K-Means Clusters#

#Elbow Method
set.seed(123)

iss <- function(k) {
  kmeans(customer_data[,3:5],k,iter.max=100,nstart=100,algorithm="Lloyd" )$tot.withinss
}

k.values <- 1:10
iss_values <- map_dbl(k.values, iss)

plot(k.values, iss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total intra-clusters sum of squares")

#Average Silhouette Method
k2<-kmeans(customer_data[,3:5],2,iter.max=100,nstart=50,algorithm="Lloyd")
s2<-plot(silhouette(k2$cluster,dist(customer_data[,3:5],"euclidean")))

k3<-kmeans(customer_data[,3:5],3,iter.max=100,nstart=50,algorithm="Lloyd")
s3<-plot(silhouette(k3$cluster,dist(customer_data[,3:5],"euclidean")))

k4<-kmeans(customer_data[,3:5],4,iter.max=100,nstart=50,algorithm="Lloyd")
s4<-plot(silhouette(k4$cluster,dist(customer_data[,3:5],"euclidean")))

k5<-kmeans(customer_data[,3:5],5,iter.max=100,nstart=50,algorithm="Lloyd")
s5<-plot(silhouette(k5$cluster,dist(customer_data[,3:5],"euclidean")))

k6<-kmeans(customer_data[,3:5],6,iter.max=100,nstart=50,algorithm="Lloyd")
s6<-plot(silhouette(k6$cluster,dist(customer_data[,3:5],"euclidean")))

k7<-kmeans(customer_data[,3:5],7,iter.max=100,nstart=50,algorithm="Lloyd")
s7<-plot(silhouette(k7$cluster,dist(customer_data[,3:5],"euclidean")))

k8<-kmeans(customer_data[,3:5],8,iter.max=100,nstart=50,algorithm="Lloyd")
s8<-plot(silhouette(k8$cluster,dist(customer_data[,3:5],"euclidean")))

k9<-kmeans(customer_data[,3:5],9,iter.max=100,nstart=50,algorithm="Lloyd")
s9<-plot(silhouette(k9$cluster,dist(customer_data[,3:5],"euclidean")))

k10<-kmeans(customer_data[,3:5],10,iter.max=100,nstart=50,algorithm="Lloyd")
s10<-plot(silhouette(k10$cluster,dist(customer_data[,3:5],"euclidean")))

fviz_nbclust(customer_data[,3:5], kmeans, method = "silhouette")

#Gap Statistic Method
set.seed(125)
stat_gap <- clusGap(customer_data[,3:5], FUN = kmeans, nstart = 25,
                    K.max = 10, B = 50)
fviz_gap_stat(stat_gap)

k6<-kmeans(customer_data[,3:5],6,iter.max=100,nstart=50,algorithm="Lloyd")
k6

#Clustering Results#

#PCA
pcclust=prcomp(customer_data[,3:5],scale=FALSE)
summary(pcclust)
pcclust$rotation[,1:2]

set.seed(1)
ggplot(customer_data, aes(x =Annual.Income..k.., y = Spending.Score..1.100.)) + 
  geom_point(stat = "identity", aes(color = as.factor(k6$cluster))) + 
  scale_color_discrete(name=" ",
                       breaks=c("1", "2", "3", "4", "5","6"),
                       labels=c("C1", "C2", "C3", "C4", "C5","C6")) +
  ggtitle("Mall Customer Clusters")

ggplot(customer_data, aes(x =Spending.Score..1.100., y =Age)) + 
  geom_point(stat = "identity", aes(color = as.factor(k6$cluster))) +
  scale_color_discrete(name=" ",
                       breaks=c("1", "2", "3", "4", "5","6"),
                       labels=c("C1", "C2", "C3", "C4", "C5","C6")) +
  ggtitle("Mall Customer Clusters")

kCols=function(vec){cols=rainbow (length (unique (vec)))
return (cols[as.numeric(as.factor(vec))])}
digCluster<-k6$cluster; dignm<-as.character(digCluster); 

plot(pcclust$x[,1:2], col =kCols(digCluster),pch =19,xlab ="Clusters",ylab="Category")
legend("bottomleft",unique(dignm),fill=unique(kCols(digCluster)))

