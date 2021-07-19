library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)

c = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/consolidated_new.csv", row.names = 1)
c = c[,c(2,20,36:40)]
c = c[rowSums(is.na(c)) != 6,] #remove chemicals that are not a hit in any endpoint
colnames(c)[1] = "chemical_id"

c = c %>% gather("endpoint", "POD", -chemical_id) #gather into key value pairs 
c$endpoint = str_remove(c$endpoint,"_new") #remove "new" suffix
c[is.na(c$POD),3] = 0 #replace NA with 0
c$chemical_id = as.character(c$chemical_id) #convert y axis to character
ids = c$chemical_id %>% unique()  #keep all chemical ids 
c[c$endpoint == "Morph.BMD10",2] = "ANY_BMD10"
c$assay = "EPR"
c[c$endpoint == "ANY_BMD10",4] = "Morphology"
c[c$endpoint == "Light" | c$endpoint == "Dark" ,4] = "LPR"
c$endpoint <- factor(c$endpoint, levels = c("Background", "Excitatory", "Refractory", "Light", "Dark", "ANY_BMD10"))

### Steps to merge direction of activity info to this dataframe
epr.dir = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/epr_direction.csv") #load data
colnames(epr.dir) = c("chemical_id","Background", "Excitatory","Refractory") #rename cols

lpr.dir = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/lpr_direction.csv")
colnames(lpr.dir) = c("chemical_id","Light", "Dark")


c.dir = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/consolidated_new.csv", row.names = 1) #reload consolidated file
c.dir = c.dir[,c(1,2,20,36:40)] #keep chemical ID number for merging and LEL info for removing non-hits in the next step
c.dir = c.dir[rowSums(is.na(c.dir)) != 6,] #remove chemicals that are not a hit in any endpoint
c.dir = c.dir[,c(1,2)] 

c.dir = merge(c.dir,epr.dir, by = "chemical_id", all.x = TRUE) #merge epr
c.dir= merge(c.dir,lpr.dir, by="chemical_id", all.x = TRUE) #merge lpr
c.dir = c.dir[,-1] #remove id numbers now
colnames(c.dir)[1] = "chemical_id"

c.dir  = c.dir %>% gather("endpoint", "activity", -chemical_id) #gather into key value pairs 

c = merge(c,c.dir, by = c("chemical_id", "endpoint"), all.x = TRUE) #merge with the big dataframe created earlier

c[c$assay == "Morphology",5] = "Morphology" #replace NAs with morphology so you can plot colors using "activity" column directly

rm(epr.dir, lpr.dir, c.dir)

#geom_label(aes(endpoint, 0.45, label = endpoint, fill = endpoint)) +

p =  c %>% filter(chemical_id %in% ids) %>% 
  filter(POD > 0) %>% 
  ggplot(aes(x=endpoint, y = chemical_id, color = activity, size = POD, alpha = - POD)) +  scale_alpha(range=c(0.3,1)) +
  geom_point()  + scale_color_manual(values=c("#F6E72A", "#56B871", "#453175")) + 
#  scale_color_viridis_c(name = 'POD') + 
  cowplot::theme_cowplot() + 
  theme(axis.line  = element_blank()) + 
  theme(axis.text.x = element_text(hjust=1,size=9, angle = 90), axis.text.y = element_text(hjust=1,size=8),
        axis.title.y = element_text(size=11), axis.title.x = element_text(size=11)) +
  ylab('Chemical') +  xlab('Endpoint') +  
  theme(axis.ticks = element_blank())  + 
  theme(legend.key.size = unit(0.1, "cm"), legend.text = element_text(size = 8), legend.title = element_text(size = 10)) +
  theme(axis.text=element_text()) +
  guides(alpha = FALSE, colour = guide_legend(override.aes = list(size= 3))) + facet_wrap(~assay, scales="free_x")

p

ggsave("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/global_new_heatmap.png",plot=p,  width=9.15, height=9.55, dpi=300)
dev.off()

################# DOT PLOT FOR BEHAVIOR BMD 

library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)

# c = read.csv("C:/Users/pthunga/OneDrive/ReifLab/Other/PFAS data/results/new data/consolidated_new.csv", row.names = 1)
# c = c[,c(2,20,36:40)]

c = read.csv("C:/Users/pthunga/OneDrive/ReifLab/Other/PFAS data/results/new data/gui-update-june18/consolidated_latest.csv", row.names = 1)
#c = c[,c(2,20,36:40)] #Read this for LEL 
c = c[,c(2,20,41:45)] # Do this for BMD


c = c[rowSums(is.na(c)) != 6,] #remove chemicals that are not a hit in any endpoint
colnames(c)[1] = "chemical_id"

