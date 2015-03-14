# Merge data frames into a single data frame

# Set your path!
mainDir <- setwd("C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/")
subDir1 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/"

# load data frames
load(paste(subDir1,"windspeed.Rda",sep=""))
load(paste(subDir1,"elecprice.Rda",sep=""))
load(paste(subDir1,"energyDF.Rda",sep=""))
load(paste(subDir1,"AreaUsage.Rda",sep=""))


# Change Region column to exclude å, ä, ö
Region <- dfPrice$Region
windspeeddf$Region <- Region
energyDF$Region <- Region
AreaUsage$Region <- Region

# Merge to a single data frame
df <- merge(windspeeddf, energyDF, by = "Region")
df <- merge(df, dfPrice, by = "Region")
df <- merge(df, AreaUsage, by = "Region")

# Keep selected variables
df <- df[,c(1,4,10,11,13,22)]

# Save data frame
save(df, file=paste(subDir1,"finaldf.Rda",sep=""))