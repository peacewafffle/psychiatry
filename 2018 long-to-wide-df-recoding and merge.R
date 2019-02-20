# LAB.csv: separeting this file beased on TESTNAME
labpre <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/LABdispo.csv",header = T, as.is = T)

nam <- names(table(labpre$TESTNAME)) #this extract the unique names of in the column

for (i in 1:length(nam)){
  dat  <- labpre[which(labpre$TESTNAME==nam[i]),]
  dat = reshape(dat, idvar = "CATIEID",timevar = "VISITID",direction = "wide")
  write.csv(dat, paste(as.character(nam[i]), "seperated.csv", sep="_"), col.names=TRUE, row.names=FALSE, quote =FALSE, sep="\t")
}


# Reshaping each file
adasdf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/ADAS.csv",header = T, as.is = T)
adasdf.reshaped <- reshape(adasdf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
aimsdf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/AIMS-ver2.csv",header = T, as.is = T)
aimsdf.reshaped <- reshape(aimsdf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
bprsdf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/BPRS.csv",header = T, as.is = T)
bprsdf.reshaped <- reshape(bprsdf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
cornldf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/CORNL.csv",header = T, as.is = T)
cornldf.reshaped <- reshape(cornldf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
demodf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/DEMO-ver2.csv",header = T, as.is = T)
dispdf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/DISP-ver2.csv",header = T, as.is = T)
ecgdf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/ECG-ver2.csv",header = T, as.is = T)
ecgdf.reshaped <- reshape(ecgdf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
expover2df <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/EXPO-ver2.csv",header = T, as.is = T)
expover2df.reshaped <- reshape(expover2df,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
mmsedf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/MMSE.csv",header = T, as.is = T)
mmsedf.reshaped <- reshape(mmsedf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
neurocogdf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/NEUROCOG.csv",header = T, as.is = T)
neurocogdf.reshaped <- reshape(neurocogdf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
survdf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/SURV.csv",header = T, as.is = T)
vitaldf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/VITAL.csv",header = T, as.is = T)
vitaldf.reshaped <- reshape(vitaldf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
npidf <- read.csv("~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/NPI-ver2.csv",header = T, as.is = T)
npidf.reshaped <- reshape(npidf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")

# Merging all files
my.merged.df <- merge(adasdf.reshaped, aimsdf.reshaped, by = "CATIEID", all = T)
my.merged2.df <- merge(my.merged.df, bprsdf.reshaped, by = "CATIEID", all = T)
my.merged3.df <- merge(my.merged2.df, cornldf.reshaped, by = "CATIEID", all = T)
my.merged4.df <- merge(my.merged3.df, demodf, by = "CATIEID", all = T)
my.merged5.df <- merge(my.merged4.df, dispdf, by = "CATIEID", all = T)
my.merged6.df <- merge(my.merged5.df, ecgdf.reshaped, by = "CATIEID", all = T)
my.merged7.df <- merge(my.merged6.df, expover2df.reshaped, by = "CATIEID", all = T)
my.merged8.df <- merge(my.merged7.df, mmsedf.reshaped, by = "CATIEID", all = T)
my.merged9.df <- merge(my.merged8.df, neurocogdf.reshaped, by = "CATIEID", all = T)
my.merged10.df <- merge(my.merged9.df, survdf, by = "CATIEID", all = T)
my.merged11.df <- merge(my.merged10.df, vitaldf.reshaped, by = "CATIEID", all = T)
my.merged12.df <- merge(my.merged11.df, npidf.reshaped, by = "CATIEID", all = T)

# Writing the merged file
write.csv(my.merged12.df,file = "~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/Comma Delimited Data_R/allmerged.csv",quote = F)


# examle
str(mydf)
?reshape

## example:
# reshape(dat1, idvar = "name", timevar = "numbers", direction = "wide")
mydf.reshaped <- reshape(mydf,idvar = "CATIEID",timevar = "VISITID",direction = "wide")
head(mydf.reshaped)

my.merged.df <- merge(mydf.reshaped,mydf2,by = "CATIEID",all = T)
head(my.merged.df)

write.csv(my.merged.df,file = "~/Desktop/CATIE-AD post-hoc_RIS_南さん/R_CATIE_AD_RIS/AIMS-wide-withDEMO.csv",quote = F)
