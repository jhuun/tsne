# ------------------------------------------------------------
# Quick R script to make a plot from the tsne results
#
# Juri Kuronen (juri.kuronen@gmail.com)
# ------------------------------------------------------------

# setwd("/path/to/tsne")

# ------------------------------------------------------------
# Choose color scheme
# ------------------------------------------------------------
# http://research.stowers-institute.org/efg/R/Color/Chart/index.htm
cc = colors()[c(12, 17, 28, 36, 624, 81, 77, 99, 155, 123)];
# http://colorbrewer2.org/
cc = c('#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00','#ffff33','#a65628','#f781bf','#999999')

# ------------------------------------------------------------
# Important functions
# ------------------------------------------------------------
scale <- function(data) {
  min_x = min(data[, 2]); min_x = min_x - abs(min_x * 0.1)
  min_y = min(data[, 3]); min_y = min_y - abs(min_y * 0.1)
  return(c(min_x, max(data[, 2]) * 1.1, min_y, max_y = max(data[, 3]) * 1.1))
}
get_seq <- function(data, y, i, f) {
  if (f <= 1) {return(data[, y][data[, 1] == i])}
  return(data[, y][data[, 1] == i][seq(1, length(data[, 1][data[, 1] == i]), f)])
}

# ------------------------------------------------------------
# Read the data generated by tsne and run the parameters code
# ------------------------------------------------------------
data <- read.table("build/res.txt", header = FALSE, sep = ",")
sc = scale(data); N = length(data[,1]) # Run this always after reading data
sz = ceiling(N / 15000); # Size-factor for .png

f = max(1, floor(N / 10000)); # Sparse plot
f = 1; # Plot every digit

# Generate the plot by running all of the below
png("plots/plot.png", width = 837 * sz, height = 723 * sz, pointsize = 18)
plot(get_seq(data, 2, 1, f), get_seq(data, 3, 1, f), pch = "0", type = "p", col = cc[1], xlim = sc[1:2], ylim = sc[3:4], xaxt = "n", yaxt = "n", xlab = "", ylab = "")
title(main = paste("MNIST,", N), cex.main = sz)
for (i in 1 : 10) {
  lines(get_seq(data, 2, i, f), get_seq(data, 3, i, f), pch=paste(i - 1), type = "p", col = cc[i])
}
dev.off()

