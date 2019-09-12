##2019-03-17##
# purpose -----------------------------------------------------------------
# map the phylogenetic tree with locations on the branch
# phylogenetic tree from beast 1

# input -------------------------------------------------------------------
# h9n2_686_location_mcc.tree

# output ------------------------------------------------------------------
# phylogenetic_tree_location.pdf


rm(list = ls())
require(ggtree)
library(tidyverse)

wd <- getwd()
setwd("./data")


x <- read.beast("h9n2_686_location_mcc_100m.tree")


setwd(wd)


pdf("phylogenetic_tree_location.pdf", width = 11, height = 8)

p <- ggtree(x, mrsd = "2018-06-14", aes(color = location)) + 
  theme_tree2() + 
  geom_nodelab(aes(x = branch, label = round(as.numeric(location.prob), 2)), 
               vjust = -.5, size = 3, show.legend = FALSE, family = "Times") + 
  geom_text(aes(x = max(x), label = ""), size = 1, hjust = -.3) +
  scale_x_continuous(breaks = c(1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015, 2020), 
                     minor_breaks = seq(1970, 2015, 5)) +
  theme(text = element_text(family = "Times"), 
        panel.grid.major =  element_line(color = "darkgrey", size = .2),
        panel.grid.minor = element_line(color = "grey", size = .2),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(), 
        legend.position = c(.1, .675),
        legend.key.width = unit(0.8, "cm"),
        legend.key.height = unit(0.6, "cm"),
        legend.box.background = element_rect(fill = NA, colour = NA), 
        legend.text = element_text(size = 15, color = "black", face = "bold"),
        legend.title = element_text(size = 17, face = "bold"), 
        axis.text.x = element_text(color = "black", size = 16), 
        axis.line.x = element_blank()) + 
  labs(color = "Location") + 
  geom_cladelabel(node = 779, label = "G9-like", align = TRUE, offset = -38, fontsize = 6, 
                  color = "darkgoldenrod3", barsize = 1.5, offset.text = -19, angle = 90, hjust = 0.4, 
                  family = "Times") + 
  geom_cladelabel(node = 983, label = "G1-like", align = TRUE, offset = -38, fontsize = 6, 
                  color = "forestgreen", barsize = 1.5, offset.text = -19, angle = 90, hjust = 0.3, 
                  family = "Times") + 
  geom_cladelabel(node = 690, label = "Korea-like", align = TRUE, offset = -38, fontsize = 6, 
                  color = "blueviolet", barsize = 1.5, offset.text = -19, angle = 90, hjust = 0.5, 
                  family = "Times") + 
  geom_cladelabel(node = 688, label = "Eurasian-like", offset = -35, fontsize = 6, 
                  color = "darkgoldenrod2", barsize = 1.5, offset.text = -19, angle = 90, hjust = 0.5, 
                  family = "Times")  + 
  geom_cladelabel(node = 1343, label = "American-like", offset = -33.9, fontsize = 6, 
                  color = "red2", barsize = 1.5, offset.text = -19, angle = 90, hjust = 0.2, 
                  family = "Times") + 
  scale_color_hue(labels = c("Algeria", "Bangladesh", "China", "Egypt" , "Hong Kong", "India", "Indonesia",
                             "Iran", "Israel", "Japan", "Jordan", "Netherlands", "Pakistan", "South Korea",
                             "Uganda", "Emirates", "USA", "Vietnam"))


flip(p, 983, 779)


dev.off()