c = c %>% gather("endpoint", "POD", -chemical_id) #gather into key value pairs 
c$endpoint = str_remove(c$endpoint,"_BMD") #remove "new" suffix
c[is.na(c$POD),3] = 0 #replace NA with 0
c$chemical_id = as.character(c$chemical_id) #convert y axis to character
ids = c$chemical_id %>% unique()  #keep all chemical ids 
c[c$endpoint == "Morph.BMD10",2] = "ANY_BMD10"
c$assay = "EPR - BMD"
c[c$endpoint == "ANY_BMD10",4] = "Morphology"
c[c$endpoint == "Light" | c$endpoint == "Dark" ,4] = "LPR - BMD"
c$endpoint <- factor(c$endpoint, levels = c("ANY_BMD10","Background", "Excitatory", "Refractory", "Light", "Dark"))

### Steps to merge direction of activity info to this dataframe
epr.dir = read.csv("C:/Users/pthunga/OneDrive/ReifLab/Other/PFAS data/results/new data/gui-update-june18/epr.bmdtype.csv") #load data
colnames(epr.dir) = c("chemical_id","Background", "Excitatory","Refractory") #rename cols

lpr.dir = read.csv("C:/Users/pthunga/OneDrive/ReifLab/Other/PFAS data/results/new data/gui-update-june18/lpr.bmdtype.csv")
colnames(lpr.dir) = c("chemical_id","Light", "Dark")


c.dir = read.csv("C:/Users/pthunga/OneDrive/ReifLab/Other/PFAS data/results/new data/gui-update-june18/consolidated_latest.csv", row.names = 1) #reload consolidated file
#c.dir = c.dir[,c(1,2,20,36:40)] #Read this for LEL 
c.dir = c.dir[,c(1,2,20,41:45)] #keep chemical ID number for merging and LEL info for removing non-hits in the next step
c.dir = c.dir[rowSums(is.na(c.dir)) != 6,] #remove chemicals that are not a hit in any endpoint
c.dir = c.dir[,c(1,2)] 

c.dir = merge(c.dir,epr.dir, by = "chemical_id", all.x = TRUE) #merge epr
c.dir= merge(c.dir,lpr.dir, by="chemical_id", all.x = TRUE) #merge lpr
c.dir = c.dir[,-1] #remove id numbers now
colnames(c.dir)[1] = "chemical_id"

c.dir  = c.dir %>% gather("endpoint", "activity", -chemical_id) #gather into key value pairs 

c = merge(c,c.dir, by = c("chemical_id", "endpoint"), all.x = TRUE) #merge with the big dataframe created earlier

c[c$assay == "Morphology",5] = "Morphology" #replace NAs with morphology so you can plot colors using "activity" column directly

rm(epr.dir, lpr.dir, c.dir)

#geom_label(aes(endpoint, 0.45, label = endpoint, fill = endpoint)) +

c$assay <- factor(c$assay, levels = c("Morphology","EPR - BMD", "LPR - BMD"))


###### Order by Yvonne's list

pfas.order = read.csv("C:/Users/pthunga/OneDrive/ReifLab/Other/PFAS data/results/new data/gui-update-june18/Simonich_Structure Categorized_EPA PFAS Library_YRadapted_all_lists_20210513.csv")
pfas.order = pfas.order[,-ncol(pfas.order)]
colnames(pfas.order)[4] = "chemical_id"
pfas.order = pfas.order[which(pfas.order$chemical_id %in% c$chemical_id),]
c = merge(c, pfas.order, by = "chemical_id")
c = c[ order(match(c$chemical_id, pfas.order$chemical_id)), ]
#c$chemical_id <- factor(c$chemical_id, levels = c$chemical_id)


dup = pfas.order
dup.c = c




pfas.order[ order(match(pfas.order$variable, d1$Variable)), ]


p =  c %>% filter(chemical_id %in% ids) %>% 
  filter(POD > 0) %>% 
  ggplot(aes(x=endpoint, y = chemical_id, color = activity, size = POD, alpha = - POD)) +  scale_alpha(range=c(0.3,1)) +
  geom_point()  + scale_y_discrete(limits=c$chemical_id) + scale_color_manual(values=c("#F6E72A", "#56B871", "#453175")) + 
#  scale_color_viridis_c(name = 'POD') + 
  cowplot::theme_cowplot() + 
  theme(axis.line  = element_blank()) + 
  theme(axis.text.x = element_text(hjust=1,size=9, angle = 90, vjust=0.5), axis.text.y = element_text(hjust=1,size=8),
        axis.title.y = element_text(size=11), axis.title.x = element_text(size=11)) +
  ylab('Chemical') +  xlab('Endpoint') +  
  theme(axis.ticks = element_blank())  + 
  theme(legend.key.size = unit(0.1, "cm"), legend.text = element_text(size = 8), legend.title = element_text(size = 10)) +
  theme(axis.text=element_text()) +   coord_cartesian(clip = 'off') + 
  guides(alpha = FALSE, colour = guide_legend(override.aes = list(size= 3))) + facet_wrap(~assay, scales="free_x")

p 

ggsave("C:/Users/pthunga/OneDrive/ReifLab/Other/PFAS data/results/new data/gui-update-june18/global_heatmap_bmd.png",plot=p,  width=9.15, height=11.55, dpi=300)
dev.off()
