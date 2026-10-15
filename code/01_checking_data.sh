#!/bin/bash

## Check the data files for issues, such as missing values, incorrect formats, or unexpected characters. 
## This script will help identify any problems in the data before further processing.

bm_path=data/original/BMX_D.csv
accel_path=data/original/accel

# Body measurement file checks
echo "---------------------------------------------------
Checking body measurement file
---------------------------------------------------"

# Print head
echo "Top 5 lines of body measurement file:"
head -n5 $bm_path
echo "..."

# State number of columns
echo "Number of columns:"
awk -F, 'NR==1 {print NF}' $bm_path
# State columns
echo "Column headers:"
head -n 1 $bm_path
# Print any lines with the wrong number of columns / fields
echo -e "\n\nPrint any lines that do not have 28 columns:"
awk -F, '{print NF}' $bm_path | grep -v 28
echo "..."

# Check the number of lines in the file
echo "Number of lines (including headers):"
wc -l < $bm_path 
# Number of participants
echo "Number of participants:"
tail -n +2 $bm_path | wc -l 
# Number of participants with a BMI value
echo "Number of participants with a BMI value:"
awk -F',' 'NR>1 && $12 != "NA"' $bm_path | wc -l



# Accelerometer file checks
echo "---------------------------------------------------
Checking accelerometer files
---------------------------------------------------"

# List some file names
echo "Some file names:"
ls $accel_path | head -n5
echo "..."

# Number of participants/file
echo "Number of participants/files:"
ls $accel_path | wc -l
echo "..." 

# Get id line format
echo "ID line format:"
awk 'NR==1' $accel_path/accel-31128.txt
# Get column headers
echo "Column headers:"
awk 'NR==2' $accel_path/accel-31128.txt
echo "..."

# Check number of columns and rows
echo "Expected number of columns:"
awk -F'\t' 'NR==2 {print NF}' $accel_path/accel-31128.txt
echo "Expected number of rows:"
wc -l < $accel_path/accel-31128.txt
echo "Expected number of measurements:"
tail -n +3 $accel_path/accel-31128.txt | wc -l 
echo "..."

# Find any files with the wrong number of headers
echo "Checking files for wrong number of headers:"
#awk -F'\t' '!/</ && NF!=8 {print FILENAME ": line " FNR ": " NF " fields"}' $accel_path/accel-*.txt
echo "(Files that contain less than 8 columns: accel-31268.txt, 34974.txt)"
echo "..."

# Find any files missing the ID tag
echo "Checking files all have an ID tag at the top"
#awk -F'\t' 'NF==1 && !/</ {print FILENAME}' $accel_path/accel-*.txt
echo "(All files have an ID tag)"
echo "..."

# Find any files with the wrong number of rows
echo "Checking files for the wrong number of rows:"
#wc -l $accel_path/accel-*.txt | grep -v 10082 
echo "(Loads of files don't have 10082 rows)"










#ls "$accel_path" | grep -Ev '^accel-[0-9]{5}\.txt$'

# for file in "$accel_path"/*.txt;
# do 
#     #id=$(basename "$file" .txt | cut -d'-' -f2)
#     #echo $id 


# done
