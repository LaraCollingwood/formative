library(dplyr)

bm_path <- "data/original/BMX_D.csv"
accel_path <- "data/derived/accel"

# Collect IDs of participants with BMI data
bmi_ids <- read.table(bm_path, sep=",", header=1) %>%
    mutate(bmi_present = as.integer(!is.na(BMXBMI))) %>%
    select(SEQN, bmi_present) %>%
    rename(ID=SEQN)
    
print(head(bmi_ids))

# Collect IDs of participants with accel data
files <- list.files(accel_path, pattern = "^accel-.*\\.txt$")
ids <- sub("^accel-(.*)\\.txt$", "\\1", files)
accel_ids <- data.frame(ID = ids, accel_present = 1)

print(head(accel_ids))

# Combine the two
sample_data <- merge(bmi_ids, accel_ids, by="ID") %>%
    mutate(in_sample = if_else(bmi_present==1 & accel_present==1, 1, 0))
print(head(sample_data))

#print(unique(sample_data$bmi_present))
#print(unique(sample_data$accel_present))

# Check proportions of particpants that have  data
print("bmi present")
print(table(sample_data$bmi_present))
print("accel present")
print(table(sample_data$accel_present))
print("in sample")
print(table(sample_data$in_sample))

# save a sample data file
write.csv(sample_data, file=paste0('data/derived/sample.csv'))