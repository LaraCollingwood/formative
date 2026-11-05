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

