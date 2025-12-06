#Ismail Shalanfeh
#Coin flips - Chance

#=== set up ===
library(tidyverse)
library(lsr)
theme_set(theme_classic())

#=== Case 1 - Normal coin ===
NCoin_SpamFlips <- read.table("NSpamFlips.csv", header = TRUE, sep = ",")
NCoin_ThreeHeads <- read.table("NThreeHeads.csv", header = TRUE, sep = ",")

#=== Case 2 - Modded coin ===
MCoin_SpamFlips <- read.table("SpamFlips.csv", header = TRUE, sep = ",")
MCoin_ThreeHeads <- read.table("ThreeHeads.csv", header = TRUE, sep = ",")



#===== Three Heads =====

#== Tail Graphs
#Normal Coin
NCoin_ThreeHeads$tailBin <- cut(
  NCoin_ThreeHeads$tails,
  breaks = c(0, 2, 4, 6, 8, 10, 12, 14, 16, Inf),
  right = FALSE,
  labels = c("0-2", "2-4", "4-6", "6-8", "8-10", "10-12", "12-14", "14-16", "17+")
)

#Modded Coin
MCoin_ThreeHeads$tailBin <- cut(
  MCoin_ThreeHeads$tails,
  breaks = c(0, 2, 4, 6, 8, 10, 12, 14, 16, Inf),
  right = FALSE,   
  labels = c("0-2", "2-4", "4-6", "6-8", "8-10", "10-12", "12-14", "14-16", "17+")
)

