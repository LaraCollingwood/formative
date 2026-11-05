#!/bin/bash

## Fix the issues with the accelerometer data files, putting the editted files in the derived folder

og_accel_path=data/original/accel
new_accel_path=data/derived/accel

# copy the original accel files to the derived folder
#cp $og_accel_path/accel*.txt $new_accel_path

# Remove the first line of each file with format <ACTIGRAPH ID=PARTICIPANT_ID>
#sed -i '1d' $new_accel_path/accel*.txt

# Remove the NA lines from the 2 files identified in the checking-data.sh script
sed -i '/NA\tNA\tNA/d' $new_accel_path/accel-31268.txt
sed -i '/NA\tNA\tNA/d' $new_accel_path/accel-34974.txt