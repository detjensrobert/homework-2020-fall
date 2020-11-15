---
header-includes:
  - \usepackage{tikz}
  - \usepackage{tikz-qtree}
---

# ST 314 Midterm

## Robert Detjens - 933606667

---

### 1. Typographical errors in a single chapter of a statistics textbook occur at a rate of 2 errors per chapter. Which probability distribution would you use to model the number of errors in a random chapter of a statistics textbook?

A. Binomial

### 2. Wood screws produced by a certain manufacturing company will be defective with a probability of 0.01, independently of each other. The company sells screws in packages of 10. Which probability distribution would you use to model the number of defective screws in a randomly selected package?

A. Binomial

### 3. The number of miles that a car is able to moves under its own power starts “high” and gradually declines, at a rate of $\frac{1}{150000}$ per mile, as the number of miles it is driven increases. Which probability distribution would you use to model the lifetime of a car?

C. Exponential

---

$$
\begin{tikzpicture}[grow=right]
\tikzset{level distance=100pt,sibling distance=10pt}
\tikzset{execute at begin node=\strut}
\tikzset{every tree node/.style={align=center,anchor=north}}
\Tree [.{1000000 people}
  [.{Does not\\99.9\%, 999000} {Test negative\\97.902\%, 979020} {Test positive\\1.998\%, 19980} ]
  [.{Has flu\\0.1\%, 1000} {Test negative\\0.002\%, 20} {Test positive\\0.098\%, 980} ]
]
\end{tikzpicture}
$$

### 4.  If everyone in the population gets tested, how many people will have the virus and receive a negative test result?

B. 20

### 5. Given that a particular person tests positive for having the super-flu, what is the probability that they are actually infected?

A. 0.00098

### 6. What is the probability a randomly chosen person tests positive for the flu?

C. 0.02096

$\pagebreak$

### 7. What is the probability there will be three or more tutors available during a given shift?

C. 0.36

### 8. How many tutors are expected to be available during a single shift?

A. 2.2

### 9. What is the standard deviation for the number of tutors available during a single shift?

B. 1.319

---

### 10. Based on the shape of the distribution, what type of probability distribution would be the most appropriate to model days between accidents?

B. Exponential

### 11. The cumulative distribution function for days between accidents is $F(x) = 1 - e^{-\frac{x}{18}}, x \geq 0$. What is the probability the time between accidents is more than 40 days?
