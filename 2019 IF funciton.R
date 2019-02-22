prsdata=read.csv("/Users/peacewaffle/Desktop/PRS_project/PRSice_mac/catie-pheno.txt", header=T, sep="\t")
prsdata$sigAIWG = ifelse(prsdata$Delta_BMI_LOCF_perc>=7,1,0)
write.table(prsdata, "/Users/peacewaffle/Desktop/PRS_project/PRSice_mac/catie-pheno_v2.txt",
            col.names = T, row.names = F,sep="\t",quote=F)
