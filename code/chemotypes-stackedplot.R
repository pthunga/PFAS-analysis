##Code to get stacked plot

##chemotypes-PFAS.R has the same info
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

