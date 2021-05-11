setwd("C:/Users/pthunga/Documents/PhD/PFAS data/results/gui")
#x = readRDS('zfishgui_all-morph-bmd10.rds')
x = readRDS('all-pfas.rds')

somePDFPath = "C:/Users/pthunga/Documents/PhD/PFAS data/results/R/PFAS-Analysis.pdf"
pdf(file=somePDFPath)  

plotHistLegend(x$analysis$morph$range, twoSided = F, fig.title = "All PFAS - morph BMD legend")
plotHist(x$analysis$morph$bmd, x$analysis$morph$range, fig.title = "All PFAS - morph BMR10")
plotHist(x$analysis$morph$ed, x$analysis$morph$range, fig.title = "All PFAS - morph ED50 (BMR50)")

# Behavior histogram examples
fileID <- names(x$fileSelect$behav)[2]
plotHistLegend(x$analysis$behav[[fileID]]$computation$range, fig.title = "behavior LEL legend")
plotHist(x$analysis$behav[[fileID]]$computation$lelConc,
         x$analysis$behav[[fileID]]$computation$range,
         type = x$analysis$behav[[fileID]]$computation$lelType, fig.title = "LPR - LEL")

fileID <- names(x$fileSelect$behav)[1]
plotHistLegend(x$analysis$behav[[fileID]]$computation$range, fig.title = "behavior LEL legend")
plotHist(x$analysis$behav[[fileID]]$computation$lelConc,
         x$analysis$behav[[fileID]]$computation$range,
         type = x$analysis$behav[[fileID]]$computation$lelType, fig.title = "EPR - LEL")


dev.off()
allpfas_bmd10 = x$analysis$morph$bmd
allpfas_ed50 = x$analysis$morph$ed

write.csv(allpfas_bmd10,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/All_PFAS_morph-BMR10.csv")
write.csv(allpfas_ed50,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/All_PFAS_morph-ED50.csv")

any_ep_ed50 = allpfas_ed50[complete.cases(allpfas_ed50[ , 14]),]
any_ep_bmd10 = allpfas_bmd10[complete.cases(allpfas_bmd10[ , 14]),]
#adjust y labels for following fig
plotHist(any_ep_ed50, x$analysis$morph$range, fig.title = "ED50 of morph hits made using ANY_EP (@BMR50)", y.lab = 0.5)

multi.conc = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/full_morph_multiplehits.csv", check.names = FALSE)
multi.conc = multi.conc[,-1]
# $chemical_id = as.character(as.factor(multi.conc$chemical_id))
##Go through each row and determine if a value is zero
row_sub = apply(multi.conc, 1, function(row) all(row !=0 ))
##Subset as usual
multi.conc[row_sub,]

ed50.hits = rownames(any_ep_ed50)

lpr = x$analysis$behav[["file 2"]]$computation$lelConc
lpr = lpr[complete.cases(lpr[,1]),]
type =x$analysis$behav[["file 2"]]$computation$lelType
df <- x$analysis$behav[["file 2"]]$computation$tdrs[['2590']][['First half']]$lel$stats
x = readRDS('zfishgu_20210329_behav.rds') 
errr = x$fileSelect$behav


#can obtain lel of morph hits using the lel approach. Should be able to plot this on hist
