library(tidyverse)
library(here)
library(ggplot2)

q1 <- read_csv(here("csv","01_results.csv"))
q2 <- read_csv(here("csv","02_results.csv"))
q3 <- read_csv(here("csv","03_results.csv"))
q4 <- read_csv(here("csv","04_results.csv"))
q5 <- read_csv(here("csv","05_results.csv"))
q6 <- read_csv(here("csv","06_results.csv"))
q7 <- read_csv(here("csv","07_results.csv"))
q8 <- read_csv(here("csv","08_results.csv"))
q9 <- read_csv(here("csv","09_results.csv"))
q10 <- read_csv(here("csv","10_results.csv"))

# Pricing Strategy

#The Pricing Strategy
#Question 1
#Question 5
#Question 6
#Question 8

# Pricing Performance by Categories
ggplot(q6) +
  aes(
    x = price_range,
    fill = category_name,
    weight = total_number_orders
  ) +
  geom_bar() +
  scale_fill_hue(direction = 1) +
  labs(
    x = "price range",
    y = "total numer orders",
    title = "Pricing Strategy",
    subtitle = "Pricing Performance by Categories"
  ) +
  coord_flip() +
  ggthemes::theme_par() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 15L,
                              hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  ) +
  facet_wrap(vars(category_name), ncol = 4L, nrow = 2L)


#Logistics Performance
#Question 2
#Question 4
#Question 7

# correlation between average days between order shipping vs total number orders
ggplot(q2, aes(x = average_days_between_order_shipping, y = total_number_orders)) + 
  geom_point(alpha = .6, , colour="#710193") + 
  geom_smooth(method = 'lm', formula = y ~ x, colour="red") +
  labs(title = "Average Shipping Days vs Total Number Orders",
       x = "Average Shipping Days",
       y = "Total Number Orders") +
  ggthemes::theme_par() +
  theme(plot.title = element_text(hjust = 0.5))

# Average Shipping Days by Countries
ggplot(q2) +
  aes(
    x = ship_country,
    fill = ship_country,
    weight = average_days_between_order_shipping
  ) +
  geom_bar() +
  scale_fill_hue(direction = 1) +
  labs(
    x = "Shipping Countries",
    y = "Shipping Days (Days)",
    title = "Average Shipping Days by Countries (1998)"
  ) +
  ggthemes::theme_par() +
  theme(legend.position = "none")


# correlation between Units In Stock vs Reorder Level
ggplot(q7, aes(x = units_in_stock, y = reorder_level)) + 
  geom_point(alpha = .6, , colour="#710193") + 
  geom_smooth(method = 'lm', formula = y ~ x, colour="red") +
  labs(title = "Units In Stock vs Reorder Level",
       x = "Units In Stock",
       y = "Reorder Level") +
  ggthemes::theme_par() +
  theme(plot.title = element_text(hjust = 0.5))

# Reorder Level by Regions
ggplot(q7) +
  aes(
    x = category_name,
    fill = category_name,
    weight = reorder_level
  ) +
  geom_bar() +
  scale_fill_hue(direction = 1) +
  labs(
    x = "categories",
    y = "reorder level",
    title = "Logistics Performance",
    subtitle = "Reorder Level by Regions",
    fill = "categories"
  ) +
  coord_flip() +
  ggthemes::theme_par() +
  theme(
    plot.title = element_text(size = 15L,
                              hjust = 0.5),
    plot.subtitle = element_text(size = 13L,
                                 hjust = 0.5)
  ) +
  facet_wrap(vars(supplier_region))

#Sale Performances
#Question 3
#Question 9
#Question 10

q3
q9
q10