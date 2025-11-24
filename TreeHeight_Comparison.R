#Calling data

setwd("C:/jigme/20240423_Tree_comparisons")

dir()

treeData<- read.csv("Trees_heights_data.csv")

dev.new(width=8, height=4, unit="in")
par(mfrow = c(1,2))

#
#--------plot observed tree heights vs CHM--------
plot( treeData$CHM ~ treeData$TreeHeights, main = "Tree heights vs CHM", xlab = "Height (m)", ylab = "CHM (m)")
abline(lm(CHM~TreeHeights, data = treeData), col='steelblue')

#--------plot AGB vs CHM--------
plot( treeData$AGB ~ treeData$CHM, main = "AGB vs CHM", xlab = "CHM", ylab = "AGB (kg)")
abline(lm(AGB ~ CHM, data = treeData), col='steelblue')


#Calculate correlation and p-value
#CHM vs TRee heights
cor.test(treeData$CHM, treeData$TreeHeights)

#CHM vs AGB
cor.test(treeData$CHM, treeData$AGB)

#Calling data from 7m by 7m grid
trees7m<- read.csv("Trees_CHM_max_from_7m_grid.csv")

dev.new(width=6, height=6, unit="in")
par(mfrow = c(1,1))

plot(trees7m$CHM_max, trees7m$TreeHeights, main = "Tree Heights vs CHM Max in 7m by 7m grid", xlab = "CHM Max (m)", ylab = "Tree Heights (m)")
abline(lm(TreeHeights ~ CHM_max, data = trees7m), col='steelblue')

#Correlation and PValues
cor.test(trees7m$TreeHeights, trees7m$CHM_max)





