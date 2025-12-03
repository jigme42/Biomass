setwd("C:/Users/PC/Desktop/s2indices")
getwd()
dir()
#activate libraries
library(raster)
library(terra)
library(sf)
library(dplyr)
library(exactextractr)

#import
bsi<-raster("Nathan_bsi_2023.tif")
evi<-raster("Nathan_evi_2023.tif")
lai<-raster("Nathan_lai_2023.tif")
mndwi<-raster("Nathan_mndwi_2023.tif")
ndre<-raster("Nathan_ndre_2023.tif")
ndvi<-raster("Nathan_ndvi_2023.tif")
transect<-st_read("transects.shp")

plot(st_geometry(transect))

#check for empty geometry
st_is_empty(transect) 

#zonal statistics
#BSI
trans_bsi<-as.data.frame(cbind(transect,
                                 exact_extract(bsi,transect,
                                               c("max","mean","min","median"))))
st_write(trans_bsi,"bsi.csv")                               

#EVI
trans_evi<-as.data.frame(cbind(transect,
                               exact_extract(evi,transect,
                                             c("max","mean","min","median"))))
st_write(trans_evi,"evi.csv")  

#LAI
trans_lai<-as.data.frame(cbind(transect,
                               exact_extract(lai,transect,
                                             c("max","mean","min","median"))))
st_write(trans_lai,"lai.csv") 

#MNDWI
trans_mndwi<-as.data.frame(cbind(transect,
                               exact_extract(mndwi,transect,
                                             c("max","mean","min","median"))))
st_write(trans_mndwi,"mndwi.csv") 

#NDRE
trans_ndre<-as.data.frame(cbind(transect,
                               exact_extract(ndre,transect,
                                             c("max","mean","min","median"))))
st_write(trans_ndre,"ndre.csv") 

#NDVI
trans_ndvi<-as.data.frame(cbind(transect,
                               exact_extract(ndvi,transect,
                                             c("max","mean","min","median"))))
st_write(trans_ndvi,"ndvi.csv") 


# Select columns for correlation analysis
#bsi
bsi_col<-subset(trans_bsi,select=c('AGB','mean', 'min', 'median', 'max')) 

bsi_cor<-cor(bsi_col[,colnames(bsi_col)!="AGB"],
             bsi_col$AGB)
bsi_cor<-as.data.frame(bsi_cor)

#evi
evi_col<-subset(trans_evi,select=c('AGB','mean', 'min', 'median', 'max')) 

evi_cor<-cor(evi_col[,colnames(evi_col)!="AGB"],
             evi_col$AGB)
evi_cor<-as.data.frame(evi_cor)

#ndvi
ndvi_col<-subset(trans_ndvi,select=c('AGB','mean', 'min', 'median', 'max')) 

ndvi_cor<-cor(ndvi_col[,colnames(ndvi_col)!="AGB"],
             ndvi_col$AGB)
ndvi_cor<-as.data.frame(ndvi_cor)

#lai
lai_col<-subset(trans_lai,select=c('AGB','mean', 'min', 'median', 'max')) 

lai_cor<-cor(lai_col[,colnames(lai_col)!="AGB"],
             lai_col$AGB)
lai_cor<-as.data.frame(lai_cor)

#mndwi
mndwi_col<-subset(trans_mndwi,select=c('AGB','mean', 'min', 'median', 'max')) 

mndwi_cor<-cor(mndwi_col[,colnames(mndwi_col)!="AGB"],
            mndwi_col$AGB)
mndwi_cor<-as.data.frame(mndwi_cor)

#ndre
ndre_col<-subset(trans_ndre,select=c('AGB','mean', 'min', 'median', 'max')) 

ndre_cor<-cor(ndre_col[,colnames(ndre_col)!="AGB"],
             ndre_col$AGB)
ndre_cor<-as.data.frame(ndre_cor)
# Transpose each data frame
ndvi_transposed <- as.data.frame(t(ndvi_cor))
rownames(ndvi_transposed)<-"NDVI"
evi_transposed <- as.data.frame(t(evi_cor))
rownames(evi_transposed)<-"EVI"
lai_transposed <- as.data.frame(t(lai_cor))
rownames(lai_transposed)<-"LAI"
ndre_transposed <- as.data.frame(t(ndre_cor))
rownames(ndre_transposed)<-"NDRE"
mndwi_transposed <- as.data.frame(t(mndwi_cor))
rownames(mndwi_transposed)<-"MNDWI"
bsi_transposed <- as.data.frame(t(bsi_cor))
rownames(bsi_transposed)<-"BSI"
# Combine the transposed data frames into one
combined <- rbind(ndvi_transposed, evi_transposed, 
                  lai_transposed, ndre_transposed,
                  mndwi_transposed,bsi_transposed)
write.csv(combined,"correlation.csv")

