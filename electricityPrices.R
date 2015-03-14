
# Set your path!
mainDir <- setwd("C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/")
subDir1 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/"
subDir2 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/"


#Columms Year 2012.2014
#Row Price Area (SE1 to SE4)
data <- c(285.98,	285.98,	287.79,	290.45, 338.51,	338.51,	
          340.77,	345.02, 276.67,	277.21,	281.94,	298.47) #the annual average prices per price area

priceData <- matrix(data, nrow = 4, ncol = 3) #kon
colnames(priceData) <- c("2014", "2013","2012")
rownames(priceData) <- c("SE1", "SE2","SE3", "SE4")

avePrice <- rowMeans(priceData)

provinces <- c("Blekinge","Dalarna","Gotland","Gavleborg",
               "Halland","Jamtland","Jonkoping","Kalmar",
               "Kronoberg","Norrbotten","Skane","Stockholm",
               "Sodermanland","Uppsala","Varmland","Vasterbotten",
               "Vasternorrland","Vastmanland","Vastra Gotaland",
               "Orebro","Ostergotland")

dfPrice <- data.frame("Region" = provinces, "Elprice" = rep(NA,length(provinces)))

#Sort price with respect to province and price area (Source: https://www.compricer.se/el/omraden/)
#Provinces in SE1

dfPrice$Elprice[dfPrice$Region == "Norrbotten" | dfPrice$Region == "Vasterbotten"] <- avePrice[1]

dfPrice$Elprice[dfPrice$Region == "Jamtland" | dfPrice$Region == "Vasternorrland" |
                  dfPrice$Region == "Dalarna" | dfPrice$Region == "Gavleborg" |
                  dfPrice$Region == "Vasterbotten"] <- avePrice[2]

dfPrice$Elprice[dfPrice$Region == "Gotland" | dfPrice$Region == "Stockholm" |
                  dfPrice$Region == "Sodermanland" | dfPrice$Region == "Uppsala" |
                  dfPrice$Region == "Varmland" | dfPrice$Region == "Vastmanland" |
                  dfPrice$Region == "Orebro" | dfPrice$Region == "Ostergotland" |
                  dfPrice$Region == "Jonkoping" | dfPrice$Region == "Kalmar" | dfPrice$Region == "Vastra Gotaland" |
                  dfPrice$Region == "Gavleborg " | dfPrice$Region == "Dalarna"] <- avePrice[3]

dfPrice$Elprice[dfPrice$Region == "Skane" | dfPrice$Region == "Blekinge" | 
                  dfPrice$Region == "Halland" |  dfPrice$Region == "Kronoberg"] <- avePrice[4]

# Normalized mean and standard deviations
dfPrice$normalized.Elprice <- (dfPrice$Elprice-min(dfPrice$Elprice))/(max(dfPrice$Elprice)-min(dfPrice$Elprice))

# Save data frame
save(dfPrice, file=paste(subDir1,"elecprice.Rda",sep=""))


