# Set your path!
mainDir <- setwd("C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/")
subDir1 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/"
subDir2 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/SCB energy/"

library("xlsx")
prodData <- read.xlsx(paste(subDir2,"energiProdData.xlsx",sep=""),1)
lastData <- read.xlsx(paste(subDir2,"energiLastData.xlsx",sep=""),1)

#Produktionsdata
#Munging data
prodData <- prodData[,-c(3)]

colnames(prodData) <- c("Lan", "Kraftverktyp", "Y09","Y10","Y11","Y12","Y13")
head(prodData)
 
regionArray <- c("Stockholm", "Uppsala", "Södermanland", "Östergötland", "Jönköping", "Kronoberg", "Kalmar",
                 "Gotland", "Blekinge", "Skåne", "Halland", "Västra Götaland","Värmland", "Örebro",
                 "Västmanland", "Dalarna", "Gävleborg", "Västernorrland", "Jämtland", "Västerbotten", "Norrbotten")

kraftverkArray <-c("Kraftvärmeverk", "Övrig värmeverk", "Vattenkraft", "Vindkraft", "Summa")
n <- length(regionArray)

regTemp <- rep(NA, n = length(prodData[,1]))
kraftTemp <- rep(NA, n = length(prodData[,1]))

for (i in seq(1, length(regionArray))) {
  
  regTemp[(5*(i-1)+1):(5*i)] <- regionArray[i]
  kraftTemp[(5*(i-1)+1):(5*i)] <- kraftverkArray
  
}

prodData[,1] <- regTemp
prodData[,2] <- kraftTemp

#gör om variabler till faktor resp numeriska typer
prodData$Lan <- as.factor(prodData$Lan)
prodData$Kraftverktyp <- as.factor(prodData$Kraftverktyp)
prodData$Y09 <- as.numeric(as.character(prodData$Y09))
prodData$Y10 <- as.numeric(as.character(prodData$Y10))
prodData$Y11 <- as.numeric(as.character(prodData$Y11))
prodData$Y12 <- as.numeric(as.character(prodData$Y12))
prodData$Y13 <- as.numeric(as.character(prodData$Y13))

str(prodData)

tempSum <- as.matrix((prodData[which(prodData$Kraftverktyp=="Summa"),c(6,7)]))
#tempVatten<- as.matrix((prodData[which(prodData$Kraftverktyp=="Vattenkraft"),c(3,4,5,6,7)]))
tempVind <- as.matrix((prodData[which(prodData$Kraftverktyp=="Vindkraft"),c(6,7)]))

aveValSum <- rep(NA,n)
aveValVatten <- rep(NA,n)
aveValVind <- rep(NA,n)


for (i in seq(1,n)) {
  aveValSum[i] <- mean(na.omit(tempSum[i,]))
  #aveValVatten[i] <- mean(na.omit(tempVatten[i,]))
  aveValVind[i] <- mean(na.omit(tempVind[i,]))
}
  
aveValSum[which(aveValSum == "NaN")] <- NA
aveValVind[which(aveValVind == "NaN")] <- NA
#aveRenew <- aveValVatten+aveValVind

ratioRenw <- aveValVind/aveValSum


#Lastdata munging

lastData <- lastData[, -c(2,3)]
colnames(lastData) <- c("Lan", "Y09","Y10","Y11","Y12","Y13")

lastData[,1] <- regionArray
lastData$Y09 <- as.numeric(as.character(lastData$Y09))
lastData$Y10 <- as.numeric(as.character(lastData$Y10))
lastData$Y11 <- as.numeric(as.character(lastData$Y11))
lastData$Y12 <- as.numeric(as.character(lastData$Y12))
lastData$Y13 <- as.numeric(as.character(lastData$Y13))

str(lastData)
aveLast <- rep(NA,n)

for (i in seq(1,n)) {
  aveLast[i] <- mean(na.omit(as.numeric(lastData[i,-1])))
}

#Kombinera till ett dataset
energyDF <- data.frame("Lan" = regionArray, "WindRatio" = ratioRenw, 
                            "TotSupply" = aveValSum, "TotDemand" = aveLast, "Net" = aveLast-aveValSum)


names(energyDF)[1] <- "Region"
energyDF <- energyDF[order(energyDF$Region),]


# Normalized mean and standard deviations
energyDF$normalized.Net <- (energyDF$Net-min(energyDF$Net,na.rm=T))/(max(energyDF$Net,na.rm=T)-min(energyDF$Net,na.rm=T))
energyDF$normalized.WindRatio <- 1-(energyDF$WindRatio-min(energyDF$WindRatio,na.rm=T))/(max(energyDF$WindRatio,na.rm=T)-min(energyDF$WindRatio,na.rm=T))


# Save data frame
save(energyDF, file=paste(subDir1,"energyDF.Rda",sep=""))
