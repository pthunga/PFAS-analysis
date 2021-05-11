setwd("C:/Users/pthunga/Documents/PhD/PFAS data/results/gui")

library(data.table)

################### BMD10, ED50 AND LEL values for yvonne
x <- readRDS('pfas-for-yr.rds')
yvonne.list = as.character(c(3771,4380,4431,4454,3766,2685,4336,4436,4397,4377,4453,2595,2686,4368,4451,
                             4413,2594,4345,4373,2600,4452,4394))

yvonne.list = names(x$analysis$morph$bdrs) #get full list of chemical ids

ed = data.frame(x$analysis$morph$ed)

ed = setDT(ed, keep.rownames = "chemical_id")
ed = ed[,c(1,15)]
colnames(ed)[2] = "ED50"

bmd = data.frame(x$analysis$morph$bmd)
bmd = setDT(bmd, keep.rownames = "chemical_id")
bmd = bmd[,c(1,15)]
colnames(bmd)[2] = "BMD10"

lel = data.frame(x$analysis$morph$lel)
lel = setDT(lel, keep.rownames = "chemical_id")
lel = lel[,c(1,15)]
colnames(lel)[2] = "LEL"

final = merge(bmd,ed, by = "chemical_id")
final = merge(final,lel, by = "chemical_id")


final= final[which(final$chemical_id %in% yvonne.list),]



nrvs <- readRDS('pfas-for-yr.rds')
bmr.list = c(0.1,0.5,0.8)
bmd.df = data.frame(matrix(ncol = 4, nrow = 0))
for(i in 1:length(yvonne.list)){
  cur = yvonne.list[i]
  bdr <- nrvs$analysis$morph$bdrs[[cur]][[14]] # [[group]][[endpoint]]
  bmd.df[i,1] = cur
  for(j in 1:3){
    bmr <- bmr.list[j] # EC80
    bmd.df[i,j+1] = as.numeric(print(getBoundedBMD(bdr$fit, bdr$df, bmr)[2])) # BMD value must be within certain range of tested concentrations
  }
  #getBMD(bdr$fit, bmr)
}

colnames(bmd.df) = c("chemical_id","BMD10", "BMD50", "BMD80")
final = final[,-c(2,3)]
final = merge(final, bmd.df, by = "chemical_id")
write.csv(final, "C:/Users/pthunga/Documents/PhD/PFAS data/results/pfas-for-yr.csv", row.names = FALSE)
