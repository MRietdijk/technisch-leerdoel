library(ggplot2)

data <- read.csv("lidar_data2.csv")

# define two arrays for the time in seconds and lengths of those timestamps
lenghts <- c()
times <- c()

curr_time <- 0
curr_length <- 0


# loop over data
for (i in 1:nrow(data)) {
  # break out of for loop when hitting the 31st second.
  if (data$Protocol[i] != "RTPS"){
    next
  }
  if (floor(data$Time[i]) == 31) {
    break
  }
  # Check if data is still in the current second.
  if (floor(data$Time[i]) == curr_time) {
    curr_length <- curr_length + data$Length[i]
  } else {
    # to MegaBits.
    curr_length <- curr_length * 8 / 1000000
    # save to lengths
    lenghts <- c(lenghts, curr_length)
    # save times
    times <- c(times, curr_time)
    # save to times
    curr_time <- floor(data$Time[i])
    # saves every second
    curr_length <- data$Length[i]
  }
}

# Plot to pdf
ggplot() +
  geom_line(aes(x = times, y = lenghts), color = "blue") +
  xlab("Time in seconds") +
  ylab("Length of messages in Mega bits") +
  ggtitle("Data transfer per second of protocol RTPS")