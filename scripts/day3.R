

# load libraries ----------------------------------------------------------

library(tidyverse)
library(patchwork)
library(ggplot2)



# load our data -----------------------------------------------------------

surveys <- read_csv("data/portal_data_joined.csv")

## remove all missing values
surveys_complete <- na.omit(surveys)



# Exporting data ----------------------------------------------------------

write_csv(surveys_complete, file = "output/surveys_complete.csv")



# Data Visualization ------------------------------------------------------


ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue")


ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))


# Exercise:
# Use what you just learned to create a scatter plot of weight over species_id with the plot types showing in different colors. Is this a good way to show this type of data?

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight)) +
  geom_point(aes(color = plot_type), alpha = 0.1)




# Boxplot -----------------------------------------------------------------

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.1, color = "red")


# violin plot
ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight)) +
  geom_violin() +
  geom_jitter(alpha = 0.1, color = "red")


ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.1, color = "red") +
  scale_y_log10()


ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.1, color = "red")




# Modifying plots ---------------------------------------------------------


ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, aes(color = species_id)) +
  xlab("Weight (g)")


## changing the labels 
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, aes(color = species_id), shape = "diamond", size = 4) +
  labs(x = "Weight (g)",
       y = "Hindfoot Length (mm)",
       title = "Hindfoot Length vs Weight",
       subtitle = "Distribution pattern of hindfoot length weight across species",
       caption = "Data: Ernst et al.,",
       color = "Species ID")

# change background
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, aes(color = species_id), shape = "diamond", size = 4) +
  labs(x = "Weight (g)",
       y = "Hindfoot Length (mm)",
       title = "Hindfoot Length vs Weight",
       subtitle = "Distribution pattern of hindfoot length weight across species",
       caption = "Data: Ernst et al.,",
       color = "Species ID") +
  theme_bw()


ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, aes(color = species_id), shape = "diamond", size = 4) +
  labs(x = "Weight (g)",
       y = "Hindfoot Length (mm)",
       title = "Hindfoot Length vs Weight",
       subtitle = "Distribution pattern of hindfoot length weight across species",
       caption = "Data: Ernst et al.,",
       color = "Species ID") +
  theme_bw()



## change the font size and type

ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, aes(color = species_id), shape = "diamond", size = 4) +
  geom_rug() +
  labs(x = "Weight (g)",
       y = "Hindfoot Length (mm)",
       title = "Hindfoot Length vs Weight",
       subtitle = "Distribution pattern of hindfoot length weight across species",
       caption = "Data: Ernst et al.,",
       color = "Species ID") +
  scale_x_log10() +
  theme_bw() +
  theme(axis.title.x = element_text(size = 16, family = "Arial", face = "bold"),
        axis.title.y = element_text(size = 16, family = "Arial", face = "bold"),
        axis.text.x = element_text(size = 12, family = "Arial", face = "italic"),
        axis.text.y = element_text(size = 12, family = "Arial", face = "italic"),
        legend.text = element_text(size = 10, family = "Arial"),
        legend.title = element_text(size = 14, family = "Arial"),
        text = element_text(family = "Arial"),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        plot.caption = element_text(size = 12),
        plot.subtitle = element_text(size = 12, hjust = 0.5),
        legend.key = element_rect(color = "white", fill = "white"),
        legend.position = "right") +
  guides(color = guide_legend(override.aes = list(alpha = 1, size = 4)))
  
## saving plots

my_plot <- ggplot(data = surveys_complete,
                  mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, aes(color = species_id), shape = "diamond", size = 4) +
  geom_rug() +
  labs(x = "Weight (g)",
       y = "Hindfoot Length (mm)",
       title = "Hindfoot Length vs Weight",
       subtitle = "Distribution pattern of hindfoot length weight across species",
       caption = "Data: Ernst et al.,",
       color = "Species ID") +
  scale_x_log10() +
  theme_bw() +
  theme(axis.title.x = element_text(size = 16, family = "Arial", face = "bold"),
        axis.title.y = element_text(size = 16, family = "Arial", face = "bold"),
        axis.text.x = element_text(size = 12, family = "Arial", face = "italic"),
        axis.text.y = element_text(size = 12, family = "Arial", face = "italic"),
        legend.text = element_text(size = 10, family = "Arial"),
        legend.title = element_text(size = 14, family = "Arial"),
        text = element_text(family = "Arial"),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        plot.caption = element_text(size = 12),
        plot.subtitle = element_text(size = 12, hjust = 0.5),
        legend.key = element_rect(color = "white", fill = "white"),
        legend.position = "right") +
  guides(color = guide_legend(override.aes = list(alpha = 1, size = 4)))

ggsave(filename = "plots/scatterplot.png",
       plot = my_plot,
       width = 6, height = 5, dpi = 400)



# Facets ------------------------------------------------------------------

ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, aes(color = species_id)) +
  scale_x_log10() +
  facet_wrap("sex")


surveys_2000_2001 <- surveys_complete %>% 
  filter(year == 2000 | year == 2001 | year == 2003)