#Plotting tails
ggplot(NCoin_ThreeHeads, aes(x = tailBin)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(
    title = "Three Heads - Normal Coin: Tails",
    x = "Tails",
    y = "Count"
  )


ggplot(MCoin_ThreeHeads, aes(x = tailBin)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(
    title = "Three Heads - Modded Coin: Tails",
    x = "Tails",
    y = "Count"
  )

#total tails
sum(MCoin_ThreeHeads$tails)
sum(NCoin_ThreeHeads$tails)

#percent mean increase in tails
N_TH_Tails_Mean <- mean(NCoin_ThreeHeads$tails)
M_TH_Tails_Mean <- mean(MCoin_ThreeHeads$tails)

TH_Tails_MeanPercentDif <- ((N_TH_Tails_Mean - M_TH_Tails_Mean) / M_TH_Tails_Mean) * 100


#== Statistical significance

#tails significance
qqnorm(NCoin_ThreeHeads$tails)
qqline(NCoin_ThreeHeads$tails, col = "red") #Abnormal

qqnorm(MCoin_ThreeHeads$tails)
qqline(MCoin_ThreeHeads$tails, col = "red") #Abnormal

#Data could not be made normal, Using the mann-whitney test

wilcox.test(NCoin_ThreeHeads$tails, MCoin_ThreeHeads$tails, alternative=
              "greater", paired = FALSE) #statistically significant

#tail streak significance
qqnorm(NCoin_ThreeHeads$LargestTailStreak)
qqline(NCoin_ThreeHeads$LargestTailStreak, col = "red") #Abnormal

qqnorm(MCoin_ThreeHeads$LargestTailStreak)
qqline(MCoin_ThreeHeads$LargestTailStreak, col = "red") #Abnormal
#couldn't transform to be normal using log and sqrt
#using mann-whitney test

wilcox.test(NCoin_ThreeHeads$LargestTailStreak, MCoin_ThreeHeads$LargestTailStreak, alternative=
              "greater", paired = FALSE) #statistically significant

#===== Spam Flips =====

#==Mean Percent Differences
#percent mean increase in tails
N_SF_Tails_Mean <- mean(NCoin_SpamFlips$tails)
M_SF_Tails_Mean <- mean(MCoin_SpamFlips$tails)

SF_Tails_MeanPercentDif <- ((N_SF_Tails_Mean - M_SF_Tails_Mean) / M_SF_Tails_Mean) * 100

#percent mean increase in heads
N_SF_Heads_Mean <- mean(NCoin_SpamFlips$heads)
M_SF_Heads_Mean <- mean(MCoin_SpamFlips$heads)

SF_Heads_MeanPercentDif <- ((M_SF_Heads_Mean - N_SF_Heads_Mean) / N_SF_Heads_Mean) * 100

#== Largest Tail Graphs
#Normal Coin
NCoin_SpamFlips$TailBin <- cut(
  NCoin_SpamFlips$LargestTailStreak,
  breaks = c(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, Inf),
  right = FALSE,   
  labels = c("13–14", "14–15", "15–16", "16–17", "17–18", "18-19",
             "19-20", "20-21", "21-22", "22-23", "23-24", "24-25", "25-26", "27+")
)


#Modded Coin
MCoin_SpamFlips$TailBin <- cut(
  MCoin_SpamFlips$LargestTailStreak,
  breaks = c(10, 11, 12, 13, 14, 15, Inf),
  right = FALSE,   
  labels = c("10–11", "11–12", "12–13", "13–14", "14–15", "16+")
)

#Plotted tail streaks
ggplot(NCoin_SpamFlips, aes(x = TailBin)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(
    title = "Spam Flips - Normal Coin: Largest Tail Streak",
    x = "Largest Tail Streak",
    y = "Count"
  )

ggplot(MCoin_SpamFlips, aes(x = TailBin)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(
    title = "Spam Flips - Modded Coin: Largest Tail Streak",
    x = "Largest Tail Streak",
    y = "Count"
  )

#== Statistical significance
#tail streak significance
shapiro.test(NCoin_SpamFlips$LargestTailStreak) #Abnormal
shapiro.test(MCoin_SpamFlips$LargestTailStreak) #Abnormal
#couldn't transform to be normal using log and sqrt
#using mann-whitney test

wilcox.test(NCoin_SpamFlips$LargestTailStreak, MCoin_SpamFlips$LargestTailStreak, alternative=
              "greater", paired = FALSE) #statistically significant


#tails significance
shapiro.test(NCoin_SpamFlips$tails) #normal
shapiro.test(MCoin_SpamFlips$tails) #normal

t.test(NCoin_SpamFlips$tails, MCoin_SpamFlips$tails, alternative =
         "greater", var.equal = FALSE) #statistically significant




#===== Table Numbers =====
#=== Spam flip numbers ===
#total tails
sum(NCoin_SpamFlips$tails)
sum(MCoin_SpamFlips$tails)

#mean tails
mean(NCoin_SpamFlips$tails)
mean(MCoin_SpamFlips$tails)

#median tails
median(NCoin_SpamFlips$tails)
median(MCoin_SpamFlips$tails)

#standard deviation
sd(NCoin_SpamFlips$tails)
sd(MCoin_SpamFlips$tails)

#mean chance of tails
mean(NCoin_SpamFlips$tails) / sum(mean(NCoin_SpamFlips$tails) + mean(NCoin_SpamFlips$heads)) * 100
mean(MCoin_SpamFlips$tails) / sum(mean(MCoin_SpamFlips$tails) + mean(MCoin_SpamFlips$heads)) * 100

#mean chance of heads
mean(NCoin_SpamFlips$heads) / sum(mean(NCoin_SpamFlips$tails) + mean(NCoin_SpamFlips$heads)) * 100
mean(MCoin_SpamFlips$heads) / sum(mean(MCoin_SpamFlips$tails) + mean(MCoin_SpamFlips$heads)) * 100

#largest tail streak
max(NCoin_SpamFlips$LargestTailStreak)
max(MCoin_SpamFlips$LargestTailStreak)

#largest head streak
max(NCoin_SpamFlips$LargestHeadStreak)
max(MCoin_SpamFlips$LargestHeadStreak)

#95th percentile tail streak
quantile(NCoin_SpamFlips$LargestTailStreak, .95)
quantile(MCoin_SpamFlips$LargestTailStreak, .95)

#99th percentile tail streak
quantile(NCoin_SpamFlips$LargestTailStreak, .99)
quantile(MCoin_SpamFlips$LargestTailStreak, .99)

#standard deviation tail streak
sd(NCoin_SpamFlips$LargestTailStreak)
sd(MCoin_SpamFlips$LargestTailStreak)

#standard deviation head streak
sd(NCoin_SpamFlips$LargestHeadStreak)
sd(MCoin_SpamFlips$LargestHeadStreak)


#=== Three Heads numbers ===
#mean tails
mean(NCoin_ThreeHeads$tails)
mean(MCoin_ThreeHeads$tails)

#median tails
median(NCoin_ThreeHeads$tails)
median(MCoin_ThreeHeads$tails)

#standard deviation
sd(NCoin_ThreeHeads$tails)
sd(MCoin_ThreeHeads$tails)

#largest tail streak
max(NCoin_ThreeHeads$LargestTailStreak)
max(MCoin_ThreeHeads$LargestTailStreak)

#mean tail streak
mean(NCoin_ThreeHeads$LargestTailStreak)
mean(MCoin_ThreeHeads$LargestTailStreak)

#median tail streak
median(NCoin_ThreeHeads$LargestTailStreak)
median(MCoin_ThreeHeads$LargestTailStreak)

#standard deviation tail streak
sd(NCoin_ThreeHeads$LargestTailStreak)
sd(MCoin_ThreeHeads$LargestTailStreak)

#95th percentile tail streak
quantile(NCoin_ThreeHeads$LargestTailStreak, .95)
quantile(MCoin_ThreeHeads$LargestTailStreak, .95)

#99th percentile tail streak
quantile(NCoin_ThreeHeads$LargestTailStreak, .99)
quantile(MCoin_ThreeHeads$LargestTailStreak, .99)

#mean chance of tails
mean(NCoin_ThreeHeads$tails) / sum(mean(NCoin_ThreeHeads$tails) + 3) * 100
mean(MCoin_ThreeHeads$tails) / sum(mean(MCoin_ThreeHeads$tails) + 3) * 100

#mean chance of heads
3 / sum(mean(NCoin_ThreeHeads$tails) + 3) * 100
3 / sum(mean(MCoin_ThreeHeads$tails) + 3) * 100



