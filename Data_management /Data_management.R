# What domain are the mutations in?

################################################################################
################################################################################


# Load mutation data and combine into one file
setwd("/Users/simone/Documents/UT/BioinformaticsWithCenik/Final Project")
mutations_1 <- read.table(file = 'mutation_id_and_DNA_change_1.tsv', sep = '\t', header = TRUE)
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

# mutation_id, disease type, mutation type