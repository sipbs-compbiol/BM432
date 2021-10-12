# Load Oesophagus case/control data
# First row is a header
data = read.table("esoph-tab.tsv", header=TRUE, sep="\t", stringsAsFactors=TRUE)

# Obtain a summary of each column in the loaded data
summary(data)

# Calculate standard deviations of the number of cases and controls
sd(data$ncases)
sd(data$ncontrols)

# Produce a table with counts of ncases and ncontrols for each alcgp category
aggregate(cbind(ncases_tot=data$ncases, ncontrols_tot=data$ncontrols),
          by=list(alcgp=data$alcgp), FUN=sum)

# Generate a plot of ncases and ncontrols for each alcgp category
library(dplyr)
library(ggplot2)
library(tidyr)
dfm = data %>%
  group_by(alcgp) %>%
  summarise(ncases=sum(ncases), ncontrol=sum(ncontrols)) %>%
  pivot_longer(!alcgp, names_to="datatype", values_to="count")
ggplot(dfm, aes(x=alcgp, y=count)) +
  geom_bar(aes(fill=datatype), position="dodge", stat="identity")

# Save bar chart as PDF for publication
ggsave("case_control_counts_by_alcgp.pdf")
