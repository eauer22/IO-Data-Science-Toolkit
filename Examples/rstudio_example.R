library(tidyverse)

example <- 
  mtcars %>% 
  group_by(carb, cyl) %>% 
  summarize(avg_mpg = mean(mpg))
