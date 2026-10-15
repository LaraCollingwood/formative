how to create and activate the conda environment


# Creating a conda enviroment
In command line, if Conda hasn't launched already, activate it with `conda activate`

Create new enviroment with `conda create -n chosen-env-name`

# View existing enviroments
View existing enviroments with `conda env list`

# Adding packages
First we active the enviroment `conda activate chosen-env-name`

Then we choose packages to upload, e.g. base R and tidyverse

Search for verions of these with `conda search r-base` and `conda search r-tidyverse`

Install specific versions using `conda install r-base=4.4.1` and `conda install r-tidyverse=2.0.0`
Or the latest versions using `conda install r-base` and `conda install r-tidyverse`

List packages installed in enviroment with `conda list`
