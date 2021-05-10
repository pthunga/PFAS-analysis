# PFAS-analysis

Data: PFAs from EPA library

<Upload figures with higher resolution>
  
 ## Chemotype enrichment among Hits and non hits across different endpoints
  
X axis represents the 36 condensed chemotypes (collapsed from Toxprints_PFAS_clean.csv) and Y represents number of compounds with carrying that chemotype

Each of the 3 rectangles represent one endpoint as indicated in header

Now within one rectangle, say Morph bioactivity BMD10, red = number of hits carrying that chemotype and blue represents number of non-hits carrying that chemotype. A darker shade indicates that the difference in counts between hits on non-hits for that chemotype is statistically enriched.

The Red dotted line within each sub figure plots the total number of hits for that endpoints. For instance, 34 for Morph bioactivity. Since the x axis is set to 140 (which is roughly the total number of PFAS we have), the area to the left side of the red line = Hits & area to the right side = # of non- hits. 

Example interpretation: 

The proportion of chemotypes having S.O among morph hits is statistically higher than the proportion of non-hits carrying that chemotype. We can ballpark this by comparing the proportion of dark red region to the area on the left side of dotted line i.e (~ 12/30) , vs the dark blue region to the area on the right side of the dotted line (~20/109) 

 The proportion of chemotypes having    “chain.alkaneLinear” among non-hits in LPR is statistically higher than the proportion of LPR hits carrying that chemotype. Again, we can ballpark this by comparing the proportion of dark red region to the area on the left side of dotted line i.e (~ 2/34) , vs the dark blue region to the area on the right side of the dotted line (~48/105) 
![image](https://user-images.githubusercontent.com/55261500/117691818-51264d80-b18a-11eb-837e-c76c85b2e7eb.png)


![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/chemotype.JPG)

## Effect of volatility on chemical hit calls

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/volatility.JPG)

![flowchart](https://github.com/pthunga/PFAS-analysis/blob/main/morph_heatmap.JPG)

