## Get data for BMDExpress from GUI

x = readRDS("C:/Users/pthunga/Documents/PhD/PFAS data/results/gui/all-pfas.rds") #read file

c.id = names(x$analysis$behav$`file 1`$computation$tdrs) #get list of chem

#for EPR
for(i in 1:length(c.id)){
  cur = c.id[i]
  filename = paste0("C:/Users/pthunga/Documents/PhD/PFAS data/results/BMD/data/GUI/EPR/",as.character(c.id[i]),"_epr_gui.txt")
  b = x$analysis$behav$`file 1`$computation$tdrs[[cur]]$'Background'$df 
  e = x$analysis$behav$`file 1`$computation$tdrs[[cur]]$'Excitatory'$df
  r = x$analysis$behav$`file 1`$computation$tdrs[[cur]]$'Refractory'$df
  c = cbind(b,e$mean,r$mean)  #bind b e and r together, transpose matrix and save to file
  c = c[complete.cases(c),]
  c$sample = paste0("Sample",rownames(c))
  c = c[,c(5,1,2,3,4)]
  colnames(c) = c("sample.id","conc", "B", "E", "R")
  c = t(c)
  write.table(c,filename, sep='\t',col.names =  FALSE, quote = FALSE)
}

c.id = names(x$analysis$behav$`file 2`$computation$tdrs) 

#for LPR
for(i in 1:length(c.id)){
  cur = c.id[i]
  filename = paste0("C:/Users/pthunga/Documents/PhD/PFAS data/results/BMD/data/GUI/LPR/",as.character(c.id[i]),"_lpr_gui.txt")
  L = x$analysis$behav$`file 2`$computation$tdrs[[cur]]$'Light'$df
  D = x$analysis$behav$`file 2`$computation$tdrs[[cur]]$'Dark'$df
  c = cbind(L,D$mean)
  c = c[complete.cases(c),]
  c$sample = paste0("Sample",rownames(c))
  c = c[,c(4,1,2,3)]
  colnames(c) = c("sample.id","conc", "L", "D")
  c = t(c)
  write.table(c,filename, sep='\t',col.names =  FALSE, quote = FALSE)
}

################################################################################

##This is what i did initially. Getting data for BMD from raw files #used some dplyr code see for reference

setwd("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata")

epr = read.csv("EPA PFAS zf EPR data  2021MAR05.csv")
# All 21 - 50
# B 21 30 E 31 40 R 41 50 

epr$All = rowSums(epr[,c(26:55)], na.rm = TRUE)
epr$B = rowSums(epr[,c(26:35)], na.rm = TRUE)
epr$E = rowSums(epr[,c(36:45)], na.rm = TRUE)
epr$R = rowSums(epr[,c(46:55)], na.rm = TRUE)
epr = epr[,c(1:5,56,57,58,59)]


library(dplyr)
new = epr %>%
  group_by(chemical.id) %>%  mutate(sample.id = paste0("Replicate",1:n()))

# new.sub = new[new$chemical.id == "4371" | new$chemical.id == "4364",]
# new.sub = new.sub[c(1,10,3,6:9)]
id = unique(new$chemical.id)
for(i in 1:length(unique(new$chemical.id))){
   filename = paste0("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/BMD/data/",as.character(id[i]),".txt")
   sub = new[new$chemical.id == id[i],c(10,3,6:9)]
   sub = t(sub)
   write.table(sub,filename, sep='\t',col.names =  FALSE, quote = FALSE)
 }


### Process LPR 
lpr = read.csv("EPA PFAS zf LPR data 2021MAR05.csv")
lpr$All = rowSums(lpr[,c(61:240)], na.rm = TRUE)
lpr$Light = rowSums(lpr[,c(61:90, 121:150,181:210)], na.rm = TRUE)
lpr$Dark = rowSums(lpr[,c(91:120,151:180,211:240)], na.rm = TRUE)
lpr = lpr[,c(1:5,246,247,248)]


library(dplyr)
new = lpr %>%
  group_by(chemical.id) %>%  mutate(sample.id = paste0("Sample",1:n()))

id = unique(new$chemical.id)
for(i in 1:length(unique(new$chemical.id))){
  filename = paste0("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/BMD/data/lpr/",as.character(id[i]),"_lpr.txt")
  sub = new[new$chemical.id == id[i],c(9,3,6:8)]
  sub = t(sub)
  write.table(sub,filename, sep='\t',col.names =  FALSE, quote = FALSE)
}
