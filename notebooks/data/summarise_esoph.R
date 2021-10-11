# Load Oesophagus case/control data
# First row is a header
data = read.table("esoph-tab.tsv", header=TRUE, sep="\t", stringsAsFactors=TRUE)

# Obtain a summary of each column in the loaded data
summary(data)

# Calculate standard deviations of the number of cases and controls
sd(data$ncases)
sd(data$ncontrols)
