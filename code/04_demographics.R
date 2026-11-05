library(haven)


# load demographics data
demo_data_og <- read_xpt(file="data/original/DEMO_D.xpt")

# make a Tibble containing participant ID (respondent sequence number), gender, age and ethnicity
demo_data <- demo_data_og |> 
  select(SEQN, RIAGENDR, RIDAGEYR, RIDRETH1)

# load body measurement data
bm_data <- read.table("data/original/BMX_D.csv", sep=",", header=1) 

#Reformat the variable names of both the Body Measurement Data and the subset of the demographics data to lowercase
demo_data <- demo_data |> janitor::clean_names()
bm_data <- bm_data |> janitor::clean_names()

# Merge the Body Measurement Data with the demographics data, 
# keeping the rows from the Body Measurement Data. 
bm_data <- bm_data |> left_join(demo_data, by = join_by(seqn))

# Move the demographics variables to the left hand side of the data frame, 
# just to the right of the participant ID.
bm_data <- bm_data |> relocate(seqn, riagendr, ridageyr, ridreth1)

# Read in the derived sample file that records whether accelerometer data are available. Merge it into
# the body measurement and demographics data, moving the “in sample” variable just to the right of
# participant ID and renaming it “in_sample”.
sample_ids <- read.table("data/derived/sample.csv", sep=",", header=1) |> 
  select(ID, in_sample) |> 
  rename(seqn = ID)
bm_data <- bm_data |> 
  left_join(sample_ids) |> 
  relocate(in_sample, .after = seqn)

# create a new categorical binary variable called “obesity”
bm_data <- bm_data |> mutate(obesity = case_when(
  is.na(bmxbmi) ~ NA,
  bmxbmi >= 30 ~ "obese", 
  bmxbmi < 30 ~ "not obese"
  )) |> 
  mutate(obesity = as.factor(obesity)) |> 
  relocate(obesity, .after = bmxbmi)


# summarising the data
bm_data |> 
  filter(!is.na(bmxbmi)) |> 
  group_by(obesity) |> 
  summarise(
    proportion_with_ac_data = mean(in_sample),
    n=n())

bm_data |> 
  filter(!is.na(bmxbmi)) |> 
  group_by(riagendr) |> 
  summarise(
    proportion_with_ac_data = mean(in_sample),
    n=n())

bm_data |> 
  filter(!is.na(ridageyr)) |> 
  filter(ridageyr < 16) |> 
  filter(!is.na(bmxht)) |> 
  summarise(
    max_height = max(bmxht)
  )


# export data
write.csv(bm_data, file=paste0('data/derived/body_measurements.csv'))
