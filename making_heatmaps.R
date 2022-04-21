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

# remove NAs
diseases_w_o_nas <- diseases[is.na(diseases$domain),]
# make domain counts for each disease

