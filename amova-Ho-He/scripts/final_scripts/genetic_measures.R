# Genetic diversity analysis

#"hierfstat"----
library("hierfstat")
library("adegenet")
library("dplyr")

#### My data
df <- read.delim("~/Documents/project-diversity/amova-Ho-He/data/my_final_data.txt", header = F) # read the data file: paste the population and ids in bash
dim(df)
isolates <- as.character(df$V1) # individuals labels
all_coutries <- as.character(df$V2) # the population

loci <- df[, -c(1,2)] # remove the indv and pop columns
df_2 <- df2genind(loci, ploidy = 1, ind.names = isolates, pop = all_coutries, sep = "\t") # need these for the optimized code to add stratification by population
#strata(df_2) <- data.frame(pop(df_2)) # These are initial approches optimized code is below

#df_2 <- df2genind(loci, ploidy = 1, ind.names = isolates, pop = all_coutries, sep = "\t", strata = data.frame(pop(df_2)))
df_2 <- df2genind(loci, ploidy = 1, ind.names = isolates, pop = all_coutries, sep = "\t", strata = data.frame(all_coutries))
# df_2 <- df2genind(loci, ploidy = 1, ind.names = isolates, pop = all_coutries, sep = "\t")
# addStrata(df)

#div <- summary(df_2) #Get Genetic diversity (observed and expected heterozygosity)
#names(div)
#plot(div$Hobs, xlab="Loci number", ylab="Observed Heterozygosity", main="Observed heterozygosity per locus")
#plot(div$Hobs,div$Hexp, xlab="Hobs", ylab="Hexp", main="Expected heterozygosity as a function of observed heterozygosity per locus")
summary(df_2) # summarizes a genind object # optimized from the above code

df_3 <- genind2hierfstat(df_2)
stats_hier <- basic.stats(df_3, diploid = F) # Ho and He analyses
stats_hier
# basic.stats(df_3, diploid =F) # Ho and He analyses
wc(df_3, diploid = F) # Fst


# Pairwise Fst

wc84 <- genet.dist(df_3, method = "WC84", diploid = F)
wc84
nei87 <- genet.dist(df_3, method = "Nei87", diploid = F)
nei87
#"poppr - AMOVA test"----
library(poppr)

df_2 <- df2genind(loci, ploidy = 1, ind.names = isolates, pop = all_coutries, sep = "\t")
# strata(df_2) <- data.frame(pop(df_2))##

df_2_genclone = as.genclone(df_2)
pop_file <- read.delim("~/Documents/project-diversity/amova-Ho-He/data/pop_file_2.txt", header = F)

df_2_genclone_strat <- as.genclone(df_2_genclone, strata=pop_file)

## AMOVA TESTS (not including outgroup individuals)
amova_results <- poppr.amova(df_2_genclone_strat, pop, cutoff=0.95)#, clonecorrect = TRUE)
amova_results
# test for significance 
amova_test <- randtest(amova_results, nrepet = 1000)
amova_test
plot(amova_test)

