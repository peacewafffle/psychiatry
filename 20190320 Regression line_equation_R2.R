dat <- read.csv("20190317 ADAS_Figure.csv") 
dat_a<- subset(dat, Diagnosis=="MCI")
res_a <- summary(lm(dat_a$VTC ~ dat_a$FTF))
slope_a <- round(res_a$coef[2], digits = 2)
intc_a <- round(res_a$coef[1], digits = 2)
rsq_a <- round(res_a$r.squared, digits = 2)
res_a
slope_a
intc_a
rsq_a

ggp<- ggplot(dat, aes(x=FTF, y=VTC, colour=Diagnosis)) + 
  geom_point(aes(shape=Diagnosis), size=3) + 
  scale_x_continuous(breaks = c(seq(0,30,5))) +
  scale_y_continuous(breaks = c(seq(0,30,5))) +
  scale_color_manual(values=c("gray22", "gray44", "gray66"))+
  expand_limits(x=0, y=0)+
  xlab("FTF") +
  ylab("VTF") +
  theme_classic() +
  theme(aspect.ratio = 1) +
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"),
        legend.title = element_text(face = "bold", size = 14, hjust = 0),
        legend.text =  element_text(size = 14))+
  geom_smooth(method = "lm", se = F)
ggp

lyr_a <- ggp +
  annotate("text", label = paste0("y==", slope_a, "*x + ", intc_a), x = 10, y = 30, parse = TRUE, size = 5) +
  annotate("text", label = paste0("R2==", rsq_a), x = 10, y = 28, parse = TRUE, size = 5)
lyr_a
