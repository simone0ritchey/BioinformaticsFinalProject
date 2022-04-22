# making heatmaps for each domain

# load mutation data
mutation_domains <- read.csv("mutation_domains.csv")

# load disease data
diseases <- read.table(file = 'all_mutations_with_diseases.tsv', sep = '\t', header = TRUE)

# add domain information to disease data
library(dplyr)
domain <- vector(mode = "character",length = length(diseases$id))
for (i in 1:length(diseases$id)) {
    domain[i] <- mutation_domains[diseases$id[i] == mutation_domains$id,"Domain"]
}
diseases <- cbind(diseases,domain)
diseases <- diseases[complete.cases(diseases),]

# make domain counts for each disease
heatmap_data <- matrix(0,nrow = 14, ncol = 7)
rownames(heatmap_data) <- c("adenomas_and_adenocarcinomas", "squamous_cell_neoplasms", "ductal_and_lobular_neoplasms", "cystic__mucinous_and_serous_neoplasms", "gliomas", "transitional_cell_papillomas_and_carcinomas", "nevi_and_melanomas", "complex_mixed_and_stromal_neoplasms"," myomatous_neoplasms", "plasma_cell_tumors", "soft_tissue_tumors_and_sarcomas", "complex_epithelial_neoplasms", "fibromatous_neoplasms", "mesothelial_neoplasms")
colnames(heatmap_data) <- c("DNA-Binding", "Tetramerisation", "Proline-Rich", "Transactivation 1", "Transactivation 2", "C-Terminal","No Domain")

for (i in 1:nrow(heatmap_data)) {
  for (j in 1:ncol(heatmap_data)) {
    disease_of_interest <- rownames(heatmap_data)[i]
    disease_of_interest_data <- filter(diseases, disease == disease_of_interest)
    domain_of_interest <- colnames(heatmap_data)[j]
    heatmap_data[i,j] <- sum(disease_of_interest_data$domain == domain_of_interest)
  }
}

# Make heatmaps for each domain
library(pheatmap)
all <- pheatmap(t(heatmap_data), show_colnames = T, show_rownames = T)
# remove dna binding sight
w_o_dna_binding <- pheatmap(t(heatmap_data)[-1,], show_colnames = T, show_rownames = T)

# remove adenomas and squamous
w_o_high_count_diseases <- pheatmap(t(heatmap_data)[,-c(1,2)], show_colnames = T, show_rownames = T)
low_count_diseases <- pheatmap(t(heatmap_data)[,-c(1,2,3,4,5,6,7,8,9,10,11,12)], show_colnames = T, show_rownames = T)
  # why are the DNA-binding counts of fibromatous so large
# remove adenomas and squamous
tetramerization_and_no_domain <- pheatmap(t(heatmap_data)[c(2,7),], show_colnames = T, show_rownames = T)
tetramerization <- pheatmap(t(heatmap_data)[c(2,1),], show_colnames = T, show_rownames = T)
transactivation_and_terminal <- pheatmap(t(heatmap_data)[c(4,6),], show_colnames = T, show_rownames = T)
  # can disesase clusters be explained by amount of cases/number of mutaitons
  # can mutation site be explained by proximity/location on gene?
# do hot pairs have a lot of mutations in common?
# do cold paris have little in common?

