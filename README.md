# Getting-and-Cleaning-Data
# - Course Progect

Prepared  by Andrii Krasnyi for Coursera  

This is the course project for the Getting and Cleaning Data Coursera course. The R script,  run_analysis.R , does the following:

* Data download section. 
  * Download file into ./data folder.
  * Unzip files into working directory

* Reading  data section

  * Read test data
  * Read train data

* Data manipulation section
  * Create full set of data
  * Read names
  * Assign variables name
  * select columns  for mean and standard deviation by selecting all  variables the  contans mean or std not depending on case and position in the name.
  * Creating full data set by binding  Features with subject and Activities with 
  * Add  description of activities by activity ID from activity_labels.txt for all measures even if not present in the refering data.frame
  * Rename full data frame with meaningfull names 
  * Create summary table by Subject variable
  * Write  tidy data set to txt using write.table

This resulting in  "tidydata.txt" file
