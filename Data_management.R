# What domain are the mutations in?

################################################################################
################################################################################


# Load mutation data and combine into one file
setwd("/Users/simone/Documents/UT/BioinformaticsWithCenik/BioinformaticsFinalProject")
mutations_1 <- read.table(file = 'mutations_1.tsv', sep = '\t', header = TRUE)
mutations_2 <- read.table(file = 'mutations_2.tsv', sep = '\t', header = TRUE)
mutations_3 <- read.table(file = 'mutations_3.tsv', sep = '\t', header = TRUE)
mutations_4 <- read.table(file = 'mutations_4.tsv', sep = '\t', header = TRUE)
mutations_5 <- read.table(file = 'mutations_5.tsv', sep = '\t', header = TRUE)
mutations_6 <- read.table(file = 'mutations_6.tsv', sep = '\t', header = TRUE)
mutations_7 <- read.table(file = 'mutations_7.tsv', sep = '\t', header = TRUE)
mutations_8 <- read.table(file = 'mutations_8.tsv', sep = '\t', header = TRUE)
mutations_9 <- read.table(file = 'mutations_9.tsv', sep = '\t', header = TRUE)
mutations_10 <- read.table(file = 'mutations_10.tsv', sep = '\t', header = TRUE)
mutations_11 <- read.table(file = 'mutations_11.tsv', sep = '\t', header = TRUE)
mutations_12 <- read.table(file = 'mutations_12.tsv', sep = '\t', header = TRUE)
mutations_13 <- read.table(file = 'mutations_13.tsv', sep = '\t', header = TRUE)

mutations <- mutations_1
mutations <- rbind(mutations,mutations_13)
names(mutations)[1] <- "id"

# Export/Save as one file
write.table(mutations, file = "mutations_all.tsv", row.names=FALSE, sep="\t")

# Import mutation file    
mutations <- read.table(file = 'mutations_all.tsv', sep = '\t', header = TRUE)


# mutation_id, disease type, mutation type

  # adenomas and adenocarcinomas 
  adenomas_and_adenocarcinomas <- read.table(file = 'ssm_set_adenomas_and_adenocarcinomas__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("adenomas_and_adenocarcinomas", length(adenomas_and_adenocarcinomas$id))
  adenomas_and_adenocarcinomas <- cbind(adenomas_and_adenocarcinomas,disease)
  disease_and_mutation_data <- merge(mutations,adenomas_and_adenocarcinomas, by="id")
  
  # squamous cell neoplasms
  squamous_cell_neoplasms <- read.table(file = 'ssm_set_squamous_cell_neoplasms__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("squamous_cell_neoplasms", length(squamous_cell_neoplasms$id))
  squamous_cell_neoplasms <- cbind(squamous_cell_neoplasms,disease)
  squamous_cell_neoplasms <- merge(mutations,squamous_cell_neoplasms, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,squamous_cell_neoplasms)
  
  # ductal and lobular neoplasms
  ductal_and_lobular_neoplasms <- read.table(file = 'ssm_set_ductal_and_lobular_neoplasms__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("ductal_and_lobular_neoplasms", length(ductal_and_lobular_neoplasms$id))
  ductal_and_lobular_neoplasms <- cbind(ductal_and_lobular_neoplasms,disease)
  ductal_and_lobular_neoplasms <- merge(mutations,ductal_and_lobular_neoplasms, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,ductal_and_lobular_neoplasms)
  
  # cystic, mucinous, and serous neoplasms
  cystic__mucinous_and_serous_neoplasms <- read.table(file = 'ssm_set_cystic__mucinous_and_serous_neoplasms__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("cystic__mucinous_and_serous_neoplasms", length(cystic__mucinous_and_serous_neoplasms$id))
  cystic__mucinous_and_serous_neoplasms <- cbind(cystic__mucinous_and_serous_neoplasms,disease)
  cystic__mucinous_and_serous_neoplasms <- merge(mutations,cystic__mucinous_and_serous_neoplasms, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,cystic__mucinous_and_serous_neoplasms)

  #  gilomas
  gliomas <- read.table(file = 'ssm_set_gliomas__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("gliomas", length(gliomas$id))
  gliomas <- cbind(gliomas,disease)
  gliomas <- merge(mutations, gliomas, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,gliomas)
  
