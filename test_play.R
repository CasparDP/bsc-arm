set.seed(12)

# Number of observations - student x year
n <- 500

# Generate a student id variable - balanced panel

id <- rep(1:500, each = 1) %>% sort()

# talent = runif(n=n, min=0.0, max=1)

# Generate a binary treatment variable
becks_data <- tibble(
  student = id,
  # Generate a binary treatment variable that is positively associated with talent - omitted variable bias
  treatment = rbinom(n = n, size = 1, prob = 0.5),
  education = sample(1:5, size = n, replace = TRUE) + 0.75 * treatment,
  gender = rbinom(n = n, size = 1, prob = .4),
  talent = runif(n = n, min = 0, max = 2) + 2 * treatment + 0.75 * education,
  treatment_random = rbinom(n = n, size = 1, prob = 0.5),
  # Generate a continuous outcome variable
  # Add some random noise to the outcome
  outcome = 4 + 0 * treatment + 0.4 * talent + 0 * treatment * talent + 0.6 * education + -.2 * gender + rnorm(n = n, mean = 0, sd = 1)
)

lm(outcome ~ treatment + gender + education + talent, data = becks_data) %>% summary()
lm(outcome ~ treatment + gender + education, data = becks_data) %>% summary()

lm(outcome ~ treatment_random, data = becks_data) %>% summary()


becks_data %>%
  mutate(high_tal = case_when(
    talent > mean(talent) ~ 1,
    TRUE ~ 0
  ) %>% as.character()) %>%
  group_by(treatment, high_tal) %>%
  summarise(across("outcome", ~ mean(.x))) %>%
  mutate(
    beer = case_when(
      treatment == 1 ~ "Beer",
      treatment == 0 ~ "No beer"
    ),
    # Cosmetic change to reorder so "Beer" is on the left
    beer = factor(beer, levels = c("Beer", "No beer"))
  ) %>%
  ggplot(aes(x = beer, y = outcome, group = high_tal, color = high_tal)) +
  geom_point(size = 2) +
  geom_line(aes(group = high_tal), linetype = "dashed", size = 1.5) +
  scale_y_continuous(breaks = seq(0, 10, 1)) +
  scale_color_manual(values = c("0" = "#93B8D6", "1" = "#F7AB64"), name = "High talent") +
  labs(x = "", y = "Grade") +
  ggthemes::theme_hc(base_size = 18) +
  theme(legend.position = "bottom") +
  ylim(0, 10)

becks_data %>%
  group_by(treatment) %>%
  summarise(across("outcome", ~ mean(.x))) %>%
  mutate(
    beer = case_when(
      treatment == 1 ~ "Beer",
      treatment == 0 ~ "No beer"
    ),
    # Cosmetic change to reorder so "Beer" is on the left
    beer = factor(beer, levels = c("Beer", "No beer"))
  ) %>%
  ggplot(aes(x = beer, y = outcome, group = beer, fill = beer)) +
  geom_col() +
  scale_y_continuous(breaks = seq(0, 10, 1)) +
  scale_fill_manual(name = "", values = c("#F7AB64", "#93B8D6")) +
  labs(x = "", y = "Grade") +
  ggthemes::theme_hc(base_size = 18) +
  theme(legend.position = "") +
  ylim(0, 10)

t.test(outcome ~ treatment, data = becks_data)
t.test(education ~ treatment, data = becks_data)
t.test(gender ~ treatment, data = becks_data)
t.test(talent ~ treatment, data = becks_data)
t.test(outcome ~ treatment_random, data = becks_data)
t.test(talent ~ treatment_random, data = becks_data)


library(tidyverse)
library(plotly)
library(ggplot2)
library(gganimate)


# Basic barplot:
ggplot(a, aes(x = group, y = values, fill = group)) +
  geom_bar(stat = "identity")

# Make a ggplot, but add frame=year: one image per year
ggplot(data, aes(x = group, y = values, fill = group)) +
  geom_bar(stat = "identity") +
  theme_bw() +
  # gganimate specific bits:
  transition_states(
    id,
    transition_length = 2,
    state_length = 1
  ) +
  ease_aes("sine-in-out")

# Save at gif:
anim_save("288-animated-barplot-transition.gif")

set.seed(123)
# Throw a dice 10 times - repeat it 1000 times
a <- map(1:10, ~ sample(1:6, size = 10, replace = TRUE) %>%
  tibble(
    mean = mean(.),
    sd = sd(.),
    throws = length(.)
  ) %>%
  # keep only mean, sd, and throw,
  select(mean, sd, throws) %>%
  # Delete duplicates
  distinct()) %>%
  bind_rows() %>%
  mutate(id = row_number()) %>%
  # plot means of each throw
  ggplot(aes(x = mean)) +
  geom_bar(stat = "count", fill = "lightblue") +
  # geom_col( stat = "identity", fill = "lightblue") +
  geom_vline(xintercept = 3.5, color = "red") +
  labs(
    title = "Distribution of {frame_time} means of 10 throws of a dice",
    x = "Mean of 10 throws",
    y = "Frequency"
  ) +
  guides(
    color = "none",
    fill = "none"
  ) +
  ggthemes::theme_hc(base_size = 18) +
  theme(legend.position = "bottom") +
  # gganimate specific bits:
  transition_states(
    id,
    transition_length = 2,
    state_length = 100
  ) +
  ease_aes("sine-in-out")
a

g <- animate(a, renderer = magick_renderer())
# Save at gif:
anim_save("barplot-transition.gif")

map(1:1000, ~ sample(1:6, size = 1, replace = TRUE) %>%
  tibble(throw = .)) %>%
  mutate(mean = cumall(throw) / row_number()) %>%
  set.seed(123)

# Number of observations - student x year
n <- 500

# Generate a student id variable - balanced panel

id <- rep(1:100, each = 5) %>% sort()

# Generate a binary treatment variable
did_data <- tibble(
  student = id,
  treatment = rep(0:1, each = n / 2),
  # Generate a binary time variable - 2 years
  year = rep(1:5, n / 5) - 3,
  after = case_when(
    year <= 0 ~ 0,
    TRUE ~ 1
  ),
  # Generate a continuous outcome variable
  # Assume the treatment has an effect of 2 units on the outcome
  # Add some random noise to the outcome
  performance = 7.5 + -1.5 * treatment + 0 * after + 1.1 * treatment * after + .2 * rnorm(n)
)

rm(id, n)

# Dictionary => set only once per session
dict <- setFixest_dict(c(
  performance = "Grade",
  treatment = "Treatment",
  after = "After",
  student = "Student ID",
  year = "Year"
))

# The style of the table
my_style <- style.tex(
  tpt = TRUE,
  notes.tpt.intro = "\\footnotesize"
)
setFixest_etable(style.tex = my_style, markdown = TRUE)

d <- feols(performance ~ i(year, treatment, -1) | student + year, data = did_data)

etable(d,
  title = "Effect of policy change on student grades\n Event study",
  digits = 3,
  tex = TRUE,
  fitstat = ~ ar2 + n,
  replace = T,
  style.tex = style.tex("aer"),
  highlight = .(
    "rowcol, #C9DBEA, se" = c("year::-2:treatment"),
    "rowcol, #E7E8EE, se" = c("year::1:treatment", "year::2:treatment")
  ),
  coef.just = "l",
  placement = "h!",
  view = T
)
