c = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/consolidated_new.csv")
c = c[,c(3,21,37:41)]
colnames(c)[1] = "chemical_id"
c = c[rowSums(is.na(c)) !=6,] #remove chemicals that are not a hit in any endpoint

c = c %>% gather("endpoint", "POD", -chemical_id) #gather into key value pairs 
c$endpoint = str_remove(c$endpoint,"_new") #remove "new" suffix
c[is.na(c$POD),3] = 0 #replace NA with 0
c$chemical_id = as.character(c$chemical_id) #convert y axis to character
ids = c$chemical_id %>% unique()  #keep all chemical ids 
c$assay = "EPR"
c[c$endpoint == "Morph.BMD10",4] = "morphology"
c[c$endpoint == "Light" | c$endpoint == "Dark" ,4] = "LPR"
c$endpoint <- factor(c$endpoint, levels = c("Background", "Excitatory", "Refractory", "Light", "Dark", "Morph.BMD10"))

p =  c %>% filter(chemical_id %in% ids) %>% 
  filter(POD > 0) %>% 
  ggplot(aes(x=endpoint, y = chemical_id, color = assay, size = POD, alpha = - POD)) +  scale_alpha(range=c(0.3,1)) +
  geom_point()  + scale_color_manual(values=c("#F6E72A", "#56B871", "#453175")) +
#  scale_color_viridis_c(name = 'POD') + 
  cowplot::theme_cowplot() + 
  theme(axis.line  = element_blank()) +
  theme(axis.text.x = element_text(hjust=1,size=9, angle = 45), axis.text.y = element_text(hjust=1,size=8),
        axis.title.y = element_text(size=11), axis.title.x = element_text(size=11)) +
  ylab('Chemical') +  xlab('Endpoint') + 
  theme(axis.ticks = element_blank())  + 
  theme(legend.key.size = unit(0.1, "cm"), legend.text = element_text(size = 8), legend.title = element_text(size = 10)) +
  theme(axis.text=element_text()) +
  guides(alpha = FALSE, colour = guide_legend(override.aes = list(size= 3))) + ggtitle()



ggsave("C:/Users/pthunga/Documents/PhD/PFAS data/results/new data/global_heatmap.png",plot=p,  width=14.15, height=8.55, dpi=300)
dev.off()
