#Required Packages
library(spdep)
library(ggplot2)
library(sf)
library(sp)
library(ape)
library(tmap)
library(rgdal)

#Read shape file
tbhiv <- readOGR(dsn=".", layer ="tb_hiv_p_lga")

#Regions to exclude identified from neighbour file
regions<- c (33005, 33007)

#Create new shape file with excluded regions
tbhiv1 <- tbhiv[!(tbhiv$LGAID %in% regions), ]

summary(tbhiv1)

#create gal file
queen.R.nb = poly2nb(tbhiv1, row.names=tbhiv1$LGAID)


#Summary of queen file
summary(queen.R.nb)


#compute Moran I
moran(tbhiv1$geo_data_t,nb2listw(queen.R.nb), length(tbhiv1$geo_data_t), Szero(nb2listw(queen.R.nb)))

#compute Moran I statistic
moran.test(tbhiv1$geo_data_t,nb2listw(queen.R.nb))








