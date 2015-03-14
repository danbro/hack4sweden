library(shiny)
library(shinythemes)

shinyUI(navbarPage(title="Comparing the Regional Wind Power Potential in Sweden", theme = shinytheme("cerulean"),
                   tabPanel(title="Chart",
                            sidebarLayout(
                                    sidebarPanel(
                                            h4("Where is the potential for new wind power?"),
                                            "The answer to this question may vary depending on who you ask
                                            as it often depends on the variables considered and how they are weighted against each other.",
                                            br(),
                                            br(),
                                            "This application let's you tweak the weights of five variables where 0 correspond to no weight, 0.5 to moderate weight and 1 to full weight. 
                                            The variables chosen in this application are common criterias when determining wind power potential. You can think of the weights as the importance of the variable.
                                            Tuning the weights updates the chart with traffic light colors: red, yellow and, green. Green indicates high potential, yellow moderate potential and red low potential for new wind power.
                                            The top and bottom three regions are displayed belwo the chart.",                           
                                            br(),
                                            br(),
                                            "Give it a try! Start by tuning a single variable and interpret the outcome!",
                                            tags$hr(),
                                            sliderInput("var1","Wind speed",value=0,min=0,max=1,step=0.5),
                                            sliderInput("var5","Unexploited areas",value=0,min=0,max=1,step=0.5),
                                            sliderInput("var4","Electricity price",value=0,min=0,max=1,step=0.5),
                                            sliderInput("var2","Electricity import*",value=0,min=0,max=1,step=0.5),
                                            sliderInput("var3","Low establishment of wind power**",value=0,min=0,max=1,step=0.5),
                                            tags$em("*The assumption made is that regions with high electricity import are not self-sufficient and are more likely to benefit from new wind power"),
                                            br(),
                                            br(),
                                            tags$em("**The assumption made is that regions with high wind power establishement are more likely to have limited hosting capacity")
                                            ),
                                    mainPanel(
                                            fluidRow(
                                                    column(12,
                                                           htmlOutput("gvis"),
                                                           br(),
                                                           tags$em("Green = High potential; Yellow = Moderate potential; Red = Poor potential"),
                                                           tags$hr()
                                                           )
                                                    
                                                    ),
                                            fluidRow(
                                                    column(6,
                                                           h4("Top 3 Regions:"),
                                                           verbatimTextOutput("top1"),
                                                           verbatimTextOutput("top2"),
                                                           verbatimTextOutput("top3")
                                                           ),
                                                    column(6,
                                                           h4("Bottom 3 Regions:"),
                                                           verbatimTextOutput("bottom1"),
                                                           verbatimTextOutput("bottom2"),
                                                           verbatimTextOutput("bottom3")
                                                    )
                                                    )
                                            )
                                    )
                            ),
                   tabPanel(title="FAQ",
                            sidebarLayout(
                                    sidebarPanel(
                                            h3("Data sources"),
                                            h4("Government Agencies:"),
                                            "Sveriges Meteorologiska och Hydrologiska Institut (SMHI)",
                                            br(),
                                            "Statistiska Centralbyran (SCB)",
                                            br(),
                                            "Nord Pool Spot",
                                            br(),
                                            br(),
                                            h4("Links to data:"),
                                            tags$a(href="http://opendata-download-metobs.smhi.se/explore/?parameter=2#", "Weather station observations"),
                                            br(),
                                            tags$a(href="http://www.nordpoolspot.com/Market-data1/Elspot/Area-Prices/SE/Yearly/?view=table", "Elspot prices"),
                                            br(),
                                            tags$a(href="http://www.scb.se/EN0203/?tab=dokumentation#", "SCB electricity supply and consumption"),
                                            br(),
                                            tags$a(href="http://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__MI__MI0803__MI0803C/MarkanvFornl/?rxid=7c70c844-b6ff-4237-b34a-8314eed5a736", "Ancient sites and monuments"),
                                            br(),
                                            tags$a(href="http://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__MI__MI0803__MI0803B/MarkanvByggnadLnKn/?rxid=7048490e-11b3-417b-955e-fc2e3d3d403a", "Ground space area of buildings"),
                                            br(),
                                            tags$a(href="http://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__MI__MI0603/Skyddadnatur/?rxid=7c70c844-b6ff-4237-b34a-8314eed5a736", "Protected nature"),
                                            br(),
                                            tags$a(href="http://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__MI__MI0802/Areal2012/?rxid=d4e0182d-848e-45b1-847d-609bb0de4287", "Inland water"),
                                            br(),
                                            br(),
                                            "Get the R code for this application on",
                                            tags$a(href="http://github.com/danbro", "github")
                                
                                    ),
                                    mainPanel(
                                            fluidRow(
                                                    column(12,
                                                           h3("Where did you get the data?"),
                                                           "We collected open data from multiple governement agencies. Details and links are provided in the sidebar panel.",
                                                           h3("What programming language did you use?"),
                                                           "We used the open source programming language R to download and process the data. The user interface was also built through R using the shiny library.",
                                                           h3("How did you process the data?"),
                                                           h4("Wind speed data processing "),
                                                           "Wind speed data on intra-day resolution was collected from 204 active weather stations distributed in Sweden. The units are in meter per second.
                                                           The weather stations were first categorized by region, then average wind speeds were calculated for each station using several years of observations.
                                                           Finally, the station average wind speeds were averaged for each region."
                                                           )
                                                    ),
                                            fluidRow(
                                                    column(12,
                                                           h4("Area data processing"),
                                                           "The unexploited area per region was calculated as the ratio of inland water, ancient sites and monuments, buildings and protected areas by the total area per region. The units are expressed in squared kilometers."
                                                           )
                                                    ),
                                            fluidRow(
                                                    column(12,
                                                           h4("Energy supply and consumption data processing"),
                                                           "The data sets contain information about electricity supply and consumption per
                                                            region for the last five years. The units are in MWh. The supply data is divided with respect to energy source. 
                                                            The net supply is defined as the difference between the average supply and consumption for
                                                           each region. The units are in SEK/MWh. Further, the wind power share is the ratio between the wind energy supply
                                                           and the total supply per region.
                                                           "
                                                    )
                                                    
                                            ),
                                            fluidRow(
                                                    column(12,
                                                           h4("Electricity spot price data processing"),
                                                           "The data set contains information about the annual electricity spot prices per price area for 
                                                           the last three years. The price area data was averaged and sorted with respect to region."
                                                    )
                                                    
                                            ),

                                            fluidRow(
                                                    column(12,
                                                           h3("How did you calculate the potential for wind power?"),
                                                           "To calculate the potential for wind power we use a simple scoring system:",
                                                           br(),                                                           
                                                           "First, the processed data from all sources are merged into a single data frame containing 5 variables (wind speed, areas, price, import, establishment) and 21 observations (one for each region in Sweden). Then, the observations for each variable are normalized on a 0 to 1 scale, meaning 
                                                           that the region with the largest observation for a particular variable is assigned the value 1 while the smallest observation is assigned 0. All other regions are scored relative to those extremes. The scoring of each region can be expressed as:",
                                                           br(),
                                                           br(),
                                                           "y_i = beta_1 * x_1 + beta_2 * x_2 + beta_3 * x_3 + ... + beta_n * x_n",
                                                           br(),
                                                           br(),
                                                           "where y_i denotes the final score of region i {i=1,2,...,21}, which is a numeric value between 0 and 5. beta_n denotes the weighting coefficients for variable n, {n=1,2,..,5} which are set by the user.
                                                           x_n denotes the observation of region i for variable n."
                                                    )
                                            ),
                                            fluidRow(
                                                    column(12,
                                                           h3("How did you handle missing values?"),
                                                           "There were four missing values in the final data frame, two for Kronoberg, one for Uppsala and one for Vastmanland.
                                                           To account for this in the scoring system, the missing values were replaced by the mean of the observations for the affected variable."
                                                    )
                                            )
                                            
                                            )
                            )
                   ),
                   tabPanel("Contact",
                            sidebarLayout(
                                    sidebarPanel(
                                            h3("The PoweR Team"),
                                            h4("Daniel A. Broden (Team Captain)"),
                                            "Ph.D Candidate at the Royal Institute of Technology, Stockholm, Sweden",
                                            br(),
                                            "Email: danbro@kth.se",
                                            br(),
                                            "Link to",
                                            tags$a(href="https://www.kth.se/profile/danbro/", "profile page"), 
                                            h4("Claes Sandels"),
                                            "Ph.D Candidate at the Royal Institute of Technology, Stockholm, Sweden",
                                            br(),
                                            "Email: claes.sandels@ics.kth.se",
                                            br(),
                                            "Link to",
                                            tags$a(href="https://www.kth.se/profile/claesper/", "profile page"), 
                                            h4("Nicolae Doban"),
                                            "Master student at the Royal Institute of Technology, Stockholm Sweden",
                                            br(),
                                            "Email: doban@kth.se",
                                            br(),
                                            "Link to",
                                            tags$a(href="https://www.linkedin.com/in/nicolaedoban", "profile page") 
                                    ),
                                    mainPanel(
                                            img(src='teampic.png', align = "middle", keepAspectRatio=T, width=600)
                                    )
                            )
                   )
)
)