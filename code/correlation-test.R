setwd("C:/Users/pthunga/Documents/PhD/PFAS data/results/gui/")
x = readRDS('each-phase_behav.rds')

#Get LPR for each phase, compare with the LELs you shared with Lisa (all light pooled, all dark pooled)
lpr.data = x$analysis$behav[['file 2']]$computation$lelConc
lpr.data = as.data.frame(lpr.data[rowSums(is.na(lpr.data)) != ncol(lpr.data), ])
lpr.data.type = x$analysis$behav[['file 2']]$computation$lelType


old.lel = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/lpr_hits_lel.csv", row.names = 1)
l = row.names(old.lel[!(is.na(old.lel$Light & is.na(old.lel$Dark))),])

# the old data pooled information from all 3 light phases together and made calls. leaving the first
#light phase out only removes 2 only other chemicals so nvm. stickt o whatever you shared wtih lisa

#Venn diagram for behavior 

lel.m = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/lel_morph.csv", row.names = 1)
m = rownames(lel.m)

epr.lel = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/epr_hits_lel.csv", row.names = 1)
e = row.names(epr.lel[!(is.na(epr.lel$Background) & is.na(epr.lel$Excitatory) & is.na(epr.lel$Refractory)),])

# Load library
library(VennDiagram)
library(RColorBrewer)
myCol <- brewer.pal(3, "Pastel2")
setwd("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/")
# Chart
venn.diagram(
  x = list(m, e, l),
  category.names = c("Morph LEL" , "EPR LEL" , "LPR LEL"),
  filename = 'lel-vennDiagram.jpeg',
  output=TRUE,
  # Output features
  imagetype="png" ,
  height = 350 , 
  width = 350 , 
  resolution = 800,
  compression = "lzw",
  
  # Circles
  lwd = 1,
  lty = 'blank',
  fill = myCol,
  
  # Numbers
  cex = 0.15,
  fontfamily = "sans",
  
  # Set names
  cat.cex = 0.1,
  cat.default.pos = "outer",
  cat.pos = c(-23, 27, 145),
  cat.dist = c(0.055, 0.055, 0.085),
  cat.fontfamily = "sans",
  rotation = 1
)

####Load files from consolidated file 

c = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/consolidated.csv")
sum(table(c$LPR.LEL,c$Volatile))

ftest = matrix(nrow = 2,ncol = 2)
l.v = (c[!(is.na(c$EPR.LEL)) & c$Volatile == "Volatile",])
l.nv = (c[!(is.na(c$EPR.LEL)) & c$Volatile == "Non-Volatile",])

nl.v = (c[(is.na(c$EPR.LEL)) & c$Volatile == "Volatile",])
nl.nv = (c[(is.na(c$EPR.LEL)) & c$Volatile == "Non-Volatile",])


l.v = (c[!(is.na(c$Morph.BMD10)) & c$Volatile == "Volatile",])
l.nv = (c[!(is.na(c$Morph.BMD10)) & c$Volatile == "Non-Volatile",])

nl.v = (c[(is.na(c$Morph.BMD10)) & c$Volatile == "Volatile",])
nl.nv = (c[(is.na(c$Morph.BMD10)) & c$Volatile == "Non-Volatile",])

ftest[1,1] = nrow(l.v)
ftest[1,2] = nrow(l.nv)
ftest[2,1] = nrow(nl.v)
ftest[2,2] = nrow(nl.nv)
fisher.test(ftest)

ftest = matrix(nrow = 12,ncol = 2)
ftest[,1] = (table(c$Fluorinated.Carbons, c$Volatile))[,1]
ftest[,2] = (table(c$Fluorinated.Carbons, c$Volatile))[,2]


m = c[!(is.na(c$Morph.BMD10)),]
library("ggpubr")
library("ggpubr")
ggscatter(m, x = "Morph.BMD10", y = "AVERAGE_MASS", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "spearman",
          xlab = "BMD10", ylab = "Mass")

res <- cor.test(m$Morph.BMD10, m$OCTANOL_AIR_PARTITION_COEFF_LOGKOA_OPERA_PRED, 
                method = "spearman")
res