ggplot(data = surveys_2000_2001,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, aes(color = species_id)) +
  scale_x_log10() +
  facet_grid("year ~ sex")


yearly_sex_counts <- surveys_complete %>% 
  count(year, genus, sex)

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap("genus") +
  labs(x = "Year",
       y = "Number of Animals") +
  theme_bw() +
  theme(axis.title.x = element_text(size = 16, family = "Arial", face = "bold"),
        axis.title.y = element_text(size = 16, family = "Arial", face = "bold"),
        axis.text.x = element_text(size = 12, family = "Arial", face = "italic"),
        axis.text.y = element_text(size = 12, family = "Arial", face = "italic"),
        legend.text = element_text(size = 10, family = "Arial"),
        legend.title = element_text(size = 14, family = "Arial"),
        text = element_text(family = "Arial"),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        plot.caption = element_text(size = 12),
        plot.subtitle = element_text(size = 12, hjust = 0.5),
        legend.key = element_rect(color = "white", fill = "white"),
        legend.position = "right",
        strip.text = element_text(size = 14, color = "blue", face = "bold"),
        strip.background = element_rect(fill = "white"))
  
  
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(cols = vars(genus))


ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(genus))


my_facet_theme <- theme(axis.title.x = element_text(size = 16, family = "Arial", face = "bold"),
                  axis.title.y = element_text(size = 16, family = "Arial", face = "bold"),
                  axis.text.x = element_text(size = 12, family = "Arial", face = "italic"),
                  axis.text.y = element_text(size = 12, family = "Arial", face = "italic"),
                  legend.text = element_text(size = 10, family = "Arial"),
                  legend.title = element_text(size = 14, family = "Arial"),
                  text = element_text(family = "Arial"),
                  plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
                  plot.caption = element_text(size = 12),
                  plot.subtitle = element_text(size = 12, hjust = 0.5),
                  legend.key = element_rect(color = "white", fill = "white"),
                  legend.position = "right",
                  strip.text = element_text(size = 14, color = "blue", face = "bold"),
                  strip.background = element_rect(fill = "white"))




ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(cols = vars(genus)) +
  my_facet_theme

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(genus)) +
  my_facet_theme




# Combining plots ---------------------------------------------------------


my_plot <- ggplot(data = surveys_complete,
                  mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, aes(color = species_id), shape = "diamond", size = 4) +
  geom_rug() +
  labs(x = "Weight (g)",
       y = "Hindfoot Length (mm)",
       title = "Hindfoot Length vs Weight",
       subtitle = "Distribution pattern of hindfoot length weight across species",
       caption = "Data: Ernst et al.,",
       color = "Species ID") +
  scale_x_log10() +
  theme_bw() +
  theme(axis.title.x = element_text(size = 16, family = "Arial", face = "bold"),
        axis.title.y = element_text(size = 16, family = "Arial", face = "bold"),
        axis.text.x = element_text(size = 12, family = "Arial", face = "italic"),
        axis.text.y = element_text(size = 12, family = "Arial", face = "italic"),
        legend.text = element_text(size = 10, family = "Arial"),
        legend.title = element_text(size = 14, family = "Arial"),
        text = element_text(family = "Arial"),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        plot.caption = element_text(size = 12),
        plot.subtitle = element_text(size = 12, hjust = 0.5),
        legend.key = element_rect(color = "white", fill = "white"),
        legend.position = "right") +
  guides(color = guide_legend(override.aes = list(alpha = 1, size = 4)))
my_plot

my_facet_plot <- ggplot(data = yearly_sex_counts,
                        mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap("genus") +
  labs(x = "Year",
       y = "Number of Animals") +
  theme_bw() +
  theme(axis.title.x = element_text(size = 16, family = "Arial", face = "bold"),
        axis.title.y = element_text(size = 16, family = "Arial", face = "bold"),
        axis.text.x = element_text(size = 12, family = "Arial", face = "italic"),
        axis.text.y = element_text(size = 12, family = "Arial", face = "italic"),
        legend.text = element_text(size = 10, family = "Arial"),
        legend.title = element_text(size = 14, family = "Arial"),
        text = element_text(family = "Arial"),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        plot.caption = element_text(size = 12),
        plot.subtitle = element_text(size = 12, hjust = 0.5),
        legend.key = element_rect(color = "white", fill = "white"),
        legend.position = "right",
        strip.text = element_text(size = 14, color = "blue", face = "bold"),
        strip.background = element_rect(fill = "white"))
my_facet_plot


library(patchwork)

# to put one plot beside other one, use |
my_plot | my_facet_plot

# to put one plot under the other one, use /
my_plot / my_facet_plot


my_plot / my_facet_plot + plot_layout(heights = c(3, 3))


my_other_facet_plot <- ggplot(data = yearly_sex_counts,
                              mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(genus)) +
  my_facet_theme
my_other_facet_plot

(my_plot / my_facet_plot) | my_other_facet_plot

my_final_plot <- (my_plot / my_facet_plot) | my_other_facet_plot
ggsave(filename = "plots/combined_plot.png",
       plot = my_final_plot,
       width = 11, height = 9, dpi = 400)







