# Assessing bioactivity of PFAs in zebrafish and effects of physiochemical properties on its activity

### Data & Analysis in brief: 

1. 24 hours post fertilization (hpf) and 5 days post fertilization (dpf) behavior responses + morphology evaluations for 139 PFAs from EPA library
2. Censored morphology data using 'ANY_' endpoint
3. Screened the library for bioactivity using Benchmark Dose as a metric (BMR 10).
4. Fisher exact test to test for associations between volatility status of chemical and bioactivity across endpoints
5. Chemotype enrichment analysis to test for associations between chemotype and bioactivity across endpoints

> Path to processed files on local machine: C:/Users/pthunga/Documents/PhD/PFAS data/results/gui  
> All the code:  C:/Users/pthunga/Documents/PhD/PFAS data/code


### Heatmap of bioactive chemicals

The following figure plots POD of compounds that were hits in atleast one of assays. POD was estimated as the Benchmark Dose that elicited 10% change in response. 

Full list of [hits](https://github.com/pthunga/PFAS-analysis/blob/main/results/final_consolidated.csv) and their BMD values is present under the [results](https://github.com/pthunga/PFAS-analysis/blob/main/results) tab.


![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/results/images/global_heatmap_bmd.svg)

### Effect of volatility on chemical hit calls

Carried out fisher exact test to assess whether there is a significant difference in counts of volatile chemicals across endpoints. Red and blue represent volatile vs non-volatile chemicals in a given endpoint.

Fisher exact test p-val = 0.01 and 0.04 for 5 dpf morphology and LPR assays (as indicated on the plot below). i.e., Several of the chemicals that went undetected in 5 dpf morph and behavioral assay are volatile. This suggests that the volatility of the compound under consideration could perhaps be influencing whether or not the chemical's bioacitivty is detected in the assay. In contrast, no significant differences are seen in the early time point behavioral assay.  

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/results/images/volatility-ftest.svg)

 ### Breaking down chemical hits calls by chemotypes
 
 ToxPrint chemotypes for all 139 PFAs was obtained from [EPA’s Chemistry Dashboard](https://comptox.epa.gov/dashboard/dsstoxdb/batch_search). The large set of publicly available ToxPrint chemotypes were collapsed into [36 broader chemotype categories](https://github.com/pthunga/PFAS-analysis/blob/main/results/). Then, the chemotypes that were present in less than 5% of all chemicals in the dataset were removed from analysis. 
  
The vertical axis represents 19 broad chemotype-categories obtained by collapsing Toxprint chemotype information downloaded from EPA’s Chemistry Dashboard.  The horizontal axis represents the number of compounds carrying that chemotype. Each rectangular section represents bioactivity in the indicated assay (Morphology, EPR and LPR). Teal fill represents the compounds that carried a certain chemotype and induced bioactivity in a specific, whereas grey indicates compounds that did not induce bioactivity but carried that chemotype. Chemotypes that were statistically enriched (fisher exact test p-value <0.05) among hits or non-hits are shown in darker shades. The vertical red dotted line indicates the total number of compounds that induced a hit within each assay.

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/results/images/chemotypePlot-BMDhits.svg)


