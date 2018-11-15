library(tidyverse)
library(modelr)
options(na.action = na.warn)

library(nycflights13)
library(lubridate)

#create our summary of flights per date and store in daily
daily <- flights %>%
    mutate(date = make_date(year, month, day)) %>%
    group_by(date) %>%
    summarize(n = n())

#output daily
daily

#visualize daily with a line plot
ggplot(daily, aes(date, n)) + geom_line()

#look at distribution fo flight numbers by day of week
daily <- daily %>%
  mutate(wday = wday(date, label = TRUE))
ggplot(daily, aes(wday, n)) +
  geom_boxplot()

#remove strong pattern of less flights left on a saturday, as most flights are for business
#by using a model

#first fit the model, and display its predictions overlaid on the original data
mod <- lm(n ~ wday, data = daily)

grid <- daily %>%
  data_grid(wday) %>%
  add_predictions(mod, "n")

ggplot(daily, aes(wday, n)) +
  geom_boxplot() +
  geom_point(data = grid, color = "red", size = 4)

#then compute and visualize the residuals
daily <- daily %>%
  add_residuals(mod)
daily %>%
  ggplot(aes(date, resid)) +
  geom_ref_line(h = 0) +
  geom_line()

#note change in the y axis, now seeing the deviation from the expected number of flights,
#given the day of the week

#the model seems to start failing in June
#make the cause easier to see
ggplot(daily, aes(date, resid, color = wday)) +
  geom_ref_line(h = 0) +
  geom_line()

#filter residuals , days with fewer flights than expected
daily %>%
  filter(resid < -100)

#highlight the trend with geom_smooth
daily %>%
  ggplot(aes(date, resid)) +
  geom_ref_line(h = 0) +
  geom_line(color = "grey50") + 
  geom_smooth(se = FALSE, span = 0.20)