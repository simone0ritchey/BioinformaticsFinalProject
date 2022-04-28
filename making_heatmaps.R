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
all <- pheatmap(t(heatmap_data), show_colnames = T, show_rownames = T,)
# remove dna binding sight
w_o_dna_binding <- pheatmap(t(heatmap_data)[-1,], show_colnames = T, show_rownames = T)

# remove adenomas and squamous
w_o_high_count_diseases <- pheatmap(t(heatmap_data)[,-c(1,2)], show_colnames = T, show_rownames = T)
low_count_diseases <- pheatmap(t(heatmap_data)[,-c(1,2,3,4,5,6)], show_colnames = T, show_rownames = T)
  # of the low count diseases we could compare binding domains of mesothelial_neoplasms
    # compare amount of different mutations between dna binding domain in those and in the two largest disease counts
  # why are the DNA-binding counts of fibromatous so large
# remove adenomas and squamous
tetramerization_and_no_domain <- pheatmap(t(heatmap_data)[c(2,7),], show_colnames = T, show_rownames = T)
tetramerization <- pheatmap(t(heatmap_data)[c(2,1),], show_colnames = T, show_rownames = T)
transactivation_and_terminal <- pheatmap(t(heatmap_data)[c(4,6),], show_colnames = T, show_rownames = T)
  # can disesase clusters be explained by amount of cases/number of mutaitons
  # can mutation site be explained by proximity/location on gene?
# do hot pairs have a lot of mutations in common?
# do cold paris have little in common?

# Analyzing heatmaps

# make fundtion to determine which diseases are different between diseases of interest in a domain of interest
mutations_in_common <- function (disease1, disease2, domain) {
  disease1_data <- diseases[diseases$disease == disease1 & diseases$domain == domain,]
  disease2_data <- diseases[diseases$disease == disease2 & diseases$domain == domain,]
  disease1_only_mutations <- sum(!disease1_data$id %in% disease2_data$id)
  disease_2_only_mutatoins <- sum(!disease2_data$id %in% disease1_data$id)
  different_mutations <- list(disease1_only_mutations,disease_2_only_mutatoins)
  return(list(disease1_only_mutations,disease_2_only_mutatoins))
}

mutations_in_common("adenomas_and_adenocarcinomas","squamous_cell_neoplasms","DNA-Binding")
  # 237 unique in adenomas and 213 unique in squamous cell neoplasms
mutations_in_common("gliomas","fibromatous_neoplasms","DNA-Binding")
  # 219 unique in gliomas and 120 unique in fibrous neoplasms
mutations_in_common("mesothelial_neoplasms","complex_epitelial_neoplasms","DNA-Binding")
  # 10 unique to mesotheials_neoplasms, 0 unique to complex eqpithelial neoplasms
mutations_in_common("mesothelial_neoplasms","adenomas_and_adenocarcinomas","DNA-Binding")
  # 4 unique to mesothelial_neoplasms, 442 unique to adenomas and adenocarcinomas

disease1_data <- diseases[diseases$disease == "adenomas_and_adenocarcinomas" & diseases$domain == "DNA-Binding",]
disease2_data <- diseases[diseases$disease != "adenomas_and_adenocarcinomas" & diseases$domain == "DNA-Binding",]
disease1_only_mutations <- sum(!disease1_data$id %in% disease2_data$id)
disease_2_only_mutatoins <- sum(!disease2_data$id %in% disease1_data$id)
list(disease1_only_mutations,disease_2_only_mutatoins)
  # 136 uniquely adenomoas in the dna binding domain, 795 uniquely all other concers

# fibromatous_neoplasms have a low count of cases, but they are very high in the DNA binding domain.
disease1_data <- diseases[diseases$disease == "fibromatous_neoplasms" & diseases$domain == "DNA-Binding",]
disease2_data <- diseases[diseases$disease != "fibromatous_neoplasms" & diseases$domain == "DNA-Binding",]
disease1_only_mutations <- sum(!disease1_data$id %in% disease2_data$id)
disease_2_only_mutatoins <- sum(!disease2_data$id %in% disease1_data$id)
list(disease1_only_mutations,disease_2_only_mutatoins)
  # 40 mutations in the DNA binding domain that are unique to fibbromatous_neoplasms

