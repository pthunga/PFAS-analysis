epr.data = x$analysis$behav[['file 1']]$computation$lelConc
group = rownames(epr.data)
df <- x$analysis$behav[['file 1']]$computation$tdrs[["4337"]][['All']]$lel$stats
df = x$analysis$morph$bdrs$'2589'$ANY_$lel$mThreshold

df = df[!(is.na(df$ks.pval)) & df$m/df$n < 0.3 & df$ks.pval <= 0.05/(nrow(df) - 1),1] #get only conc that was hit
c = NULL

setwd("C:/Users/pthunga/Documents/PhD/PFAS data/results/gui")
x = readRDS('all-pfas.rds')

bmd = x$analysis$morph$bmd
lel = data.frame(x$analysis$morph$lel)

lel = lel[rowSums(is.na(lel)) != ncol(lel),]
write.csv(lel,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/lel_morph.csv")

library(readxl)
lel_fail = read_excel(file.choose())
lel_fail = lel_fail[lel_fail$`QC of ANY_BMD10` == "FAIL" & !(is.na(lel_fail$`QC of ANY_BMD10`)),]

data = x$fileSelect$morph$data
data = data[data$chemical.id == "4371",]
data = data[data$chemical.id %in% lel_fail$`CHEM ID`,]

for(i in 1:length(unique(lel_fail$`CHEM ID`))){
  id = unique(lel_fail$`CHEM ID`)[i]
  for(c in 1:length(unique(data[data$chemical.id == id, 3]))){
    
  }
}

censor = x$qc$behav$`file 1`$censor$data
