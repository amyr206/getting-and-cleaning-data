# Getting and Cleaning Data Course Project
## Amy Richards, February 2015

### PURPOSE:

* The files in this repo fulfill the course project requirements for the Johns Hopkins Data Science Specialization class, Getting and Cleaning Data.
* The project description can be found at: https://class.coursera.org/getdata-010/human_grading/view/courses/973497/assessments/3/submissions
* Data from a found dataset is manipulated and tidied by an R script, which produces a text file of tidied data

### FILES IN THIS REPO:

* [README.md](https://github.com/amyr206/getting-and-cleaning-data/blob/master/README.md) - this file
* [run_analysis.R](https://github.com/amyr206/getting-and-cleaning-data/blob/master/run_analysis.r) - conducts the analysis and tidies the data
* [CODEBOOK.pdf](https://github.com/amyr206/getting-and-cleaning-data/blob/master/CODEBOOK.pdf) - describes variables

### ADDITIONAL DATA NEEDED TO CONDUCT ANALYSIS:

* [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip) from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* [run_analysis.r](https://github.com/amyr206/getting-and-cleaning-data/blob/master/run_analysis.R) assumes that the user has downloaded the zipped data file, and that the unzipped files are located in a subfolder of the user's local working R directory called "UCI HAR Dataset"

### ANALYSIS PROCESS:
1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### NOTES:

* I used base R instead of dplyr and tidyr. I understand the code is not as elegant or speedy as it might have been if I used those libraries, but since I am very new to manipulating data in R, I personally found it helpful to build the code with intermediate variables so I had the most visibility into the effect of the code as I wrote it line-by-line. Having written this script successfully in base R, I plan to re-write it using dplyr and tidyr on my own at a later date for practice.

### SOURCES:
* [The Getting and Cleaning Data discussion forums](https://class.coursera.org/getdata-010/forum), particularly these threads:
	+ [David's Project FAQ](https://class.coursera.org/getdata-010/forum/thread?thread_id=49)
	+ [Tidy data and the assignment](https://class.coursera.org/getdata-010/forum/thread?thread_id=241)
	+ [Replacing values id with desc in DF using lookup from another DF](https://class.coursera.org/getdata-010/forum/thread?thread_id=273)
* [Getting and Cleaning Data lectures](https://class.coursera.org/getdata-010/lecture)
* Wickham, Hadley. Tidy Data. *The Journal of Statistical Software*, vol. 59, 2014. 
* Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. *International Workshop of Ambient Assisted Living (IWAAL 2012)*. Vitoria-Gasteiz, Spain. Dec 2012

