Explanation of run_analysis.R:

first imported libraries required like plyr and dplyr

then as per given instructions:
1) combined data given in x_* and y_* using rbind and cbind after reading files into R.
    Also provided comprehensive names to columns wherever possible to facilitate merging and subsetting later
2) obtained data regarding mean and standard deviation related variables using reges "grepl" command
    and then combined this subsetted data to the already given labels and x and y sets
3) using a for loop, i made the labels more comprehensive by substituting each numeric value for its counterpart as per given file
    for labels
4) using basic regex parsing, i was able to clean up variable names and also the names of any observation
    made everything lower case
    removed "_" underscores
    no more parantheses
    explicated all value types clearly through regex parsing
5) using the split()-sapply()-join() method to:
    sort data by condition of subject-activity pair
    then find average of each data.frame generated
    lastly rejoin everything back into a tabular format
