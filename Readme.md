# Geom for plotting ROC curve
Koundinya Desiraju  
5 July 2016  

This is a new geom created for plotting the ROC curves. Even though there are packages which can give pretty good ROC curve plots and comparisions, I have written this for two purposes:

1. Maintaining uniformity between all other graphs and ROC plot.
2. Benefit from all customizations that ggplot2 offers.




### Consider 3 cases, in which X3 is better than x2 and x2 is better than x1

```r
library(ggplot2)
library(pROC)
source("ROC_plot.R")
source("Theme_Publication.R")

x1 <- rnorm(50); x2 <- c(rnorm(25),rnorm(25,1,1)); x3 <- c(rnorm(25),rnorm(25,2,1))
y <- c(rep("A",25),rep("B",25))

R1 <- roc(y,x1); R2 <- roc(y,x2); R3 <- roc(y,x3)

dat1 <- data.frame(TruePositiveRate = R1$sensitivities, 
                   FalsePositiveRate = (1-R1$specificities), 
                   Model = rep("Model 1",length(R1$sensitivities)))
dat2 <- data.frame(TruePositiveRate = R2$sensitivities, 
                   FalsePositiveRate = (1-R2$specificities), 
                   Model = rep("Model 2",length(R2$sensitivities)))
dat3 <- data.frame(TruePositiveRate = R3$sensitivities, 
                   FalsePositiveRate = (1-R3$specificities), 
                   Model = rep("Model 3",length(R3$sensitivities)))

dat <- rbind(dat1,dat2,dat3)
```

## Comparision between all three ROC curves

I will be using my ggplot theme(the source code of which is also in this github repo) 


```r
ggplot(dat,aes(FalsePositiveRate,TruePositiveRate,colour = Model)) + geom_roc_plot()+
   scale_colour_Publication() + theme_Publication()+
   theme(panel.border = element_rect(colour = 'black'),legend.title = element_blank(),
         legend.position = c(0.9,0.15),legend.direction = 'vertical')
```

![](Readme_files/figure-html/unnamed-chunk-3-1.png)<!-- -->



