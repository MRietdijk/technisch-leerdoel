library(ggplot2)

data <- read.csv("data.csv")

lenghts <- c()
times <- c()

curr_time <- 0
curr_length <- 0


for (i in 1:nrow(data)) {
  if (floor(data$Time[i]) == curr_time) {
    curr_length <- curr_length + data$Length[i]
  } else {
    lenghts <- c(lenghts, curr_length)
    times <- c(times, curr_time)
    curr_time <- floor(data$Time[i])
    curr_length <- data$Length[i]
  }
}
data <- data.frame(times, lenghts)

ggplot() +
  geom_line(aes(x = times, y = lenghts), color = "blue") +
  xlab("Time in seconds") +
  ylab("Length of messages in bytes") +
  ggtitle("Length of messages over time")