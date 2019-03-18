library(ggplot2)
dat = read.table("/Users/peacewaffle/Desktop/JINTEREST study A/MoCA/Analysis/20190111 MOCA N=73.csv", sep=",", header=T)
ggplot(dat, aes(x=FTF, y=VTC, colour=Diagnosis)) + 
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
ggsave("/Users/peacewaffle/Desktop/JINTEREST study A/MoCA/Analysis/plot.png", height=5,width=5,dpi=300,units="in")
