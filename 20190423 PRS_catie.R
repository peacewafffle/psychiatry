#---------------------------------------------------------------------------
# CHANGE THESE PARAMETERS
#---------------------------------------------------------------------------
path = "/Users/peacewaffle/Desktop/PRS_project/PRSice_mac/" ## CHANGE YOUR PATH

target_file = "catie-final-QC7.bim" 
target_SNP = "V2" # column name in target file, if no header then call column by positions e.g., column 2 --> V2
target_BP = "V4" # column with snp positions
target_A1 = "V5" # this can also be called effect/minor
target_A2 = "V6" 

discovery_file = "MAGIC_ln_fastingProinsulin.txt"
discovery_SNP = "SNP"
discovery_BP = "NA" # column with snp positions, IF NO POSITION SET TO "NA"
discovery_A1 = "A1" # this can also be called effect/minor
discovery_A2 = "other_allele" 
#---------------------------------------------------------------------------
# LOAD LIBRARIES
#---------------------------------------------------------------------------
library(data.table)
library(dplyr, warn.conflicts = F)
#---------------------------------------------------------------------------
# READ DATA (may take a while depending on size)
#---------------------------------------------------------------------------
target = fread(paste0(path, target_file), header=F, sep="\t")
if(length(names(target))==1){
  target = fread(paste0(path, target_file), header=T, sep=" ")
}

discovery = fread(paste0(path, discovery_file), header=T, sep="\t")

#check row names of the discovery file and change the above script accoring to the row names
head(discovery)

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

if(discovery_BP=="NA"){
  ind2 = c(grep(discovery_SNP, names(discovery)), 
           grep(discovery_A1, names(discovery)), 
           grep(discovery_A2, names(discovery)))
  names(discovery)[ind2] = c("SNP",  "discovery_A1", "discovery_A2")
} else {
  ind2 = c(grep(discovery_SNP, names(discovery)), 
           grep(discovery_BP, names(discovery)), 
           grep(discovery_A1, names(discovery)), 
           grep(discovery_A2, names(discovery)))
  names(discovery)[ind2] = c("SNP", "discovery_BP", "discovery_A1", "discovery_A2")
}

names(target)[ind] = c("SNP", "target_BP", "target_A1", "target_A2")


overlap = target$SNP[target$SNP %in% discovery$SNP]

target = target[which(target$SNP %in% overlap), ]

# find any duplicates in discovery and remove them so they don't cause errors later
dups = discovery$SNP[which(duplicated(discovery$SNP))]
if(length(dups)>0){
  print(paste0("There are ", length(dups), " duplicated SNPs in the discovery file: ",
               paste0(dups, collapse=", ")))
  discovery = discovery %>% distinct()
}

discovery = discovery[which(discovery$SNP %in% overlap), ]
#-------------------------------------------------------------------------------------------------------
# CHANGE ALL TO CAPITALS
#-------------------------------------------------------------------------------------------------------
discovery$discovery_A1 = toupper(discovery$discovery_A1)
discovery$discovery_A2 = toupper(discovery$discovery_A2)
target$target_A1 = toupper(target$target_A1)
target$target_A2 = toupper(target$target_A2)
#-------------------------------------------------------------------------------------------------------
# CREATED MERGED FILE BETWEEN TARGET AND DISCOVERY ONLY WITH SNPS WHICH MAY BE USED IN PRS
#-------------------------------------------------------------------------------------------------------
dat = merge(target, discovery, by="SNP", all = F)
#-------------------------------------------------------------------------------------------------------
# FIND ALLELES THAT ARE NOT THE SAME
#-------------------------------------------------------------------------------------------------------
if(discovery_BP=="NA"){
wrong_alleles = dat %>% 
  filter(target_A1!= discovery_A1  | target_A2!=discovery_A2)
} else {
  wrong_alleles = dat %>% 
    filter(target_BP==discovery_BP & (target_A1!= discovery_A1  | target_A2!=discovery_A2))
}
snps = wrong_alleles$SNP
write.table(snps, paste0(path, "for_flips.txt"), col.names=F, row.names=F,sep="\t", quote=F)

#-------------------------------------------------------------------------------------------------------
# FIND POSITIONS (CHECK BUILD)
#-------------------------------------------------------------------------------------------------------
if(discovery_BP!="NA"){
wrong_positions = dat %>% filter(target_BP != discovery_BP)
new_map = wrong_positions %>% select(SNP, discovery_BP)
write.table(new_map, paste0(path, "for_map.txt"), col.names=F, row.names=F,sep="\t", quote=F)
}
########################################################################################################
#
# RUN IN TERMINAL ONLY (REMOVE QUOTATIONS) -- SUBSTITUTE CORRECT NAME OF TARGET FILE
#
########################################################################################################
## PRSICE OPTIONS
beta = T
stat_name = "BETA"
threads = 1
pheno_file = "catie-pheno_v2.txt"
pheno_col = "sigAIWG"
binary = T
cov = "AGE,Sex,Risk_Med,Duration_LOCF_FINAL"
perm = 1000
#-----------

if(discovery_BP!="NA"){
system(paste0("plink --bfile ", path, target_file, " --update-map ", path, "for_map.txt ", 
              "--make-bed --out ", path, gsub(".bim", "", target_file), "_updated"))
system(paste0("plink --bfile ", path, gsub(".bim", "", target_file), " --flip ", path,
              "for_flips.txt --make-bed --out ", path, gsub(".bim", "", target_file), "_prsice"))

} else {
  system(paste0("plink --bfile ", path, gsub(".bim", "", target_file), " --flip ", path,
                "for_flips.txt --make-bed --out ", path, gsub(".bim", "", target_file), "_prsice"))
}

system(paste0("PRSice.R", 
              " --prsice /usr/local/bin/PRSice_mac ", 
              " --dir ", path, 
              " --base ", path, discovery_file,
              " --target ", path, gsub(".bim", "_prsice", target_file), 
              " --thread ", threads, 
              " --stat ", stat_name,
              ifelse(beta == T, " --beta ", ""),
              " --binary-target ", binary, 
              " --pheno-file ", path, pheno_file,
              " --pheno-col ", pheno_col, 
              " --cov-col ", cov,
              " --perm ", perm))
