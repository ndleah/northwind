library(tidyverse)
library(here)
library(ggplot2)
library(sqldf)
library(ggrepel)

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
  facet_wrap(vars(supplier_region)) +
  theme(legend.position = "bottom")

#Sale Performances
#Question 3
#Question 9
#Question 10

# Sale Contribution by Categories
category <- sqldf(
  "SELECT
      category_name,
      SUM(total_sale_amount_including_discount) as total
  FROM q10
    GROUP BY category_name
  "
)
# calculate percentage
category <- category %>% 
  arrange(desc(total)) %>%
  mutate(prop = round(100 * total / sum(total),1))
# get the position
category <- category %>% 
  mutate(csum = rev(cumsum(rev(total))), 
         pos = total/2 + lead(csum, 1),
         pos = if_else(is.na(pos), total/2, pos))
# pie chart
category %>% 
  filter(prop > 0.01) %>% # filter out 0% value
  ggplot(aes(x = "", y = total, fill = fct_inorder(category_name))) + 
  geom_bar(stat = "identity", width = 1) +
  geom_col(color = "black", width = 1) +
  coord_polar("y", start = 0) + 
  geom_label_repel(data = category %>% filter(prop > 0.01),
                   aes(y = pos, label = paste0(prop, "%")),
                   size = 4.5, nudge_x = 1, show.legend = FALSE) +
  labs(
    title = "Sale Contribution by Categories"
  ) +
  scale_fill_brewer(palette = "Pastel1") +
  theme_classic() +
  guides(fill = guide_legend(title = "categories")) +
  ggthemes::theme_tufte() +
  theme(plot.title = element_text(size = 15L, hjust = 0.5)) +
  theme(legend.position = "bottom")

# Sale Contribution by Employees
employee <- sqldf(
  "SELECT
      employee_full_name,
      SUM(total_sale_amount_including_discount) as total
  FROM q10
    GROUP BY employee_full_name
  "
)
# calculate percentage
employee <- employee %>% 
  arrange(desc(total)) %>%
  mutate(prop = round(100 * total / sum(total),1))
# get the position
employee <- employee %>% 
  mutate(csum = rev(cumsum(rev(total))), 
         pos = total/2 + lead(csum, 1),
         pos = if_else(is.na(pos), total/2, pos))
# pie chart
employee %>% 
  filter(prop > 0.01) %>% # filter out 0% value
  ggplot(aes(x = "", y = total, fill = fct_inorder(employee_full_name))) + 
  geom_bar(stat = "identity", width = 1) +
  geom_col(color = "black", width = 1) +
  coord_polar("y", start = 0) + 
  geom_label_repel(data = employee %>% filter(prop > 0.01),
                   aes(y = pos, label = paste0(prop, "%")),
                   size = 4.5, nudge_x = 1, show.legend = FALSE) +
  labs(
    title = "Sale Contribution by Employees"
  ) +
  scale_fill_brewer(palette = "Set2") +
  theme_classic() +
  guides(fill = guide_legend(title = "Employee Names")) +
  ggthemes::theme_tufte() +
  theme(plot.title = element_text(size = 15L, hjust = 0.5))+
  theme(legend.position = "bottom")

# Sale Performance of Employees by Categories
ggplot(q10) +
  aes(
    x = category_name,
    fill = employee_full_name,
    weight = total_sale_amount_including_discount
  ) +
  geom_bar() +
  scale_fill_hue(direction = 1) +
  labs(
    x = "category",
    y = "sale amount",
    title = "Sale Performance of Employees by Categories",
    fill = "Employees"
  ) +
  coord_flip() +
  ggthemes::theme_par() +
  theme(plot.title = element_text(size = 15L, hjust = 0.5)) +
  theme(legend.position = "bottom")+
  facet_wrap(vars(employee_full_name))

# correlation between Units In Stock vs Reorder Level
ggplot(q9, aes(x = total_discount_percentage, y = total_number_orders)) + 
  geom_point(alpha = .6, , colour="#710193") + 
  geom_smooth(method = 'lm', formula = y ~ x, colour="red") +
  labs(title = "Discount vs Number of Orders",
       x = "Total Discount Percentage",
       y = "Total Number Orders") +
  ggthemes::theme_par() +
  theme(plot.title = element_text(hjust = 0.5))