# Second Roud of Heatmap data - numerical values are number of unique mutations in each domain
for (i in 1:nrow(heatmap_data2)) {
  for (j in 1:ncol(heatmap_data2)) {
    disease1_data <- diseases[diseases$disease == rownames(heatmap_data2)[i] & diseases$domain == colnames(heatmap_data2)[j],]
    disease2_data <- diseases[diseases$disease != rownames(heatmap_data2)[i] & diseases$domain == colnames(heatmap_data2)[j],]
    heatmap_data2[i,j] <- sum(!disease1_data$id %in% disease2_data$id)
  }
}
heatmap_data2

pheatmap(t(heatmap_data), show_colnames = T, show_rownames = T)
pheatmap(t(heatmap_data2), show_colnames = T, show_rownames = T)

# Third Round of heatmap data - mutations with counts of how many diseases they cause
length(unique(diseases$id))
heatmap_data3 <- matrix(nrow = length(unique(diseases$id)), ncol = 1)
rownames(heatmap_data3) <- unique(diseases$id)

for (i in 1:length(unique(diseases$id))) {
  filtered_data <- diseases[diseases$id == rownames(heatmap_data3)[i],]
  heatmap_data3[i,1] <- length(unique(filtered_data$disease))
}

# couldn't make a heatmap, so making barplot instead
barplot(heatmap_data3, main = "Number of Diseases Associated with each Mutation", axisnames = F, xlab = "Mutations", ylab = "Number of Diseases Caused by Mutation", sub = "Total Number of Mutations = 1269")

#how many are only associated with one?
new_barplot <- matrix(nrow = 10,ncol = 1)
rownames(new_barplot) <- c(1:10)
colnames(new_barplot) <- c("no_mutations","count")
for (i in 1:nrow(new_barplot)) {
  new_barplot[i,1] <- sum(heatmap_data3[,1] == rownames(new_barplot)[i])
}
barplot(t(new_barplot), ylab = "Mutation Count", xlab = "Number of Diseases Associated with each Mutation", main = "Fewer Mutations are Associated with Many Diseases", sub = "Total Number of Diseases = 14")
ncol(heatmap_4)

# number of diseases associated with mutations vs. what domain they occur in
actual_heatmap_data3 <- matrix(0,nrow = length(unique(diseases$id)), ncol = ncol(heatmap_data))
rownames(actual_heatmap_data3) <- unique(diseases$id)
colnames(actual_heatmap_data3) <- c("DNA-Binding", "Tetramerisation", "Proline-Rich", "Transactivation 1", "Transactivation 2", "C-Terminal","No Domain")
for (i in 1:nrow(actual_heatmap_data3)) {
  for (j in 1:ncol(actual_heatmap_data3)) {
    filtered_data <- diseases[diseases$id == rownames(actual_heatmap_data3)[i],]
    if (filtered_data$domain[1] == colnames(actual_heatmap_data3)[j]) {
      actual_heatmap_data3[i,j] <- heatmap_data3[i] 
    }
  }
}
pheatmap(t(actual_heatmap_data3), show_colnames = F, show_rownames = T)
pheatmap(t(actual_heatmap_data3[,-1]), show_colnames = F, show_rownames = T)
  # can the groupings be explained by the amount of mutations in the domain?
sum(actual_heatmap_data3[,"DNA-Binding"] == 10)

# selecting the mutations in the DNA-binding and Tetramerization Domain that are associated with 8 or more diseases
subseted_actual_heatmap3 <- actual_heatmap_data3[,c(1,2)]
keep <- rownames(subseted_actual_heatmap3[subseted_actual_heatmap3[,1] > 7,])
keep <- append(keep, rownames(subseted_actual_heatmap3[subseted_actual_heatmap3[,2] > 7,]))
mutations_of_interest <- filter(diseases, id %in% keep)

# mutation versus disease heatmap
heatmap_4 <- matrix(0,nrow = length(unique(diseases$id)),ncol = nrow(heatmap_data))
rownames(heatmap_4) <- unique(diseases$id)
colnames(heatmap_4) <- rownames(heatmap_data)
for (i in 1:nrow(heatmap_4)) {
  for (j in 1:ncol(heatmap_4)) {
    filtered_data <- filter(diseases, id == rownames(heatmap_4)[i])
    if (colnames(heatmap_4)[j] %in% filtered_data$disease) {
      heatmap_4[i,j] <- heatmap_4[i,j] + 1
    }
  }
}

pheatmap(t(heatmap_4), show_colnames = F, show_rownames = T, annotation =  )

?pheatmap()



