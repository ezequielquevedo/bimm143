#' ---
#' title: "Crop Analysis Q3 2013"
#' author: "John Smith"
#' date: "May 3rd, 2014"
#' ---

# Class 5 R Graphics
# 2A: Line Plot
# Read in table
weight <- read.table("bimm143_05_rstats/weight_chart.txt", header = TRUE)
# plot to be a filled square, pt size = 1.5X, double line width, scale Y-axis,
# X-axis title, Y-axis title, Main title
plot(weight$Age, weight$Weight, 
     pch = 11, cex = 1.5, 
     lwd = 2, ylim = c(2, 10), 
     xlab = "Age (months)", ylab = "Weight (kg)", main = "Baby Weight vs Age")

weight$Age
weight$Weight
plot(weight$Age, weight$Weight)

# 2B: Barplot
# read in table
# use sep = "\t" as argument for tab delimited data
nfeatures <- read.table("bimm143_05_rstats/feature_counts.txt", 
                        sep = "\t", header = TRUE)
# View table
#View(nfeatures)
# make default barplot
barplot(nfeatures$Count)
# change global plot margin parameters
par(mar = c(5.1, 10.1, 4.1, 4.1))
# make formatted barplot
barplot(nfeatures$Count, 
        names.arg = nfeatures$Feature, # read in Feature vector as names
        horiz = TRUE, ylab = "", xlab = "Feature", xlim = c(0, 80000),
        main = "Feature Counts", las = 1, # las = 1 makes horizontal text labels
        col = rainbow(12)) # use colors

# 2C: Histograms
x <- c(rnorm(10000), rnorm(10000) + 4) # generate distributions
hist(x) # default
hist(x, breaks = 100)

# 3A: Providing Color Vectors
# read in table using read.delim (US)
counts <- read.delim("bimm143_05_rstats/male_female_counts.txt") 
#read.delim2 uses comma instead of decimal
#View(counts)
par(mar = c(6, 5, 4, 4))

# you can type multipe lines at once by holding down option + command
barplot(counts$Count,
        names.arg = counts$Sample,
        las = 2,
        col = c("red", "black", "white"),
        ylim = c(0, 20),
        ylab = "Frequency")
# you can type multipe lines at once by holding down option + command
barplot(counts$Count,
        names.arg = counts$Sample,
        las = 2,
        col = heat.colors(0), # heat map colors
        ylim = c(0, 20),
        ylab = "Frequency")

