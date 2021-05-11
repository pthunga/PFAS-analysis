c = read.csv("C:/Users/pthunga/Documents/PhD/PFAS data/rawdata/consolidated.csv")
c= c[complete.cases(c$Morph.BMD10),]
c = c[,c(1,5,6,20,26:35)]

t.c = c[,c(3,4,5,7,8)]
t.c.sl = as.data.frame(scale(t.c))
summary(t.c.sl)
dist_mat <- dist(t.c.sl, method = 'euclidean')
hclust_avg <- hclust(dist_mat, method = 'average')
plot(hclust_avg)
cut_avg <- cutree(hclust_avg, k = 3)
plot(cut_avg)
plot(hclust_avg)
rect.hclust(hclust_avg , k = 3, border = 2:6)
abline(h = 3, col = 'red')


suppressPackageStartupMessages(library(dplyr))
t.c_cl <- mutate(t.c, cluster = cut_avg)
count(t.c_cl,cluster)
table(t.c_cl$cluster,c$Classification)


suppressPackageStartupMessages(library(ggplot2))
ggplot(t.c_cl, aes(x=Morph.BMD10, y = AVERAGE_MASS, color = factor(cluster))) + geom_point()

library(clValid)
dunn(distance = dist_mat, cut_avg, Data = NULL, method = "euclidean")


#try linear model
l = lm(Morph.BMD10 ~ ., data = t.c)
summary(l)
anova(l)
plot(l, las= 1)

#scatter plot
scatter.smooth(x= t.c$Fluorinated.Carbons, y= t.c$Morph.BMD10, main = "morph ~ FC")

l = lm(Morph.BMD10 ~ Fluorinated.Carbons , data = t.c)
summary(l)
