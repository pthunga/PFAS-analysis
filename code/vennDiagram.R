e.bmd = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/epr_BMD.csv")
#Get list of chemicals
e.bmd = unique(e.bmd$Analysis)
#Remove suffix from chemical ids
e.bmd = gsub("_epr_gui_BMD", "",e.bmd)

l.bmd = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/lpr_BMD.csv")
#Get list of chemicals
l.bmd = unique(l.bmd$Analysis)
#Remove suffix from chemical ids
l.bmd = gsub("_lpr_gui_BMD", "",l.bmd)

epr.lel = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/epr_hits_lel.csv", row.names = 1)
epr.lel = row.names(epr.lel[!(is.na(epr.lel$Background) & is.na(epr.lel$Excitatory) & is.na(epr.lel$Refractory)),])

lpr.lel = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/lpr_hits_lel.csv", row.names = 1)
lpr.lel = row.names(lpr.lel[!(is.na(lpr.lel$Light & is.na(lpr.lel$Dark))),])


m.bmd = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/consolidated.csv")
m.bmd = as.character(m.bmd[complete.cases(m.bmd$EPR.LEL),1])

# Load library
library(VennDiagram)
library(RColorBrewer)
myCol <- c("#c15ca5","#727cce","#60a862") #"#b4943e", , #"#cb5a4c"
setwd("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/")
# Chart
venn.diagram(
  x = list(m.bmd,e.bmd,l.bmd), #x = list(e.bmd,epr.lel,l.bmd,lpr.lel)
  category.names = c("Morph BMD" ,"EPR BMD", "LPR BMD"),
  filename = 'morph-behav-bmd-overlap.jpeg',
  output=TRUE,
  # Output features
  imagetype="png" ,
  height = 450 , 
  width = 450 , 
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
#  cat.pos = c(-23, 27, 145),
 # cat.dist = c(0.055, 0.055, 0.085),
  cat.fontfamily = "sans"
)
