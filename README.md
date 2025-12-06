## Scenario
Consider the following 2 coins:
- **Coin N**, or normal coin, is a coin that will always have a 50/50 chance of landing either heads or tails.
- **Coin M**, or modded coin, is a coin that will initially have a 50/50 chance of landing either heads or tails, while gaining a 2.5% chance of hitting heads every time it lands on tails. When the coin lands on heads, it is reset back to it's initial state.

Given these 2 coins, would the change in probability between Coin N and Coin M be statistically significant enough in the long/short term to be worth considering?

## Tests
Both coins were put through the following tests, with the results being exported to csv files for analysis in R.
### Spam Flips
As the name suggests, the Spam Flips (SF) test repeatedly flips the coin until a certain number of flips is hit. 
For gathering data, a 1000 coins (each with random seeds) were tested, with each coin being flipped 1 million times. 
### Three Heads
The Three Heads (TH) test flips a coin repeatedly until 3 total heads are hit.
For gathering data, 1 million coins (each with random seeds) were tested.

## Findings
### Statistical Significance
#### Spam Flips Test
Comparing Coin N's tails to Coin M's tails using a one-tailed independent T-test:
- P-value < 2.2e-16

Comparing Coin N's largest tail streaks to Coin M's largest tail streaks using a one-tailed Mann-Whitney test:
- P-value < 2.2e-16
- W = 999977

#### Three Heads Test
Comparing Coin N's tails to Coin M's tails using a one-tailed Mann-Whitney test:
- P-value < 2.2e-16
- W = 5.1887e+11

Comparing Coin N's largest tail streaks to Coin M's largest tail streaks using a one-tailed Mann-Whitney test:
- P-value < 2.2e-16
- W = 5.2311e+11
### Mean, Median, Table

#### Spam Flips Test
##### Tails Statistics

| Metric           | Normal Coin | Modded Coin |
| ---------------- | ----------- | ----------- |
| **Total Tails**  | 500011097   | 478707984   |
| **Mean Tails**   | 500011.1    | 478708      |
| **Median Tails** | 500005.5    | 478689.5    |
| **Std Dev**      | 492.0618    | 458.8689    |

##### Probabilities

| Metric                   | Normal Coin | Modded Coin |
| ------------------------ | ----------- | ----------- |
| **Mean Chance of Tails** | 50.00111    | 47.8708     |
| **Mean Chance of Heads** | 49.99889    | 52.1292     |

##### Streak Metrics

| Metric                          | Normal Coin | Modded Coin |
| ------------------------------- | ----------- | ----------- |
| **Largest Tail Streak**         | 30          | 16          |
| **Largest Head Streak**         | 31          | 30          |
| **Std Dev (tail streak)**       | 1.943644    | 0.8107857   |
| **Std Dev (head streak)**       | 1.885744    | 1.810876    |
| **95th Percentile Tail Streak** | 23          | 13          |
| **99th Percentile Tail Streak** | 25          | 15          |

#### Three Heads Test

##### Tail Statistics

| Metric           | Normal Coin | Modded Coin |
| ---------------- | ----------- | ----------- |
| **Mean Tails**   | 2.992772    | 2.751944    |
| **Median Tails** | 2           | 2           |
| **Std Dev**      | 2.442679    | 2.124871    |
##### Probabilities

| Metric                   | Normal Coin | Modded Coin |
| ------------------------ | ----------- | ----------- |
| **Mean Chance of Tails** | 49.93969    | 47.84372    |
| **Mean Chance of Heads** | 50.06031    | 52.15628    |

##### Streak Metrics

| Metric                          | Normal Coin | Modded Coin |
| ------------------------------- | ----------- | ----------- |
| **Largest Tail Streak**         | 21          | 13          |
| **Mean Tail Streak**            | 2.13775     | 1.931923    |
| **Median Tail Streak**          | 2           | 2           |
| **Std Dev**                     | 1.705493    | 1.414144    |
| **95th Percentile Tail Streak** | 5           | 5           |
| **99th Percentile Tail Streak** | 8           | 6           |


### Graphs
##### Three Heads Normal Coin Tails Histogram
<img src="/Images/THN_Tails.png" alt="drawing" width="200"/>

##### Three Heads Modded Coin Tails Histogram
<img src="/Images/THM_Tails.png" alt="drawing" width="200"/>

##### Spam Flips Normal Coin Longest Tail Streak Histogram
<img src="/Images/SFN_LTS.png" alt="drawing" width="200"/>

##### Spam Flips Modded Coin Longest Tail Streak Histogram
<img src="/Images/SFM_LTS.png" alt="drawing" width="200"/>
