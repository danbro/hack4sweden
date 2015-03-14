#Area Usage

#Population Density is in #inhabitants/km^2

#Set your path!
mainDir <- setwd("C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/")
subDir1 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/"
subDir2 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/Area Usage/"

#LandArea is in km^2
AreaUsage <- read.csv(paste(subDir2,"AreaUsage.csv",sep=""), header=T)

# Calculate the % of excluded area
AreaUsage$ExcludedArea <- (AreaUsage$Buildings+AreaUsage$WaterArea+AreaUsage$ProtectedArea+AreaUsage$Ancient)/AreaUsage$LandArea

# Normalize excluded area
AreaUsage$normalized.PotentialFreeArea <- 1-(AreaUsage$ExcludedArea-min(AreaUsage$ExcludedArea))/(max(AreaUsage$ExcludedArea)-min(AreaUsage$ExcludedArea))

# Save data frame
save(AreaUsage, file= paste(subDir1,"AreaUsage.Rda",sep=""))


