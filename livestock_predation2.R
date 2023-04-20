cor<-read.csv("livestock_predation.csv", header=T, sep=";")

library (ggplot2)
png(file = "livestock_predation.png", width = 700, height = 600)
p<-ggplot(data = cor,
          aes(x = age, y = predation)) +
  geom_point(size = 2, colour = "black") +
  geom_smooth(aes(), color="black", se = T) +
  xlab("Age of the killed bovines (months)") + 
  ylab("Number of killings by pumas and jaguars") + 
  scale_x_continuous(limits = c(0,8))+
  theme_bw() + 
  theme(panel.grid.major.y = element_blank(), 
        panel.grid.minor.y = element_blank()) + 
  theme(panel.grid.major.x = element_blank(), 
        panel.grid.minor.x = element_blank()) +
  theme(legend.position = "none")+
  theme(plot.margin = unit(c(2,1,2,1), "cm"))+
  theme(axis.title.y = element_text(size = rel(1.8), angle = 90))+
  theme(axis.title.x = element_text(size = rel(1.8), angle = 00))+
  theme(axis.text.x = element_text(size = 14))+
  theme(axis.text.y = element_text(size = 14))

p
dev.off()

library(magick)
library(magrittr) 

# Call back the plot
plot <- image_read("livestock_predation.png")
plot2<-image_annotate(plot, "Keep calves away from the sites inhabited by large cats", 
                      color = "black", size = 25,
                      location = "10+50", gravity = "north")
plot3<-image_annotate(plot2, "Data: Palmeira et al 2008 (doi:10.1016/j.biocon.2007.09.015)
                          Visualization by @fblpalmeira | Image credit: @PhyloPic", 
                      color = "gray", size = 15, 
                      location = "10+50", gravity = "southeast")
# And bring in a logo
carcass <- image_read("https://images.phylopic.org/images/99d6140b-d113-4814-82fb-05629d7d626c/raster/1024x623.png?v=17ccecbe429") 
out<-image_composite(plot3,image_scale(carcass,"x100"), gravity="north", offset = "+220+70")

bigcat <- image_read("https://images.phylopic.org/images/3f8eff77-2868-4121-8d7d-a55ebdd49e04/raster/178x77.png?v=1697f76c504") 
out1<-image_composite(out,image_scale(bigcat,"x80"), gravity="south", offset = "-180+95")

image_browse(out1)

# And overwrite the plot without a logo
image_write(out1, "livestock_predation_v2.png")

