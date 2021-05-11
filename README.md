# Assessing bioactivity of PFAs in zebrafish and effects of physiochemical properties on its activity

### Data & Analysis in brief: 

1. 24 hpf and 120 hpf behavior responses + morphology evaluations for ~ 140 PFAs from EPA library
2. Censored morphology data using the 'ANY_' endpoint
3. Screened the library for bioactivity using two metrics -  LEL and Benchmark Dose.
4. Fisher exact test to test for associations between volatility status of chemical and bioactivity across endpoints
5. Chemotype enrichment analysis to test for associations between chemotype and bioactivity across endpoints

> Path to processed files on local machine: C:/Users/pthunga/Documents/PhD/PFAS data/results/gui  
> All the code:  C:/Users/pthunga/Documents/PhD/PFAS data/code



  
 ### Breaking down chemical hits calls by chemotypes
  
X axis represents the 36 condensed chemotypes (collapsed from Toxprints_PFAS_clean.csv) and Y represents number of compounds with carrying that chemotype. Full Toxprints were downloaded from EPA Chem dashboard. Red and blue represent hits and non-hits in a given endpoint.

Each of the 3 rectangles represent one endpoint as indicated in header

Now within one rectangle, say Morph bioactivity BMD10, red = number of hits carrying that chemotype and blue represents number of non-hits carrying that chemotype. A darker shade indicates that the difference in counts between hits on non-hits for that chemotype is statistically enriched.

The Red dotted line within each sub figure plots the total number of hits for that endpoints. For instance, 34 for Morph bioactivity. Since the x axis is set to 140 (which is roughly the total number of PFAS we have), the area to the left side of the red line = Hits & area to the right side = # of non- hits. Think of CX_halide and bond.X as a "control" of sorts (all PFAs carry this chemotype)



```
Example interpretation: 

  1. The proportion of chemotypes having S.O among morph hits is statistically higher than the proportion of non-hits carrying 
     that chemotype. We can ballpark this by comparing the proportion of dark red region to the area on the left side of dotted
     line i.e (~ 12/30) , vs the dark blue region to the area on the right side of the dotted line (~20/109) 

  2. The proportion of chemotypes having “chain.alkaneLinear” among non-hits in LPR is statistically higher than the proportion
     of LPR hits carrying that chemotype. Again, we can ballpark this by comparing the proportion of dark red region to the area
     on the left side of dotted line i.e (~ 2/34) , vs the dark blue region to the area on the right side of the dotted 
     line (~ 48/105) 
``` 

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/chemotype.JPG)

### Effect of volatility on chemical hit calls

Carried out fisher exact test to assess whether there is a significant difference in counts of volatile chemicals across endpoints. Red and blue represent volatile vs non-volatile chemicals in a given endpoint.

For morphology, fisher exact test p-val = 0.01 (as indicated on the plot below). That could be perhaps why we're not seeing as many hits in the morphology assay (BMD10 was used)? EPR (recorded @ 24 hpf) on the other hand, is picking up more of these volatile chemicals. 

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/volatility.JPG)

### Heatmap of chemicals active in morphology with a BMR50


![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/morph_heatmap.JPG)

### Fitting curves to behavioral data



