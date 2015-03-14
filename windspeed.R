

# Set your path!
mainDir <- setwd("C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/")
subDir1 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/"
subDir2 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/SMHI weather/"

# Read data
df <- read.csv2(paste(subDir2,"SMHI_weatherstations.csv",sep=""),stringsAsFactors=F)
df <- load

# Process data
df$Region <- as.factor(df$Region)
li <- split(df, df$Region)

# Compute mean and standard deviations per region
outputdf <- data.frame(Region = sort(unique(df$Region)), mean=rep(0,21), std=rep(0,21))

for (i in 1:21){
        stationNumber <- as.character(li[[i]]$Stationsnummer)
        curroutputdf <- data.frame(stationNumber)
        subDir3 <- names(li[i])
        for (j in 1:length(stationNumber)){
                URL <- paste("http://opendata-download-metobs.smhi.se/api/version/latest/parameter/4/station/",stationNumber[j],"/period/corrected-archive/data.csv",sep="")
                dir.create(file.path(subDir2,subDir3))
                destfile <- paste(subDir2,subDir3,"/", stationNumber[j], ".csv", sep="")
                if(!file.exists(destfile)){ 
                        download.file(URL,destfile) # Download the file if it doesnt exist
                }
                        
                currdf <- read.csv2(file=destfile, stringsAsFactors = F, skip = grep(pattern="Datum",readLines(destfile))-1)
                currdf$Vindhastighet <- as.numeric(currdf$Vindhastighet)
                        
                curroutputdf$mean[j] <- mean(currdf$Vindhastighet, na.rm = T)
                curroutputdf$std[j] <- sd(currdf$Vindhastighet, na.rm = T)
                
                }
        outputdf$mean[i] <- mean(curroutputdf$mean, na.rm = T)
        outputdf$std[i] <- mean(curroutputdf$std, na.rm = T)
}

# Normalized mean and standard deviations
outputdf$normalized.mean <- (outputdf$mean-min(outputdf$mean))/(max(outputdf$mean)-min(outputdf$mean))
outputdf$normalized.std <- (outputdf$std-min(outputdf$std))/(max(outputdf$std)-min(outputdf$std))


# Save data frame
windspeeddf <- outputdf
save(windspeeddf, file=paste(subDir1,"windspeed.Rda",sep=""))
