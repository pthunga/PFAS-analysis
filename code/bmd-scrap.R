setwd("C:/Users/pthunga/OneDrive/ReifLab/Other/PFAS data/results/BMD/BMDExpress results/")
#Load RDS file to grab info about max tested dose for each chemical 
x = readRDS("C:/Users/pthunga/Documents/PhD/PFAS data/results/gui/all-pfas.rds") #read file
#Read data
epr = read.csv("epr_gui_setting1.csv", header = 1)
epr = epr[,c(1,2,138:142, 144,145)] #Keep only cols with best values
#number of hits 
length(unique(epr$Analysis))
#Get list of chemicals
c.id = unique(epr$Analysis)
#Remove suffix from chemical ids
c.id = gsub("_epr_gui_BMD", "",c.id)

epr$m.d = NA
#loop to add info about max tested dose for each chemical
for(i in 1:length(c.id)){
  cur = c.id[i]
  epr$m.d[grep(c.id[i], epr$Analysis)] = max(x$analysis$behav$`file 1`$computation$tdrs[[cur]][[1]]$df$conc) 
}

epr = epr[epr$Best.BMD <= 100,] #keep only chemicals with BMD within tested dose
write.csv(epr,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/epr_BMD.csv")

epr = epr[epr$Best.BMD <= epr$m.d,] #keep only chemicals with BMD within tested dose
length(unique(epr$Analysis))  


 
lpr = read.csv("lpr_gui_setting1.csv", header = 1)
lpr = lpr[,c(1,2,138:142, 144,145)] #Keep only cols with best values
#number of hits 
length(unique(lpr$Analysis))
#Get list of chemicals
c.id = unique(lpr$Analysis)
#Remove suffix from chemical ids
c.id = gsub("_lpr_gui_BMD", "",c.id)

lpr$m.d = NA

for(i in 1:length(c.id)){
  cur = c.id[i]
  lpr$m.d[grep(c.id[i], lpr$Analysis)] = max(x$analysis$behav$`file 2`$computation$tdrs[[cur]][[1]]$df$conc) 
}

lpr = lpr[lpr$Best.BMD <= lpr$m.d,]
write.csv(lpr,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/lpr_BMD.csv")
length(unique(lpr$Analysis))  

############################################## 
## compare with LEL info

e.l = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/epr_hits_lel.csv")

# NOT RUN {
require(graphics)

## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(e)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept
# }
# NOT RUN {
anova(lm.D9)
summary(lm.D90)
# }
# NOT RUN {
opar <- par(mfrow = c(2,2), oma = c(0, 0, 1.1, 0))
plot(lm.D9, las = 1)      # Residuals, Fitted, ...
par(opar)
# }
# NOT RUN {
### less simple examples in "See Also" above
# }