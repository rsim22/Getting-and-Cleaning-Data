##README.md - A description of how run_analysis.R creates the tidy data set.

#Step 0.

This is a preliminary step that sets R's working directory to where the 
Samsung data is held. This line will need changing if the script is executed
on a different machine, depending on where the data is held. Alternativly if the
data is in the current working director (as per marking notes) this step can be
omitted (commented out).

#Step 1.

First the testing data set and the training data sets are loaded into two
data frames using the read.table command. Next the two data frames are row
binded together to form one combined data set.

Next the same process is carried out again to combine the test and training 
subject sets.

#Step 2.

First the features file is loaded into R. Next the grep function is applied 
twice to the features just loaded. The first grep function returns the row 
numbers where the feature name includes the string "mean()", and the second
grep function returns the row numbers where the feature name includes the 
string "std()". These two row number sets combined together and then sorted 
into numerical acending order. This is then used as a list of column numbers
to extract from the combined data set created in step 1.

#Step 3.
The same process used in step 1 is used again to create a combined set of
test and training labels.

Next the activity types are loaded into R using read.table. Then the merge
function is used to merge the combined lables with the activity types, where
merge is done by variable V1, which in both data frames is a integer in the
range 1 to 5 corrosponding to 1 of the 5 activity type. The resulting merged
data is then column binded to the subsetted data frame made in step 2.

#Step 4.
The same row numbers set created in step 2 is used to extract the feature names
from the features data frame loaded in step 2, giving a list of feature names
that include one of the strings "mean()" or "std()". The strings "Activity",
and "Subject" is appended to the end of this list. The names function is then
used to rename the columns of the subsetted data frame created in step 2.

#step 5.
Next the aggregate function is used on the subsetted data frame created 
in step 2, to aggregate by the columns holdings Activity and Subject, and
to aggregate using the mean function.

Next, the first two columns created by the agregate function are renamed 
Activity and Subject, and the old columns for Activity and subject are removed
by subsetting all columns bar the last 2.

Finally the write.table function is used to write the aggregated data to a text
file called TidyDataSet.txt. Append is set to false to overwrite any previous
verison of the data set. Row.name is set to false as requested in the marking
instructions.