c = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/consolidated.csv")
#chemical 4434 is duplicated remove one occurence of it
rn = c("82") #row number of that chemical
c = c[!(row.names(c) %in% rn ),] 
rm(rn)

c$m = NULL

c$m[is.na(c$Morph.BMD10)] = 0
c$m[!(is.na(c$Morph.BMD10))] = 1

c$e = NULL
c$e[is.na(c$EPR.LEL)] = 0
c$e[!(is.na(c$EPR.LEL))] = 1

c$l = NULL
c$l[is.na(c$LPR.LEL)] = 0
c$l[!(is.na(c$LPR.LEL))] = 1


cfn = unique(c$Classification)

for(i in 1:length(cfn)){
  rc = matrix(nrow = 2, ncol =2)
  rc[1,1] = nrow(c[c$Classification == cfn[i] & c$l == 0,])
  rc[1,2] = nrow(c[c$Classification == cfn[i] & c$l == 1,])
  rc[2,1] = nrow(c[c$Classification != cfn[i] & c$l == 0,])
  rc[2,2] = nrow(c[c$Classification != cfn[i] & c$l == 1,])
  if(fisher.test(rc)[1] < 0.1){
    print(cfn[i])
  }
}

m.t = (table(c$Classification, c$l))
write.table(m.t,"C:/Users/pthunga/Documents/PhD/PFAS data/results/R/lpr-classification_counts.txt", sep = "\t")
