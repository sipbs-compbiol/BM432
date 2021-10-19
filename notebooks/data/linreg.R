# Load the Prestige dataset
prestige = read.table("prestige.tab",
                      header=TRUE,
                      sep="\t",
                      stringsAsFactors=TRUE)

# Carry out linear regression on the dataset, with prestige as
# the dependent variable, and education as the explanatory
# variable
model = lm(prestige ~ education, data=prestige)

# Show diagnostic graphics for the regression model
par(mfrow=c(2,2))
plot(model)
par(mfrow=c(1,1))

# Plot fitted regression curve on the data
plot(prestige ~ education, data=prestige)
lines(sort(prestige$education),
      fitted(model)[order(prestige$education)],
      col="red")