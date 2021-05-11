setwd("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata")
setwd("C:/Users/pthunga/Documents/PhD/PFAS data/results/gui")
x = readRDS('all-pfas.rds')
# lpr = x$analysis$behav[["file 2"]]$computation$lelConc


# somePDFPath = "C:/Users/pthunga/Documents/PhD/PFAS data/results/R/PFAS-Analysis-ED50_hits.pdf"
# pdf(file=somePDFPath)  

## Get list of bioactive ones 

allpfas_ed50 = x$analysis$morph$ed
any_ep_ed50 = allpfas_ed50[complete.cases(allpfas_ed50[ , 14]),]
bioactive = rownames(any_ep_ed50)

#adjust y labels for following fig
plotHist(any_ep_ed50, x$analysis$morph$range, fig.title = "ED50 of morph hits made using ANY_EP (@BMR50)", y.lab = 0.5)

#Keep only EPR and LPR of those ones 

epr.data = x$analysis$behav[['file 1']]$computation$lelConc
epr.data = epr.data[rownames(epr.data) %in% bioactive,]

epr.data.type = x$analysis$behav[['file 1']]$computation$lelType
epr.data.type = epr.data.type[rownames(epr.data.type) %in% bioactive,]

lpr.data = x$analysis$behav[['file 2']]$computation$lelConc
lpr.data = lpr.data[rownames(lpr.data) %in% bioactive,]

lpr.data.type = x$analysis$behav[['file 2']]$computation$lelType
lpr.data.type = lpr.data.type[rownames(lpr.data.type) %in% bioactive,]

write.csv(any_ep_ed50,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/morph_bioactive_ed50.csv")
write.csv(epr.data,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/morph_bioactive_epr-lel.csv")
write.csv(lpr.data,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/morph_bioactive_lpr-lel.csv")

# Behavior histogram examples
fileID <- names(x$fileSelect$behav)[2]
plotHistLegend(x$analysis$behav[[fileID]]$computation$range, fig.title = "behavior LEL legend")
plotHist(epr.data,
         x$analysis$behav[[fileID]]$computation$range,
         type =epr.data.type, fig.title = "EPR - LEL", y.lab = 0.5)

fileID <- names(x$fileSelect$behav)[1]
plotHistLegend(x$analysis$behav[[fileID]]$computation$range, fig.title = "behavior LEL legend")
plotHist(lpr.data,
         x$analysis$behav[[fileID]]$computation$range,
         type = lpr.data.type, fig.title = "LPR - LEL", y.lab = 0.8)

dev.off()

##the above 3 figures were pasted together on PPT

###Now keep only epr hits

epr.data = epr.data[rowSums(is.na(epr.data)) != ncol(epr.data), ]

lpr.data = lpr.data[rowSums(is.na(lpr.data)) != ncol(lpr.data), ]

write.csv(epr.data,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/epr_hits_lel.csv")
write.csv(lpr.data,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/lpr_hits_lel.csv")
