# Load packages
library("dplyr")
library(adegenet)
library(ade4)
library(ggplot2)
library("RColorBrewer")
library("magrittr")
library("factoextra")

# Principle component analysis
pop_file <- read.delim("/Volumes/SPM-PC/Research/masters_research/pca-pcoa/PCA-PCoA-re/lables/sub_c_2_pop.txt", header = F) # load the file we extract populations from

df <- read.delim("/Volumes/SPM-PC/Research/masters_research/pca-pcoa/data/data/c", header = F) # read the data file
unlabled_df <- select(df, -c(V1)) # exclude the first column (lables) so that we are able to convert the data to a matrix

obj <- df2genind(unlabled_df, ploidy=1, type="PA") # creating a genind object from our data matrix

pop(obj) <- paste(pop_file$V2) # setting populations on the dataset
#nPop(obj) # confirming the number of populations in the dataset
popNames(obj)

indNames(obj) <- paste(df$V1) # adding isolate lables to our created genind object 

X <- tab(obj, NA.method="mean") # relpacing NAs for PCA analysis
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 4)

# scree plot
fviz_eig(pca1, main = "Screeplot - Eigenvalues", linecolor =  "black", ncp = 10,
         barcolor = heat.colors(10), barfill = heat.colors(10), addlabels = T,
         ggtheme = theme_classic())# plot scree plot on percentage

# factoextra-based plots-grouping by country
## PC 1+2
groups <- as.factor(obj$pop)
col <- brewer.pal(n=5, name = "Dark2")
fviz_pca_ind(pca1,
             axes = c(1, 2),
             label = "none",
             col.ind = groups, # color by groups
             palette = colors,
             addEllipses = TRUE, # Concentration ellipses
             ellipse.type = "confidence",
             legend.title = "Groups",
             title="PC 1 vs 2",
             repel = TRUE
)

## PC 1+3
groups <- as.factor(obj$pop)
col <- brewer.pal(n=5, name = "Dark2")
fviz_pca_ind(pca1,
             axes = c(1, 3),
             col.ind = groups, # color by groups
             palette = colors,
             addEllipses = TRUE, # Concentration ellipses
             ellipse.type = "confidence",
             legend.title = "Groups",
             title="PC 1 vs 3",
             repel = TRUE
)

groups <- as.factor(obj$pop)
col <- brewer.pal(n=5, name = "Dark2")
fviz_pca_ind(pca1,
             axes = c(1, 3),
             label = "none",
             col.ind = groups, # color by groups
             palette = colors,
             addEllipses = TRUE, # Concentration ellipses
             ellipse.type = "confidence",
             legend.title = "Groups",
             title="PC 1 vs 3 ",
             repel = TRUE
)

# contributions PCA
fviz_pca_ind(pca1, col.ind = "cos2",
             axes = c(1, 3),
             gradient.cols = c("blue","yellow","red"),
             repel = T
             )

fviz_pca_ind(pca1, col.ind = "cos2",
             axes = c(1, 2),
             gradient.cols = c("blue","yellow","red"),
             repel = T
)

fviz_pca_ind(pca1, col.ind = "cos2",
             gradient.cols = c("blue","yellow","red"),
             repel = T
)
