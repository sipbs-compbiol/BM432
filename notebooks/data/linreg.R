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

# Add text annotation to plot
text(x=6.2, y=70, pos=4,
     labels=paste("y =",
                  round(model$coefficients[2], 2),
                  "x +",
                  round(model$coefficients[1], 2),
                  "; r^2 = ",
                  round(summary(model)$r.squared, 2)))