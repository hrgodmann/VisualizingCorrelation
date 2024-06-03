# Set the number of points you want to generate
num_points <- 15
source("/Users/henrikgodmann/Desktop/workspace/GitHub/functions/colors/Rcolors.R")

# Create a data frame with random x and y coordinates (positive values only)
# set.seed(123)  # Set a seed for reproducibility
random_data <- data.frame(
  x = runif(num_points, min = 0, max = 10),  # Adjust the max as needed
  y = runif(num_points, min = 0, max = 10)
)

# Calculate the means of x and y
mean_x <- mean(random_data$x)
mean_y <- mean(random_data$y)

# Create a data frame with vertices for the rectangles
rectangle_data <- data.frame(
  x = random_data$x,
  y = random_data$y,
  xend = mean_x,
  yend = mean_y
)

# Determine the fill color based on the quadrant
rectangle_data$fill <- ifelse(rectangle_data$x > mean_x & rectangle_data$y > mean_y, my_blue,
                              ifelse(rectangle_data$x <= mean_x & rectangle_data$y <= mean_y, my_blue,
                                     ifelse(rectangle_data$x <= mean_x & rectangle_data$y > mean_y, my_red, my_red)))

# Create the basic plot with the x and y mean lines
plot(random_data$x, random_data$y, type = "n", xlab = "", ylab = "",
     xlim = c(-0.5, 10.5), ylim = c(-0.5, 10.5), main = "Random Points and Rectangles at Means (Positive Values Only)", xaxt = "n", yaxt = "n", bty = "n")

abline(h = mean_y, col = my_black)  # Horizontal line at mean_y
abline(v = mean_x, col = my_black)  # Vertical line at mean_x

# Add transparent rectangles
for (i in 1:num_points) {
  polygon(c(rectangle_data$x[i], rectangle_data$x[i], rectangle_data$xend[i], rectangle_data$xend[i]),
          c(rectangle_data$y[i], rectangle_data$yend[i], rectangle_data$yend[i], rectangle_data$y[i]),
          col = adjustcolor(rectangle_data$fill[i], alpha.f = 0.5))
}

# Add custom x and y-axis labels
axis(1, at = seq(0, 10, by = 2), labels = seq(0, 10, by = 2), lwd = 2)
axis(2, at = seq(0, 10, by = 2), labels = seq(0, 10, by = 2), lwd = 2)

# Add points with grey fill and black outline (fully opaque) on top
points(random_data$x, random_data$y, pch = 19, col = my_gray1, bg = my_black, cex = 1.5, lwd = 2)
