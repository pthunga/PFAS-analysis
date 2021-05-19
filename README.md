# Assessing bioactivity of PFAs in zebrafish and effects of physiochemical properties on its activity

### Data & Analysis in brief: 

1. 24 hpf and 120 hpf behavior responses + morphology evaluations for ~ 140 PFAs from EPA library
2. Censored morphology data using the 'ANY_' endpoint
3. Screened the library for bioactivity using two metrics -  LEL and Benchmark Dose.
4. Fisher exact test to test for associations between volatility status of chemical and bioactivity across endpoints
5. Chemotype enrichment analysis to test for associations between chemotype and bioactivity across endpoints

> Path to processed files on local machine: C:/Users/pthunga/Documents/PhD/PFAS data/results/gui  
> All the code:  C:/Users/pthunga/Documents/PhD/PFAS data/code


### Heatmap of bioactive chemicals

The following figure plots POD of compounds that were hits in atleast one of assays. POD was estimated using LEL for 24 hpf and 120 hpf behavior, and BMD for 120 hpf morphology.

Full list of [EPR](https://github.com/pthunga/PFAS-analysis/blob/main/results/epr.csv) and [LPR](https://github.com/pthunga/PFAS-analysis/blob/main/results/lpr.csv) hits made using LEL is present under the results tab (https://github.com/pthunga/PFAS-analysis/blob/main/results).

BMD10 values for morphology can be found [here](https://github.com/pthunga/PFAS-analysis/blob/main/results/consolidated_new.csv).

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/results/images/global_heatmap.png)

<adjust above figure to include direction of activity + clustering info >  


### Fitting curves to behavioral data

BMD analysis for behavior done using BMDExpress. Sample curvefit for LPR: 

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/results/images/curvefit-bmd.JPG)

Full list of [EPR](https://github.com/pthunga/PFAS-analysis/blob/main/results/epr_BMD.csv) and [LPR](https://github.com/pthunga/PFAS-analysis/blob/main/results/lpr_BMD.csv) hits made using BMD is present under the results tab(https://github.com/pthunga/PFAS-analysis/blob/main/results).

### Effect of volatility on chemical hit calls

Carried out fisher exact test to assess whether there is a significant difference in counts of volatile chemicals across endpoints. Red and blue represent volatile vs non-volatile chemicals in a given endpoint.

Fisher exact test p-val = 0.01 and 0.02 for 5 dpf morph and LPR assays (as indicated on the plot below). i.e., Several of the chemicals that went undetected in 5 dpf morph and behavioral assay are volatile. This is implying that volatility of the compound under consideration could perhaps be influencing the assay? In contrast, no significant differences are seen in the early behavioral assay.  

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/results/images/volatility-new.JPG)

 ### Breaking down chemical hits calls by chemotypes
  
X axis represents the 36 condensed chemotypes (collapsed from Toxprints_PFAS_clean.csv) and Y represents number of compounds with carrying that chemotype. Full Toxprints were downloaded from EPA Chem dashboard. Red and blue represent hits and non-hits in a given endpoint.

Each of the 3 rectangles represent one endpoint as indicated in header

Now within one rectangle, say Morph bioactivity BMD10, red = number of hits carrying that chemotype and blue represents number of non-hits carrying that chemotype. A darker shade indicates that the difference in counts between hits on non-hits for that chemotype is statistically enriched.

The Red dotted line within each sub figure plots the total number of hits for that endpoints. For instance, 34 for Morph bioactivity. Since the x axis is set to 140 (which is roughly the total number of PFAS we have), the area to the left side of the red line = Hits & area to the right side = # of non- hits. Think of CX_halide and bond.X as a "control" of sorts (all PFAs carry this chemotype)

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/results/images/chemotype-new.JPG)

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

### Heatmap of chemicals active in morphology with a BMR50

(figure uses old behavior data)

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/results/images/morph_heatmap.JPG)

