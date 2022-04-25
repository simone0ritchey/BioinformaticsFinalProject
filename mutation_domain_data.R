## Determining affected domains

## Amino acids positions of TP53 domains
##    Transactivation domain 1: 6-29
##    Transactivation domain 2: 35-59
##    DNA-binding domain: 100-288
##    Tetramerisation domain: 319-357
##  (Domain regions found on http://www.ebi.ac.uk/interpro/protein/UniProt/P04637/)
##    Proline-rich domain: 64-92
##    Nuclear Localization domain: 316-325 <--- Decided to NOT include due to overlap
##    C-terminal domain: 356–393

## Load all mutation data
mutations_total <- read.table(file = 'mutations_all.tsv', sep = '\t', header = TRUE)
mutations_total2 <- as.matrix(mutations_total)

## Separate the consequences column into "Mutation Consequence" and "Amino Acid Position"
consequences <- mutations_total[, 4]

mutation_consequence = matrix(nrow = length(consequences), ncol = 2)
colnames(mutation_consequence) = c("Mutation Consequence", "Amino Acid Position")


for (i in 1:length(consequences)) {
  
  place_hold <- gsub(" TP53", "", consequences[i])
  place_hold <- unlist((strsplit(place_hold, split = " ")))
  
  aa <- gsub("\\*.*","", place_hold[length(place_hold)])
  aa <- gsub("\\_.*","", aa)
  aa <- gsub("\\..*","", aa)
  aa_position <- gsub("[^0-9.]", "", aa)
  
  if (length(place_hold) > 2) {
    mt_consequence <- paste(place_hold[1], place_hold[2], sep = " ")
  }
  else {
    mt_consequence <- place_hold[1]
  }
  
  mutation_consequence[i, ] <- c(mt_consequence, aa_position)
}

## Match mutations to domains

aa_positions <- as.numeric(mutation_consequence[, 2])
domains <- vector("character", length = length(aa_position))

for (i in 1:length(aa_positions)) {
  if (is.na(aa_positions[i])) {
    domains[i] = "NA"
  }
  else {
    if (6 <= aa_positions[i] && aa_positions[i] <= 29) {
      domains[i] = "Transactivation 1"
    }
    else if (35 <= aa_positions[i] && aa_positions[i] <= 59) {
      domains[i] = "Transactivation 2"
    }
    else if (64 <= aa_positions[i] && aa_positions[i] <= 92) {
      domains[i] = "Proline-Rich"
    }
    else if (100 <= aa_positions[i] && aa_positions[i] <= 288) {
      domains[i] = "DNA-Binding"
    }
    else if (319 <= aa_positions[i] && aa_positions[i] <= 357) {
      domains[i] = "Tetramerisation"
    }
    else if (356 <= aa_positions[i] && aa_positions[i] <= 393) {
      domains[i] = "C-Terminal"
    }
    else{
      domains[i] = "No Domain"
    }
  }
}

test <- cbind(mutation_consequence, domains)
colnames(test) = c("Mutation Consequence", "Amino Acid Position", "Domain")

mutations_total3 <- mutations_total2[, 1:3]

mutations_total3 <- cbind(mutations_total3, test)

## Final Version of dataframe of mutation and domain data
mutations_total3 <- as.data.frame(mutations_total3)
table(mutations_total3$Domain)

install.packages("data.table")
library("data.table")

fwrite(mutations_total3, "C:/Users/navya/DESKTOP-4GCCJN7/Documents/R/BioinformaticsFinalProject/mutation_domains.csv")
