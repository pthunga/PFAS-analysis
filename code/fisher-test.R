# library
library(ggplot2)

# create a dataset
specie <- c(rep("sorgho" , 3) , rep("poacee" , 3) , rep("banana" , 3) , rep("triticum" , 3) )
condition <- rep(c("normal" , "stress" , "Nitrogen") , 4)
value <- abs(rnorm(12 , 0 , 15))
data <- data.frame(specie,condition,value)

# Stacked
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar(position="stack", stat="identity")

c = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/consolidated.csv")
c$M = NULL
c$M[is.na(c$Morph.BMD10)] = "Not detected"
c$M[!(is.na(c$Morph.BMD10))] = "Detected"

c$EPR = NULL
c$EPR[is.na(c$EPR.LEL)] = "Not detected"
c$EPR[!(is.na(c$EPR.LEL))] = "Detected"

c$LPR= NULL
c$LPR[is.na(c$LPR.LEL)] = "Not detected"
c$LPR[!(is.na(c$LPR.LEL))] = "Detected"

c =c[,c(1,35:38)]
colnames(c)[2] = "property"

library(reshape2)
m1 = table ( c$property, c$M )
m = setNames(melt(m1), c('property', 'activity', 'Count'))
m$assay = "Morphology (BMD)"

m1 = table ( c$property, c$EPR )
temp = setNames(melt(m1), c('property', 'activity', 'Count'))
temp$assay = "EPR (LEL)"

m = rbind(m, temp)

m1 = table ( c$property, c$LPR )
temp = setNames(melt(m1), c('property', 'activity', 'Count'))
temp$assay = "LPR (LEL)"
m = rbind(m, temp)

# Sort data.
#d <- with(d, d[order(year, gender, continent),])

m$assay <- factor(m$assay, levels = c("Morphology (BMD)", "EPR (LEL)", "LPR (LEL)"))
m = m %>% group_by(assay, activity) %>% mutate(percent = Count/sum(Count) * 100)
m$percent = round(m$percent, 2)
bp = ggplot(data=m, aes(x=activity, y= Count, fill=property, color = property)) + 
  geom_bar(aes (alpha = activity), stat="identity", lwd = 0.15, width = 0.5, color = "black") + 
  geom_text(aes(label=paste0(percent, "%")),position = position_stack(0.5), color = "black", size = 2.5)+
  scale_y_continuous(breaks= seq(0,150,by=15)) +
  facet_grid(~assay) +   scale_alpha_discrete(range = c(0.8, 0.3), guide = FALSE) + 
  scale_fill_manual(values=c("#3EBDFF", "#FF4B4B")) + 
  # scale_color_manual(values=c( "#3EBDFF","#FF4B4B")) +
 theme(plot.title = element_text(hjust = 0.5),
       #legend.position="none",
        axis.text.x = element_text(angle = 45,  hjust=1)) 

ggsave("C:/Users/pthunga/Documents/PhD/PFAS data/results/R/endpoint-counts.jpeg",plot=bp, units="cm", width=18.15, height=9.55, dpi=300)

################################################################
c = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/consolidated.csv")
ftest = matrix(nrow = 2,ncol = 2)
l.v = (c[!(is.na(c$LPR.LEL)) & c$Volatile == "Volatile",])
l.nv = (c[!(is.na(c$LPR.LEL)) & c$Volatile == "Non-Volatile",])

nl.v = (c[(is.na(c$LPR.LEL)) & c$Volatile == "Volatile",])
nl.nv = (c[(is.na(c$LPR.LEL)) & c$Volatile == "Non-Volatile",])


l.v = (c[!(is.na(c$Morph.BMD10)) & c$Volatile == "Volatile",])
l.nv = (c[!(is.na(c$Morph.BMD10)) & c$Volatile == "Non-Volatile",])

nl.v = (c[(is.na(c$Morph.BMD10)) & c$Volatile == "Volatile",])
nl.nv = (c[(is.na(c$Morph.BMD10)) & c$Volatile == "Non-Volatile",])


ftest[1,1] = nrow(l.v)
ftest[1,2] = nrow(l.nv)
ftest[2,1] = nrow(nl.v)
ftest[2,2] = nrow(nl.nv)
fisher.test(ftest)
