# David_Time_Series_Data
analysis of time series data in David's paper

# Data description:
The dataset is comprised of three samples from two subjects: saliva from subject A, stool from subject A and B. 
It's stored in DATA.mat. There are serveral major variables for each sample: xx_otu--absolute abundance for OTUs(OTU X days),
xxx_day--date in a year. (need to add meta data in)

# 1. Data preprocessing
The order of preprocessing in the student's report are interpolation(spline), OTU clustering and Normalization.
(However in their code is interpolation, normalization and OTU clustering...). My order are as follows:  
 a. OTU clustering("phylumotu.m")  
 b. Interpolation("interpotu.m")  
 c. Normalization("normotu.m")  


# 2. Periodicity analysis
 a. examine power spectrum information, see if there's dominant frequencies representing periodical activities.
    methods to try: FFT vs. Lomb-Scargle method(can handle missing values)
