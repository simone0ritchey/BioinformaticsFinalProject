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

  # gilomas
  gliomas <- read.table(file = 'ssm_set_gliomas__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("gliomas", length(gliomas$id))
  gliomas <- cbind(gliomas,disease)
  gliomas <- merge(mutations, gliomas, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,gliomas)
  
  # transitional cell papillomas and carcinomas
  transitional_cell_papillomas_and_carcinomas <- read.table(file = 'ssm_set_transitional_cell_papillomas_and_carcinomas__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("transitional_cell_papillomas_and_carcinomas", length(transitional_cell_papillomas_and_carcinomas$id))
  transitional_cell_papillomas_and_carcinomas <- cbind(transitional_cell_papillomas_and_carcinomas,disease)
  transitional_cell_papillomas_and_carcinomas <- merge(mutations, transitional_cell_papillomas_and_carcinomas, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,transitional_cell_papillomas_and_carcinomas)
  
  # nevi and melanomas
  nevi_and_melanomas <- read.table(file = 'ssm_set_nevi_and_melanomas__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("nevi_and_melanomas", length(nevi_and_melanomas$id))
  nevi_and_melanomas <- cbind(nevi_and_melanomas,disease)
  nevi_and_melanomas <- merge(mutations, nevi_and_melanomas, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,nevi_and_melanomas)
  
  # complex and mixed stromal neoplasms
  complex_mixed_and_stromal_neoplasms <- read.table(file = 'ssm_set_complex_mixed_and_stromal_neoplasms__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("complex_mixed_and_stromal_neoplasms", length(complex_mixed_and_stromal_neoplasms$id))
  complex_mixed_and_stromal_neoplasms <- cbind(complex_mixed_and_stromal_neoplasms,disease)
  complex_mixed_and_stromal_neoplasms <- merge(mutations,complex_mixed_and_stromal_neoplasms, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,complex_mixed_and_stromal_neoplasms)
  
  # mayomatous neoplsms
  myomatous_neoplasms <- read.table(file = 'ssm_set_myomatous_neoplasms__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("myomatous_neoplasms", length(myomatous_neoplasms$id))
  myomatous_neoplasms <- cbind(myomatous_neoplasms,disease)
  myomatous_neoplasms <- merge(mutations, myomatous_neoplasms, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,myomatous_neoplasms)
  
  # plasma cell tumors
  plasma_cell_tumors <- read.table(file = 'ssm_set_plasma_cell_tumors__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("plasma_cell_tumors", length(plasma_cell_tumors$id))
  plasma_cell_tumors <- cbind(plasma_cell_tumors,disease)
  plasma_cell_tumors <- merge(mutations, plasma_cell_tumors, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,plasma_cell_tumors)
  
  # soft tissue tumors and sarcomas
  soft_tissue_tumors_and_sarcomas <- read.table(file = 'ssm_set_soft_tissue_tumors_and_sarcomas__nos__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("gliomas", length(soft_tissue_tumors_and_sarcomas$id))
  soft_tissue_tumors_and_sarcomas <- cbind(soft_tissue_tumors_and_sarcomas,disease)
  soft_tissue_tumors_and_sarcomas <- merge(mutations, soft_tissue_tumors_and_sarcomas, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,soft_tissue_tumors_and_sarcomas)
  
  # complex epithelial neoplasms
  complex_epithelial_neoplasms <- read.table(file = 'ssm_set_complex_epithelial_neoplasms__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("complex_epithelial_neoplasms", length(complex_epithelial_neoplasms$id))
  complex_epithelial_neoplasms <- cbind(complex_epithelial_neoplasms,disease)
  complex_epithelial_neoplasms <- merge(mutations, complex_epithelial_neoplasms, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,complex_epithelial_neoplasms)

  # fibromatous neoplasms
  fibromatous_neoplasms <- read.table(file = 'ssm_set_fibromatous_neoplasms__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("fibromatous_neoplasms", length(gliomas$id))
  fibromatous_neoplasms <- cbind(fibromatous_neoplasms,disease)
  fibromatous_neoplasms <- merge(mutations, fibromatous_neoplasms, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,fibromatous_neoplasms)
  
  # mesothelial neoplasms
  mesothelial_neoplasms <- read.table(file = 'ssm_set_mesothelial_neoplasms__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("mesothelial_neoplasms", length(mesothelial_neoplasms$id))
  mesothelial_neoplasms <- cbind(mesothelial_neoplasms,disease)
  mesothelial_neoplasms <- merge(mutations, mesothelial_neoplasms, by="id")
  disease_and_mutation_data <- rbind(disease_and_mutation_data,mesothelial_neoplasms)
  
  # Make file contianing disease and mutation data
  write.table(disease_and_mutation_data, file = "all_mutations_with_diseases.tsv", row.names=FALSE, sep="\t")
  
  
