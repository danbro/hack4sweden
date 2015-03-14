require(googleVis)
require(shiny)

# set your path!
Dir <- setwd("C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe")
subDir1 <- "C:/Users/danbro/Dropbox/Hack4Sweden/R scripts/hack4swe/data files/"

# Load data frame
load(paste(subDir1,"finaldf.Rda",sep=""))

# Set NAs to mean of observations
df[9,3] <- mean(df[,3],na.rm=TRUE)
df[9,4] <- mean(df[,4],na.rm=TRUE)
df[16,4] <- mean(df[,4],na.rm=TRUE)
df[20,4] <- mean(df[,4],na.rm=TRUE)

shinyServer(
        function(input, output, session) {
                # Score
                score <- reactive({
                        round(input$var1*df[,2] + input$var2*df[,3] +
                                      input$var2*df[,3] + input$var3*df[,4] + 
                                      input$var4*df[,5] + input$var5*df[,6], 1)
                })
                
                # Top/Bottom 3 regions
                sortedtopScore <- reactive({sort(score(),decreasing=TRUE)})
                sortedbottomScore <- reactive({sort(score(),decreasing=FALSE)})
                top1 <- reactive({df[order(score(),decreasing=TRUE),1][1]})
                top2 <- reactive({df[order(score(),decreasing=TRUE),1][2]})
                top3 <- reactive({df[order(score(),decreasing=TRUE),1][3]})
                bottom1 <- reactive({df[order(score(),decreasing=FALSE),1][1]})
                bottom2 <- reactive({df[order(score(),decreasing=FALSE),1][2]})
                bottom3 <- reactive({df[order(score(),decreasing=FALSE),1][3]})
                output$top1 <- renderText(paste("1. ",top1(),sep=""))
                output$top2 <- renderText(paste("2. ",top2(),sep=""))
                output$top3 <- renderText(paste("3. ",top3(),sep=""))
                output$bottom1 <- renderText(paste("1. ",bottom1(),sep=""))
                output$bottom2 <- renderText(paste("2. ",bottom2(),sep=""))
                output$bottom3 <- renderText(paste("3. ",bottom3(),sep=""))                

                # Produce chart
                output$gvis <- 
                        renderGvis({
                                df$Score <- score()
                                gvisGeoChart(data=df, locationvar = "Region",
                                             colorvar = "Score", hovervar = ,
                                             options = list(region="SE", displayMode="regions",
                                                            resolution="provinces",
                                                            backgroundColor="2049a1",
                                                            colors = "['#e74c3c', '#f1c40f', '#27ae60']",
                                                            width=900, height=556))
                        })
        }     
)