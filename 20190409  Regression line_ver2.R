dat <- read.csv("/Users/peacewaffle/Desktop/JINTEREST study A/MoCA/Analysis/20190111 MOCA N=73.csv", sep=",", header=T) 
res <- summary(lm(dat$VTC ~ dat$FTF))
slope <- round(res$coef[2], digits = 2)
intc <- round(res$coef[1], digits = 2)
rsq <- round(res$r.squared, digits = 2)
res
slope
intc
rsq

ggp<- ggplot(dat, aes(x=FTF, y=VTC)) + 
  geom_point(aes(shape=Diagnosis, colour=Diagnosis), size=3) + 
  scale_x_continuous(breaks = c(seq(0,30,5))) +
  scale_y_continuous(breaks = c(seq(0,30,5))) +
  scale_color_manual(values=c("gray22", "gray44", "gray66"))+
  expand_limits(x=0, y=0)+
  xlab("FTF") +
  ylab("VTC") +
  theme_classic() +
  theme(aspect.ratio = 1) +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"),
        legend.title = element_text(face = "bold", size = 14, hjust = 0),
        legend.text =  element_text(size = 14))+
  geom_smooth(data=dat, aes(y=VTC, x=FTF), method = "lm", se = F, colour="black") 

lyr <- ggp +
  annotate("text", label = paste0("y==", slope, "*x + ", intc), x = 10, y = 30, parse = TRUE, size = 5) +
  annotate("text", label = paste0("R^2==", rsq), x = 10, y = 28, parse = TRUE, size = 5)
lyr