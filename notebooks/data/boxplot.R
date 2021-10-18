# Load the ToothGrowth dataset
# There are three columns:
#  - len: length of tooth (cm)
#  - supp: supplement (VC or OJ)
#  - dose: supplement dosage (mg/day)
toothgrowth = read.table("toothgrowth.tab",
                         header=TRUE,
                         sep="\t",
                         stringsAsFactors=TRUE)

# Use R base graphics to produce a boxplot
boxplot(len ~ supp + dose,
        data=toothgrowth,
        xlab="Supplement and dosage",
        ylab="Tooth length",
        main="Tooth length by supplement and dosage")

# Use R base graphics to produce a stripchart/1D scatterplot
stripchart(len ~ supp + dose,
           data=toothgrowth,
           method="jitter",
           pch=19,
           frame=FALSE,
           vertical=TRUE,
           xlab="Supplement and dosage",
           ylab="Tooth length",
           main="Tooth length by supplement and dosage")

# Use ggplot2 to overlay a stripchart on a boxplot
# First, import the ggplot2 library
library(ggplot2)

# Ensure that dosage is recorded as a category/factor
toothgrowth$dose = as.factor(toothgrowth$dose)

# Plot the graph
ggplot(toothgrowth,
       aes(x=dose, y=len, fill=supp)) +
  geom_boxplot() +
  geom_jitter(position=position_jitterdodge()) +
  scale_fill_manual(values=c("#999999", "#E69F00"))
