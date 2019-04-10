#---------------------------------------------------------------------------
# CHANGE THESE PARAMETERS
#---------------------------------------------------------------------------
path = "/Users/peacewaffle/Desktop/PRS_project/PRSice_mac/" ## CHANGE YOUR PATH

target_file = "catie-final-QC7.bim" 
target_SNP = "V2" # column name in target file, if no header then call column by positions e.g., column 2 --> V2
target_BP = "V4" # column with snp positions
target_A1 = "V5" # this can also be called ref
target_A2 = "V6" # this can also be called alt

discovery_file = "Meta_CA1.txt"
discovery_SNP = "SNP"
discovery_BP = "BP" # column with snp positions
discovery_A1 = "A1" # this can also be called ref
discovery_A2 = "A2" # this can also be called alt
#---------------------------------------------------------------------------
# LOAD LIBRARIES
#---------------------------------------------------------------------------
library(data.table)
library(tidyverse)
#---------------------------------------------------------------------------
# READ DATA (may take a while depending on size)
#---------------------------------------------------------------------------
target = fread(paste0(path, target_file), header=F, sep="\t")
if(length(names(target))==1){
  target = fread(paste0(path, target_file), header=T, sep=" ")
}

discovery = fread(paste0(path, discovery_file), header=T, sep="\t")

if(length(names(discovery))==1){
  discovery = fread(paste0(path, discovery_file), header=T, sep=" ")
}
#---------------------------------------------------------------------------
# PREP DATA
#---------------------------------------------------------------------------
ind = c(grep(target_SNP, names(target)), 
        grep(target_BP, names(target)), 
        grep(target_A1, names(target)), 
        grep(target_A2, names(target)))

ind2 = c(grep(discovery_SNP, names(discovery)), 
         grep(discovery_BP, names(discovery)), 
         grep(discovery_A1, names(discovery)), 
         grep(discovery_A2, names(discovery)))

names(target)[ind] = c("SNP", "target_BP", "target_A1", "target_A2")
names(discovery)[ind2] = c("SNP", "discovery_BP", "discovery_A1", "discovery_A2")

overlap = target$SNP[target$SNP %in% discovery$SNP]

target = target %>% 
  filter(SNP %in% overlap) %>% 
  arrange(SNP)

discovery = discovery %>% 
  filter(SNP %in% overlap) %>% 
  arrange(SNP)
#-------------------------------------------------------------------------------------------------------
# CREATED MERGED FILE BETWEEN TARGET AND DISCOVERY ONLY WITH SNPS WHICH MAY BE USED IN PRS
#-------------------------------------------------------------------------------------------------------
dat = merge(target, discovery, by="SNP", all = F)
#-------------------------------------------------------------------------------------------------------
# FIND ALLELES THAT ARE NOT THE SAME
#-------------------------------------------------------------------------------------------------------
wrong_alleles = dat %>% 
  filter(target_BP==discovery_BP & (target_A1!= discovery_A1  | target_A2!=discovery_A2))
snps = wrong_alleles$SNP
write.table(snps, paste0(path, "for_flips.txt"), col.names=F, row.names=F,sep="\t", quote=F)
#-------------------------------------------------------------------------------------------------------
# FIND POSITIONS (CHECK BUILD)
#-------------------------------------------------------------------------------------------------------
wrong_positions = dat %>% filter(target_BP != discovery_BP)
new_map = wrong_positions %>% select(SNP, discovery_BP)
write.table(new_map, paste0(path, "for_map.txt"), col.names=F, row.names=F,sep="\t", quote=F)
########################################################################################################
#
# RUN IN TERMINAL ONLY (REMOVE QUOTATIONS) -- SUBSTITUTE CORRECT NAME OF TARGET FILE
#
########################################################################################################
"./plink --bfile catie-final-QC7 --flip for_map.txt --make-bed --out catie_updated_map"
"./plink --bfile catie_updated_map --flip for_flips.txt --make-bed --out catie_flipped"