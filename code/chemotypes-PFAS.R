library(tidyr)
setwd("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/")

tp = read.csv("Toxprints_PFAS_Clean.csv") #read toxprints file 
tp[tp$PREFERRED_NAME == "4:4 Fluorotelomer alcohol",1] = "3792-02-7" #fix this chemical's CAS ID formatting 
CTS = tp 
CT_grouped = tp[,c(1:3)] #just get first 3 cols, then keep appending collapsed fingerprints to this DF

#following code chunk collapses chemotypes. Skip if already made
#broad chemotype list for PFAS toxprints

CT = c("element_metal","C..Z..C.Q", "C..O.N" , "C..O.O", "bond.C.O","CC..O.C",
       "CN_amine","COC","COH_alcohol","CX_halide",
      "P.O",
       "quatN","S..O.N","S..O.O","S..O.X","bond.X","bond.metal","alkaneBranch","alkaneCyclic","chain.alkaneLinear",
       "alkeneLinear","aromaticAlkane","oxy.alkaneLinear",
       "ligand","ring.hetero")

##the following Chemotypes have only one column with that name -- so the 'unite' command does not work on them 
singular_CT = c("bond.C.N","CS","N..C.","NC.O", "OZ_oxide","PC","QQ.Q.O_S","S.O","alkeneBranch", "ring.aromatic", "S.N")

full.chemo = c(CT,singular_CT)

for(i in 1:length(CT)){
  CTgroupname = CT[i]
  CT_subset = unite(CTS[,c(grep(CTgroupname, colnames(CTS)))] ,sep = "", col = CTgroupname) #unite rows with common keywords
  # CT_subset = within(CT_subset, CTgroupname[CT_subset$CTgroupname <= 0] <- 1) #why did i do this the first time? 
  CT_subset$CTgroupname[as.numeric(CT_subset$CTgroupname) <= 0] = 0 #if its all 0, make it 0
  CT_subset$CTgroupname[as.numeric(CT_subset$CTgroupname) > 0] = 1 #even if one of them is 1, make it 1
  CT_grouped = cbind(CT_grouped, CT_subset) #append
}
#now just append rest of cols
for(i in 1: length(singular_CT)){
  CT_grouped = cbind(CT_grouped,CTS[,grep(singular_CT[i], colnames(CTS))]) #grab the col with chemotype of interest and append it to DF
}
colnames(CT_grouped)[4:39] = full.chemo

rm(list=setdiff(ls(), "CT_grouped"))


###  Code to make chemotype plot
getCTcounts <- function(test,other,tp){
  
  #Get  chemotypes of hit chemicals
  CT_grouped = tp[tp$CAS %in% test$CASRN, -c(2:3)]
  
  CT_grouped[,-1] <- lapply(CT_grouped[,-1], function(x) as.numeric(x))
  CT_grouped = rbind(CT_grouped, data.frame(CAS= "Count",t(colSums(CT_grouped[,-1]))))
  CT_grouped = rbind(CT_grouped, data.frame(CAS= "Absent",(nrow(CT_grouped) - CT_grouped[nrow(CT_grouped) ,-1] - 1)))
  
  lrow = nrow(CT_grouped)
  b.CT_counts =data.frame(CT_grouped[(lrow-1):lrow,])
  
  ##get chemotypes of list of chemicals NOT present in hit list to carry out fishers test
  CT_grouped = tp[tp$CAS %in% other$CASRN, -c(2:3)]
  
  
  CT_grouped[,-1] <- lapply(CT_grouped[,-1], function(x) as.numeric(x))
  CT_grouped = rbind(CT_grouped, data.frame(CAS= "Count",t(colSums(CT_grouped[,-1]))))
  CT_grouped = rbind(CT_grouped, data.frame(CAS= "Absent",(nrow(CT_grouped) - CT_grouped[nrow(CT_grouped) ,-1] - 1)))
  
  lrow = nrow(CT_grouped)
  nb.CT_counts =data.frame(CT_grouped[(lrow-1):lrow,])
  
  
  countMatrix = matrix(nrow= 2 ,ncol = 2)
  enrichedCTs = NULL
  pval = NULL
  for(i in 2:ncol(b.CT_counts)){
    countMatrix[1,1] =  b.CT_counts[1,i]
    countMatrix[2,1] = b.CT_counts[2,i]
    countMatrix[1,2] = nb.CT_counts[1,i]
    countMatrix[2,2] = nb.CT_counts[2,i]
    CT.ftest = fisher.test(countMatrix)
    pval = c(pval, CT.ftest$p.value)
    if(CT.ftest$p.value < 0.05){
      enrichedCTs = c(enrichedCTs, colnames(b.CT_counts[i]))
    }
  }
  
  temp = data.frame(CAS = "p val",t(pval))
  colnames(temp) = c("CAS", colnames(b.CT_counts)[2:37])
  final = rbind(b.CT_counts[1,], nb.CT_counts[1,],temp) #Count in hits,  count in non hits, p value
  # b.CT_counts = rbind(b.CT_counts, temp)
  return(final)
}


tp = CT_grouped
#write.csv(tp,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/ToxPrints_PFAS-condensed.csv", row.names = FALSE)




c = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/consolidated.csv")


lpr.lel = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/lpr_hits_lel.csv", row.names = 1)
l = row.names(lpr.lel[!(is.na(lpr.lel$Light & is.na(lpr.lel$Dark))),])


epr.lel = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/epr_hits_lel.csv", row.names = 1)
e = row.names(epr.lel[!(is.na(epr.lel$Background) & is.na(epr.lel$Excitatory) & is.na(epr.lel$Refractory)),])

