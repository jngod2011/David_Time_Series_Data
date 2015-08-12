# David_Time_Series_Data
analysis of time series data in David's paper  
(http://www.biomedcentral.com/content/pdf/gb-2014-15-7-r89.pdf)

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

Actually the change of order did not make much difference, but both contains negative interpolated values, which will be handled next.  

It seems using spline interpolation will result in negative adbundance, especially for those time series with big gaps. After trying serveral other interpolation methods, cubic interpolation seems to give out the most realistic looking and non-negative interpolated values.  

In the future, we may try Weiner's filter or Kalman filter to estimate missing values if necessary.

# 2. Periodicity analysis
 a. examine power spectrum information, see if there's dominant frequencies representing periodical activities.
    methods to try: FFT vs. Lomb-Scargle method(can handle missing values)
