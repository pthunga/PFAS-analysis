setwd("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/")

library(data.table)

x <- readRDS('newdata-allLPR.rds')
#y <- readRDS('oldmorph_newbehav_20210517.rds')
yvonne.list = names(x$analysis$morph$bdrs) #get full list of chemical ids


ed = data.frame(x$analysis$morph$ed)
#ed.y = data.frame(y$analysis$morph$ed)

epr.data = x$analysis$behav[['file 1']]$computation$lelConc
epr.data.type = x$analysis$behav[['file 1']]$computation$lelType

lpr.data = x$analysis$behav[['file 2']]$computation$lelConc
lpr.data.type = x$analysis$behav[['file 2']]$computation$lelType

write.csv(epr.data, "C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/epr.csv")
write.csv(epr.data.type, "C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/epr_direction.csv")

write.csv(lpr.data, "C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/lpr.csv")
write.csv(lpr.data.type, "C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/lpr_direction.csv")


# LPR has only 137 chemicals : "2589" "2599" "4457" have no lpr

#Merge this new LEL with consolidated file

#First load consolidated file
c = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/consolidated.csv")
#Load new EPR and LPR lels

epr = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/epr.csv")
colnames(epr) = c("chemical_id","Background_new", "Excitatory_new","Refractory_new")

lpr = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/lpr.csv")
colnames(lpr) = c("chemical_id","Light_new", "Dark_new")

c = merge(c,epr, by = "chemical_id", all.x = TRUE)
c= merge(c,lpr, by="chemical_id", all.x = TRUE)

write.csv(c, "C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/consolidated_new.csv")

###plotting in pdf didnt work properly for some reason
# somePDFPath = "C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/PFAS_re-analysis.pdf"
# pdf(file=somePDFPath)  
# 
# plotHistLegend(x$analysis$morph$range, twoSided = F, fig.title = "All PFAS - morph BMD legend")
# plotHist(x$analysis$morph$bmd, x$analysis$morph$range, fig.title = "All PFAS - morph BMR10")
# plotHist(x$analysis$morph$ed, x$analysis$morph$range, fig.title = "All PFAS - morph ED50 (BMR50)")
# 
# # Behavior histogram examples
# fileID <- names(x$fileSelect$behav)[2]
# plotHistLegend(x$analysis$behav[[fileID]]$computation$range, fig.title = "behavior LEL legend")
# plotHist(x$analysis$behav[[fileID]]$computation$lelConc,
#          x$analysis$behav[[fileID]]$computation$range,
#          type = x$analysis$behav[[fileID]]$computation$lelType, fig.title = "LPR new data - LEL")
# 
# fileID <- names(x$fileSelect$behav)[1]
# plotHistLegend(x$analysis$behav[[fileID]]$computation$range, fig.title = "behavior LEL legend")
# plotHist(x$analysis$behav[[fileID]]$computation$lelConc,
#          x$analysis$behav[[fileID]]$computation$range,
#          type = x$analysis$behav[[fileID]]$computation$lelType, fig.title = "EPR new data - LEL")
# 
# 
# dev.off()
