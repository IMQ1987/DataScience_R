data <- rnorm(100)
hist(data, freq = F)
lines(density(data))
plot(density(data, kernel='gaussian'))

qqnorm(data, main = 'QQ-Plot', xlab= 'Normalverteilung',
       ylab = 't-Verteilung')
qqline(data, col = 'green')
