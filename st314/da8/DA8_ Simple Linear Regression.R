####### R Code For DATA ANALYSIS 8                               ##########################
####### REGRESSION                                               ##########################

# Upload the dataset for this week.
# Call it examdata

examdata = read.csv('~/repos/2020-fall-homework/st314/da8/ExamDataW19.csv', header = TRUE)

####### SUPER IMPORTANT STEP!!!!!!!                               ###########################
####### ATTACH THE DATASET!!!!!!!!!                               ###########################

# The attach command allows you to call variable from the dataset with specifying the dataset.
# attaching a dataset tells R you only are working with variables from this dataset.

attach(examdata)

# Did you do the step above? Make sure you attach the dataset.

####### Follow along with the example code below.                 ############################
####### This follows the handout SLR Steps located in Module 8.   ############################

###!!!     The example code below is for GENERAL x and y.                      ############################
###!!!     CHANGE x's to the specific explanatory variable name from the dataset ############################
###!!!     CHANGE y's to the specific response variable name from the dataset    ############################
x = Midterm
Final = Final

# Step 1: Describe the relationship between your two variables
#     1.	Graphically: Create a scatterplot and describe your data commenting on the direction,
#         strength and form and any outliers.  Recall, x is the explanatory variable and Final is
#         the observed response.
# R Scatterplot:
plot(Midterm,Final, main = "Midterm vs. Final grade correlation")

#     2.	Numerically: Calculate the correlation coefficient r to summarize the linear relationship.
#      a. Note: If the relationship is obviously not linear then the correlation coefficient will
#         not be an accurate measurement. Other methods should be investigated.
# R Correlation:
  cor(Midterm,Final)

# Step 2: Calculate the least-squares regression line and check conditions for inference.
#     1.	Calculate the least-square regression line but only to be able to check conditions using
#         a residual plot of the model.
# R Calculate the least -squares regression line:

  mod = lm(Final~Midterm)
  summary(mod) #note here the line has been named mod

#     2.	Check conditions
#      a.	To make inference the sample must be obtained randomly from the population of interest.
#         No graphical display to check this.
#      b.	Observations are independent of each other. No graphical display to assess this condition.
#      c.	Plot the residuals. If the residuals are randomly scattered with no distinct patterns then
#         all of the conditions below are satisfied.
#       i.	Linearity Condition: Linear relationship must exist between x and y.
#         1.	Is it violated? Look out for "U" shaped or curved patterns in the residuals.
#       ii.	Constant Variation Condition: For each value of x, the distribution of the response variable
#           has the same spread: constant variance condition.
#         1.	Is it violated? Look out for funnel or cone shape in the residuals.
#       iii.	Normality Condition: For each value of x, the distribution of the response variable is
#             normally distributed.
#         1.	Is it violated? The number of residuals above or below the reference line of zero are different.
# R create a residual plot:

  plot(Midterm,mod$residuals)
  abline(h= 0, lty = 2)

# mod$resdiuals pulls the residuals from the linear model names "mod"
# abline(h=0) adds a horizontal line at zero

#      d.	If there are violations in the assumptions then you can consider a transformation of one or both variables.
#       i.	Outside scope of class.
#      e.	If conditions are satisfied then proceed with interpreting the results of your least squares regression line.

# Step 3: Decide on a good-fitting model and proceed.
#    1.	Once a "good-fitting" model is found, use software to proceed with the rest of the analysis.
#      a.	State the equation of the least-squares regression line.
#      b.	Determine if the explanatory variable is a significant predictor of the response variable by performing
#         a t-test on the slope (Ho: Beta_1 = 0).
#       i.	State the strength evidence that the explanatory variable is a significant predictor of the response.
#       ii.	If a significance level was used, state whether or not the null is rejected.
# R Calculate the least -squares regression line and obtain p-value from t test statistic:
  mod = lm(Final~Midterm)
  summary(mod)#note here the line has been named mod

#      c.	Construct a t confidence interval for the slope Beta_1 with n-2 degrees of freedom.
#       i.	Interpret the point estimate and CI of the slope Beta_1 in the context of the problem.
# R calculate a confidence interval for Beta_1:
  confint(mod, level = 0.95)#note the level can be changed
#      d.	Provide the estimate of Beta_1 (the standard deviation of the residuals, assumed to be constant)
#      e.	Be able to use the regression equation to predict the response variable for a given value of
#         the explanatory variable.
# R calculate the predicted y value for a value of x:
  predict(mod, data.frame(Midterm = xnew)) #note xnew is the new value to be predicted.

#      f.	Calculate Confidence and Prediction Intervals for the response when x= xnew.
# R Calculate a Confidence Interval for the response:
  predict(mod, data.frame(Midterm = xnew), interval = "confidence", level = 0.95) #note xnew is the new value to be predicted.

  # R Calculate a Prediction Interval for the response:
  predict(mod, data.frame(Midterm = xnew), interval = "prediction", level = 0.95) #note xnew is the new value to be predicted.

# Create a scatterplot that includes the least squares regression line, confidence bands and prediction bands.
# To do this use the following function.
# Define function by running bulk of code then use PICIplot(mod, x, y, alpha) by plugging in the specifics from your data.
          PICIplot <- function(mod, Midterm, Final, alpha){
            #Constructing intervals
            n=length(Midterm)
            df=n-2 # n of observations - number of betas
            SSxx = sum(Midterm^2)-1/n*sum(Midterm)^2
            MSres= (summary(mod)$sigma)^2
            xbar = mean(Midterm)
            ybar = mean(Final)
            ci.bandlow = mod$fitted + qt(alpha/2,df)*sqrt(MSres*(1/n+(Midterm-xbar)^2/SSxx))
            ci.bandhigh = mod$fitted - qt(alpha/2,df)*sqrt(MSres*(1/n+(Midterm-xbar)^2/SSxx))
            pi.bandlow = mod$fitted + qt(alpha/2,df)*sqrt(MSres*(1+1/n+(Midterm-xbar)^2/SSxx))
            pi.bandhigh = mod$fitted - qt(alpha/2,df)*sqrt(MSres*(1+1/n+(Midterm-xbar)^2/SSxx))

            plot(Midterm,Final, main ="Scatterplot with LSRL, Confidence and Prediction Bands", xlab="Midterm", ylab="Final", pch=16, col = "black")
            points(sort(Midterm), sort(mod$fitted), type="l", lwd=2)
            points(sort(Midterm), sort(ci.bandlow), type="l", lty=2, col="blue")
            points(sort(Midterm), sort(ci.bandhigh), type="l",lty=2, col="blue")
            points(sort(Midterm), sort(pi.bandlow), type="l",lty=4, col= "purple")
            points(sort(Midterm), sort(pi.bandhigh), type="l",lty = 4, col="purple")
            legend("topleft",c("LSRL", "CI", "PI"),lty = c(1,2,4), col=c("black", "blue", "purple"))
          }
# Define the model name, x, Final, and alpha level in function below
PICIplot(mod, Midterm, Final, alpha)
