
##### Part 1 Start ##################################################################################
# Download the data set EpaFE2019data.csv from Canvas to your computer.
# Don't change anything about the dataset.
# Simply download and save to familiar location.

# Upload Dataset using the read.csv() command below.
# file.choose() will open a search window for you to select the file.
# Note your data is called CarData.Population

CarData.Population = read.csv('~/repos/2020-fall-homework/st314/da4/EpaFE2019Data.csv', header = TRUE)

# Part 1a
# Create a histogram of the variable CombCO2. Consider this the population.
hist(CarData.Population$CombCO2, main = "Population Vehicles Sold in US",
     xlab = "Combined Carbon Dioxide Emissions", col = "lightgreen")

# What is the size of the population. In other words, how many vehicles are represented in the dataset?
# USe the command length() to find, N = ?
N = length(CarData.Population$CombCO2)
N

# Calculate the population mean mu
mu = mean(CarData.Population$CombCO2)
mu

# Calculate the population standard deviation sigma.
# Note sd() gives sample standard deviation. To remedy this we need to multply by sqrt((N-1)/N).
# Makes nearly no difference.
sigma = sd(CarData.Population$CombCO2)*sqrt((N-1)/N)
sigma

# Part 1b
# Take a sample of size 45 from the dataset.
n = 45
CarData.Sample = CarData.Population[sample(1:N,n),]
CarData.Sample

#Create a histogram of the variable CombCO2 for your sampled data.
hist(CarData.Sample$CombCO2, main = "Random Sample of 45 Vehicles Sold in US",
     xlab = "Combined Carbon Dioxide Emissions", col = "lightblue")
# Calculate the sample mean for CombCO2.
x.bar = mean(CarData.Sample$CombCO2)
x.bar

# Calculate the sample standard deviation for CombCO2.
s = sd(CarData.Sample$CombCO2)
s

# Parts 1c-d
# Use xbar, mu and sigma to perform a z procedures.

##### Part 1 End ##################################################################################

##### Part 2 Done by Hand ##################################################################
# Test against the true mean mu H_0: mu = true mean, H_a: mu =/= true mean
# Use xbar, mu and sigma to perform a z procedures.

##### Part 3 Start ################################################################################
# Part 3b
# Simulate 10000 samples from the population. Plot each of their sample means.
# Set up your vectors for your simulation values to fill.
# nsim is the number of times you want to take a sample of 45 from the population.
nsim = 10000
samp.means = rep(0,nsim)

# write a loop that will take a sample of size 45 and from that sample calculate the mean.
# Store those values in a vector for each of the 10000 samples.
# Be sure to highlight all of the code from for through the last }.
# The code will take a few moments to run but nothing will happen except it showing up in the console.

for(i in 1:nsim)
{ Samp = CarData.Population[sample(1:N,n),]
  samp.means[i] = mean(Samp$CombCO2)
}

# Create a histogram of sample means. This is the sampling distribution of xbar.
hist(samp.means, main = "Sampling Distribution",
     xlab = "Sample Means , n = 45", col = "orange", breaks = 100)

# Take mean and standard deviation of the sampling distribution from xbar.
mean(samp.means)
sd(samp.means)

# Part 3c
# Calculate a z test statistic for every random sample.
# Basically, perform 10000 z tests then plot all of these.
# You may need to rerun the code from part 2.
# Creates vector of 10000 z test statistics
z.stats = (samp.means - mu)/(sigma/sqrt(n))

#Plots 10000 z test statistics
hist(z.stats, main = "Histogram of 10000 z statistics", col = "violet",
     xlab = "z",breaks = 100)

# Part 3d
# Creates vector of 10000 p-values from 10000 z test statistics
p.values = round(2*pnorm(-abs(z.stats)),2)

# Plots 10000 p-value
hist(p.values, main = "P-values from 10000 z tests", breaks = seq(0,1,0.05), col = c(rep("red",2), rep("green",18)))

# Proportion of P-values below significance level
Rate = 1-sum(p.values>0.10)/nsim
Rate

#### Part 3 End #################################################################