m = c[complete.cases(c$Morph.BMD10),1]

## setdiff(c$CASRN,CT_grouped$CAS) chemical id 4453 does not have toxprints that is the one missing chemical

##Code to get stacked plot
## Get list of enriched chemotypes in morphology by setting "hits" to be only rows with morph biolactiivty. Run CTcounts fn  

hits= c[which(!(is.na(c$Morph.BMD10))),]
not.hits = c[c$chemical_id %in% (setdiff(c$chemical_id,hits$chemical_id)),] #chemical 4434 is duplicated remove one occurence of it
rn = c("82")
not.hits = not.hits[!(row.names(not.hits) %in% rn ),]

df = getCTcounts(hits, not.hits,tp)

tt= data.frame(t(df))
colnames(tt) = c("Hit" ,"Not a hit","pval")
##remove first row 
tt = tt[-c(1),]
tt$chemotype = row.names(tt)
tt = gather(tt, "activity", "count", -pval, -chemotype)
tt$count = as.numeric(as.character(tt$count))
tt$pval = as.numeric(as.character(tt$pval))

tt$enriched = ifelse(tt$pval <= 0.05, "enriched", "not.enriched")
tt = tt[,c(2,3,4,1,5)]

tt$chemotype = as.factor(tt$chemotype)
tt$endPoint = "Morph bioactivity (BMD10)"

main = NULL
main = rbind(main,tt)

## Get list of enriched chemotypes in morphology by setting "hits" to be only rows with EPR biolactiivty. Run CTcounts fn  

hits= c[which(c$chemical_id %in% e ),]
not.hits = c[c$chemical_id %in% (setdiff(c$chemical_id,hits$chemical_id)),] #chemical 4434 is duplicated remove one occurence of it
rn = c("82")
not.hits = not.hits[!(row.names(not.hits) %in% rn ),]

df = getCTcounts(hits, not.hits,tp)

tt= data.frame(t(df))
colnames(tt) = c("Hit" ,"Not a hit","pval")
##remove first row and 2nd col
tt = tt[-c(1),]
tt$chemotype = row.names(tt)
tt = gather(tt, "activity", "count", -pval, -chemotype)
tt$count = as.numeric(as.character(tt$count))
tt$pval = as.numeric(as.character(tt$pval))

tt$enriched = ifelse(tt$pval <= 0.05, "enriched", "not.enriched")
tt = tt[,c(2,3,4,1,5)]

tt$chemotype = as.factor(tt$chemotype)
tt$endPoint = "EPR bioactivity (LEL)"

main = rbind(main,tt)

## Get list of enriched chemotypes in morphology by setting "hits" to be only rows with LPR biolactiivty. Run CTcounts fn  

hits= c[which(c$chemical_id %in% l ),]
not.hits = c[c$chemical_id %in% (setdiff(c$chemical_id,hits$chemical_id)),] #chemical 4434 is duplicated remove one occurence of it
rn = c("82")
not.hits = not.hits[!(row.names(not.hits) %in% rn ),]

df = getCTcounts(hits, not.hits,tp)

tt= data.frame(t(df))
colnames(tt) = c("Hit" ,"Not a hit","pval")
##remove first row and 2nd col
tt = tt[-c(1),]
tt$chemotype = row.names(tt)
tt = gather(tt, "activity", "count", -pval, -chemotype)
tt$count = as.numeric(as.character(tt$count))
tt$pval = as.numeric(as.character(tt$pval))

tt$enriched = ifelse(tt$pval <= 0.05, "enriched", "not.enriched")
tt = tt[,c(2,3,4,1,5)]

tt$chemotype = as.factor(tt$chemotype)
tt$endPoint = "LPR bioactivity (LEL)"

main = rbind(main,tt)
main$activity <- factor(main$activity, levels = c("Hit","Not a hit"))
main = main[order(main$activity, decreasing = T),]
main$endPoint <- factor(main$endPoint, levels = c("EPR bioactivity (LEL)","LPR bioactivity (LEL)","Morph bioactivity (BMD10)"))

dummy <- data.frame(endPoint = c("EPR bioactivity (LEL)", "LPR bioactivity (LEL)","Morph bioactivity (BMD10)"),Z = c(21, 34,31)) # to add vertical line with number of hits 
dummy$X <- factor(dummy$endPoint, levels = c( "EPR bioactivity (LEL)","LPR bioactivity (LEL)","Morph bioactivity (BMD10)"))


p = ggplot(data = main, aes(x = chemotype, y =count, fill = factor(activity, levels=c("Not a hit","Hit")), alpha = enriched == "enriched")) +
  geom_bar(stat = "identity") + geom_hline(data = dummy, aes(yintercept = Z), linetype = 'dotted', color = "#FF4B4B" )+
  facet_wrap(endPoint ~ ., ncol = 3) +
  scale_fill_manual(values=c( "#3EBDFF", "#FF4B4B")) +  # blue #3EBDFF
  scale_y_continuous(breaks = seq(0, 140, by = 20)) + 
  scale_alpha_discrete(range = c(0.5, 0.9)) + 
  coord_flip() + 
  theme(panel.border = element_rect(linetype = "dashed", fill = NA)) +  
  guides(fill=guide_legend(title="Activity"), alpha = FALSE) + 
  #theme(legend.position = "none") +
  # ggtitle("morphology") +
  xlab("Chemotype") + ylab("# of chemicals") + scale_alpha_discrete(range = c(0.25, 1))

p#####

ggsave("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/CT_stacked-allEP.jpeg",plot=p, width = 25.75, height = 14.85,units="cm", dpi=300)



