cor<-read.csv("livestock_predation.csv", header=T, sep=";")

library (ggplot2)
png(file = "livestock_predation.png", width = 700, height = 600)
p<-ggplot(data = cor,
          aes(x = age, y = predation)) +
  geom_point(size = 2, colour = "black") +
  geom_smooth(aes(), color="black", se = T) +
  xlab("Age of the killed bovines (months)") + 
  ylab("Number of killings by large cats") + 
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
plot2<-image_annotate(plot, "Cattle predation by puma and jaguar", 
                      color = "black", size = 25,
                      location = "10+50", gravity = "north")
plot3<-image_annotate(plot2, "Data: Palmeira et al 2008 (doi:10.1016/j.biocon.2007.09.015) | Visualization by @fblpalmeira 
                          Image credit: Palmeira, FBL (@PhyloPic)", 
                      color = "gray", size = 15, 
                      location = "10+50", gravity = "southeast")
# And bring in a logo
logo_raw <- image_read("http://www.phylopic.org/assets/images/submissions/99d6140b-d113-4814-82fb-05629d7d626c.512.png") 
out<-image_composite(plot3,image_scale(logo_raw,"x100"), gravity="north", offset = "+220+90")

image_browse(out)

# And overwrite the plot without a logo
image_write(out, "livestock_predation2.png")
