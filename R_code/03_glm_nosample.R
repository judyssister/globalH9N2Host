##2019-02-28##
# purpose -----------------------------------------------------------------
# no sample size predicator
# prior on the indicator, binomial(n = 11, prob = 0.06106908933829369)
# mugration model in BEAST 1

# input -------------------------------------------------------------------
# data/h9n2_686_nosample.location.glm.log

# output ------------------------------------------------------------------
# glm_nosample_686.pdf


rm(list = ls())
library(tidyverse)
library(egg) # egg package is used to rearrange the plot
library(scales) # include the color generating function


pdf(file = "glm_nosample_686.pdf", width = 11, height = 11, onefile = FALSE)

# plot 1: boxplot about the coefficients ------------------------------------


# set theme_bw() as the default ggplot theme

coefficient.box <- ggplot(coefficients, aes(x = label, y = Coefficient)) + 
  geom_hline(yintercept = 0, color = "gray20", size = 1) + 
  geom_violin(aes(fill = label), trim = TRUE) + 
  scale_fill_manual(values = hue_pal(h.start = 0, direction = 1)(13)[c(3:13, 1, 2)]) + 
  geom_boxplot(width = 0.2) + 
  scale_x_discrete(breaks = c("location1", "location2", "location3",
                              "location4", "location5", "location6", 
                              "location7", "location8", "location9", 
                              "location10", "location11", "location12", 
                              "location13"),
                   labels = c("poultry trade", "poultry production\norigin", 
                              "poultry production\ndestination", "geographic\ndistance", "share border",  
                              "humidity\norigin", "humidity\ndestination", 
                              "temperature\norigin", "temperature\ndestination",
                              "temperature\nseasonality origin", "temperature\nseasonality\ndestination", "", "")) + 
  scale_y_continuous(limits = c(-1, 2.6)) + 
  coord_flip() + 
  theme(legend.position = "none", 
        axis.title.y = element_blank(), 
        panel.border = element_rect(fill = NA, colour = "black", size = 3), 
        axis.text.y = element_text(size = 20, face = "bold", color = "black", hjust = 0), 
        axis.text.x = element_text(size = 20, face = "bold", color = "black"), 
        axis.title.x = element_text(size = 20, face = "bold"), 
        text = element_text(family = "Times")) 

# Plot 2: bar plot about the indicator ------------------------------------

indicator.bar <- ggplot(indicators, aes(x = label, y = Indicator)) + 
  geom_hline(yintercept = posterior.suggestive, color = "gray60", size = 1) + 
  geom_hline(yintercept = posterior.strong, color = "gray20", size = 1.5) + 
  geom_bar(stat = "identity", fill = "#0073C2FF") + 
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = .25), 
                     labels = c("0", "0.25", "0.5", "0.75", "1")) + 
  coord_flip() + 
  theme(axis.title.y = element_blank(), 
        axis.text.y = element_blank(), 
        axis.ticks.y = element_blank(), 
        panel.border = element_rect(fill = NA, colour = "black", size = 3), 
        axis.text.x = element_text(size = 20, face = "bold", color = "black"),
        axis.title.x = element_text(size = 20, face = "bold"), 
        text = element_text(family = "Times"))

ggarrange(coefficient.box, indicator.bar, widths = 2:1)

dev.off()




