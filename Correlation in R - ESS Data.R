#The goal of this research project is to analyze the relationship between 
#the amount of time someone uses on the internet and their overall happiness level.
#This research project utilizes the data from the 2016 results of the European Social Survey.
#The file can be found at https://www.europeansocialsurvey.org/data/download.html?r=8

library(ggplot2)
library(Hmisc)
library(foreign)
library(Rcmdr)

ess<-read.delim("essData.dat", header = TRUE)

#Preview the data
View(ess)
describe(ess$netustm)
describe(ess$happy)

#Both the net usage and life satisfaction variables have outliers.
#Remove the outliers by specifying limits on the data and moving them to a new data frame.

#I used the upper limit of 6000 [60 hours] because this value needs to be < 24 hours/1 day.
#This left the next highest values to be 1440 [14 hours, 40 minutes], which while a long time, not unreasonable
#considering the size of the sample.
#I filtered the happy var to accept values < 11 because this rating was on a 1-10 scale.
#Any value over 10 would be an outlier/NA response.
filtered.ess<-subset(ess, netustm < 6000 & happy < 11, select = c("netustm", "happy"))

#Created a histogram to view the distribution of data for the net usage variable after being filtered
hist.ess.netuse<-ggplot(filtered.ess, aes(netustm))

#The data has a positively skewed distribution
hist.ess.netuse + geom_histogram(binwidth = 25) + labs(x = "Internet Usage (Minutes)", y = "Frequency")

#Created a histogram to view the distribution of data for the life satisfaction variable
hist.ess.life<-ggplot(filtered.ess, aes(happy))

#The data has a negatively skewed distribution
hist.ess.life + geom_histogram() + labs(x = "Happiness Level", y = "Frequency")

#Created a box plot for each variable to check the dispersion of the data
#Internet Usage
box.ess.netuse<-ggplot(filtered.ess, aes(y = netustm)) +
  geom_boxplot(na.rm = FALSE) + labs(y = "Internet Usage (Minutes)")

box.ess.netuse

#Life Satisfaction Level
box.ess.life<-ggplot(filtered.ess, aes(y = happy)) +
  geom_boxplot(na.rm = FALSE) + labs(y = "Happiness Level")
box.ess.life

#Created a scatterplot to get overview of how the internet usage and life satisfaction variables are related
scatter.ess<-ggplot(filtered.ess, aes(netustm, happy))
scatter.ess + geom_point(position = "jitter", size = .2) + geom_smooth(method = "lm") +
  labs(x = "Internet Usage", y = "Happiness Level")


#I ran Pearson, Spearman, and Kendall correlation tests on these variables to determine
#if a negative and significant correlation coefficient would be produced to support my hypothesis.
#I used the cor.test function to produce the p-values and confidence intervals.
#I ran the tests using alternative = "less" based on my prediction that the variables will be negatively correlated.
#Pearson's r = -0.003
cor.test(filtered.ess$netustm, filtered.ess$happy, alternative = "less", method = "pearson")

#Spearman's rho = -0.006
cor.test(filtered.ess$netustm, filtered.ess$happy, alternative = "less", method = "spearman")

#Kendall's tau = -0.005
cor.test(filtered.ess$netustm, filtered.ess$happy, alternative = "less", method = "kendall")

#I computed the R^2 (coefficient of determination) to measure the weight of internet usage on happiness.
#With all of the previously computed correlation values being so small, this value was expected to be small as well.
#R^2 x 100 = .0008 - Less than 1 percent of variability in happiness was correlated to internet usage.
cor(filtered.ess) ^ 2 * 100


#I ran a regression model based off of the two variables and created a new data frame for summary
regression.ess<-lm(happy ~ netustm, data = filtered.ess)
summary(regression.ess)

