# What domain are the mutations in?

################################################################################
################################################################################


# Load mutation data and combine into one file
setwd("/Users/simone/Documents/UT/BioinformaticsWithCenik/BioinformaticsFinalProject")
gemutations_1 <- read.table(file = 'mutation_id_and_DNA_change_1.tsv', sep = '\t', header = TRUE)
mutations_2 <- read.table(file = 'mutation_id_and_DNA_change_2.tsv', sep = '\t', header = TRUE)
mutations_3 <- read.table(file = 'mutation_id_and_DNA_change_3.tsv', sep = '\t', header = TRUE)
mutations_4 <- read.table(file = 'mutation_id_and_DNA_change_4.tsv', sep = '\t', header = TRUE)
mutations_5 <- read.table(file = 'mutation_id_and_DNA_change_5.tsv', sep = '\t', header = TRUE)
mutations_6 <- read.table(file = 'mutation_id_and_DNA_change_6.tsv', sep = '\t', header = TRUE)
mutations_7 <- read.table(file = 'mutation_id_and_DNA_change_7.tsv', sep = '\t', header = TRUE)
mutations_8 <- read.table(file = 'mutation_id_and_DNA_change_8.tsv', sep = '\t', header = TRUE)
mutations_9 <- read.table(file = 'mutation_id_and_DNA_change_9.tsv', sep = '\t', header = TRUE)
mutations_10 <- read.table(file = 'mutation_id_and_DNA_change_10.tsv', sep = '\t', header = TRUE)
mutations_11 <- read.table(file = 'mutation_id_and_DNA_change_10.tsv', sep = '\t', header = TRUE)
mutations_12 <- read.table(file = 'mutation_id_and_DNA_change_12.tsv', sep = '\t', header = TRUE)
mutations_13 <- read.table(file = 'mutation_id_and_DNA_change_13.tsv', sep = '\t', header = TRUE)

mutations <- mutations_1
mutations <- rbind(mutations,mutations_13)

# Export/Save as one file
write.table(mutations, file = "mutation_id_and_DNA_change_all.tsv", row.names=FALSE, sep="\t")

# Import mutation file    
mutations <- read.table(file = 'mutation_id_and_DNA_change_all.tsv', sep = '\t', header = TRUE)
names(mutations)[1] <- "id"

# mutation_id, disease type, mutation type
  
adenomas_and_adenocarcinomas <- read.table(file = 'adenomas_mutations.tsv', sep = '\t', header = TRUE)


  # adenomas and adenocarcinomas 
  adenomas_and_adenocarcinomas <- read.table(file = 'ssm_set_adenomas_and_adenocarcinomas__ENSG00000141510.2022-04-16.tsv', sep = '\t', header = TRUE)
  disease <- rep("adenomas_and_adenocarcinomas", length(adenomas_and_adenocarcinomas$id))
  adenomas_and_adenocarcinomas <- cbind(adenomas_and_adenocarcinomas,disease)

  test <- merge(mutations,adenomas_and_adenocarcinomas,by="id")
  
  # squamous cell neoplasms
  squamous_cell_neoplasms <- read.table(file = 'squamous_cell_neoplasm_mutations.tsv', sep = '\t', header = TRUE)
  disease <- rep("squamous_cell_neoplasms", length(squamous_cell_neoplasms$Mutation.ID))
  squamous_cell_neoplasms <- cbind(squamous_cell_neoplasms, disease)
  disease_mutations <- rbind(squamous_cell_neoplasms, adenomas_and_adenocarcinomas)
  
  # ductal and lobular neoplasms
  ductal_and_lobular_neoplasms <- read.table(file = 'ductal_and_lobular_neoplasms.tsv', sep = '\t', header = TRUE)
  disease <- rep("ductal_and_lobular_neoplasms", length(ductal_and_lobular_neoplasms$Mutation.ID))
  ductal_and_lobular_neoplasms <- cbind(ductal_and_lobular_neoplasms, disease)
  disease_mutations <- rbind(disease_mutations, ductal_and_lobular_neoplasms)
 
   # cystic, mucinous, and serous neoplasms
  cystic_mucinous_and_serous_neoplasms <- read.table(file = 'cystic_mucinous_and_serous_neoplasm_mutations.tsv', sep = '\t', header = TRUE)
  disease <- rep("cystic_mucinous_and_serous_neoplasms", length(cystic_mucinous_and_serous_neoplasms$Mutation.ID))
  cystic_mucinous_and_serous_neoplasms <- cbind(cystic_mucinous_and_serous_neoplasms, disease)
  disease_mutations <- rbind(disease_mutations, cystic_mucinous_and_serous_neoplasms)
  
  # gilomas
  gilomas <- read.table(file = 'gilomas_mutations.tsv', sep = '\t', header = TRUE)
  disease <- rep("gilomas", length(gilomas$Mutation.ID))
  gilomas <- cbind(gilomas, disease)
  disease_mutations <- rbind(disease_mutations, gilomas)
  