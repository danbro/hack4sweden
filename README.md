# hack4sweden2015
An application to determine the regional wind power potential in Sweden. 
This application was developped by Daniel A Brodén, Claes Sandels and Nicolae Doban for the Hack for Sweden competition in March 14-15, 2015.


In this repositories you will find all necessary R files to reproduce our application.

Folder descriptions:
- PresentationFigs (contain all figures used to create an R presentation)
- data files (contains subfolders with .csv files from different government agencies. Contains saved data frame outputs in .Rda format)
- www (contains the image to be uploaded on the application page)

R file descriptions:
- AreaUsage.R (process area usage data and outputs a data frame to the data files subfolder)
- electricityPrices.R (process electricity price data and outputs a data frame to the data files subfolder)
- dataProcessEnerSurplus.R (process energy data and outputs a data frame to the data files subfolder)
- windspeed.R (downloads data from 204 active weather stations, saves them in subdirectories in data file/SMHI weather. The downloaded data is processed and the script outputs a data frame to the data files subfolder)
- merge.R (loads all the save data frames from the data processing and outputs a final data frame that is saved to the data files subfolder)
- ui.R (user interface for the web application)
- server.R (loads the final data frame from the data files folder and controls the functionality of the web application)

R markdown files:
- PoweRpresentation.Rpres (code for the application web presentation)
- PoweRpresentation.md (markdown for the application web presentation)

Go to application:
https://danbro.shinyapps.io/windapp/



