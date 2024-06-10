# This is a Shiny web app is the supplement of the X journal paper.
# Rpub hosts this web app:


#______________________________________________________________________
########## Load Packages ###########
rm(list = ls()); # clear global environment
graphics.off() # close all graphics
gc()
# local address for saving
if(Sys.info()[1]=="Windows"){loc_add<-c("C:/Projects/research/WebApp/")}

source(paste0(loc_add,"Functions.R"))
lib_load()

#________________________________________________________________________


################ Creating the User Interface for the App #################
ui <- dashboardPage( skin="red",
  # App header and its Contents Including the Help Menu
  dashboardHeader(title = "House Price Estimator",
                  dropdownMenu(# Produces ? Icon on Right + its contents
                    type = "notifications", 
                    icon = icon("question-circle"),
                    badgeStatus = NULL,
                    headerText = "See also:",
                    notificationItem("Data Dictionary", icon = icon("file"),
                                     href = "https://www.zillow.com"),
                    notificationItem("Request house Data", icon = icon("file"),
                                     href = "rapidapi.com")
                  )),
  
  # App Pages as shown on the SideBar
  dashboardSidebar(sidebarMenu(
        menuItem(HTML("<font size = \"5px\">  Home </font>"), tabName = "home", icon = icon("home")),
        menuItem(HTML("<font size = \"5px\">  Manual Entry </font>"), tabName = "manual", icon = icon("hand")),
        menuItem(HTML("<font size = \"5px\">  Table Entry </font>"), tabName = "table", icon = icon("table")),
        menuItem(HTML("<font size = \"5px\">  Source Codes </font>"), tabName = "codes", icon = icon("laptop-code")),
        menuItem(HTML("<font size = \"5px\">  About Us </font>"), tabName = "about_us", icon = icon("users")),
        tags$img(src = "https://github.com/marketmove/houseapp/blob/main/clark_logo.png?raw=true", 
                 height = "180px", width = "150px", style = "display: block; margin-left: auto; margin-right: auto; padding-top: 30px;")
  )
  ),
  
  # Contents of Each Page
  dashboardBody(
    tabItems(
      
      # Home Page Contents Using the ShinyLP Boostrapping Functionality
      tabItem(tabName = "home",
              jumbotron(
                HTML("<h2> <b>Introduction </b></h2>"), 
                        HTML("<p class = \"app\">  This interactive app provides users with data-driven insights into house price predictions.
                        The prediction is based on the publically available section of MLS data and govermental data. 
                        The details of the model development are explained in our  
                        <i> submitted </i> manuscript.
                        The app supports two formats of data entry:
                        <br>
                              <br> <b> (1) Manual Entry</b>, where 
                              users enter numerical data of only one house.
                             <br> <b>  (2) Table Entry</b>, where users can upload a tabe file that includes  multiple house information.  
                             <br><br>Besides, informations about the research team and the source codes are provided in the last two tabs. </p>
                              </p>"),
                        buttonLabel = "Click here for a tutorial Video"),
              fluidRow(
                column(4, panel_div(class_type = "primary", 
                                    panel_title = "About the App", 
                                    content = HTML("<b> Version: </b> 1.0.0.
                                                   <br> <b> Last Updated at </b> June 6, 2024</br>
                                                   <b> Author: </b> unanimous
                                                   <br> <b> Status: </b> Running"))),
                column(4, panel_div(class_type = "primary", 
                                    panel_title = "Contact Info:",
                                    content = HTML("This application is maintained by: 
                                         <br> <a href='mailto:unanimous@noname.edu?Subject=House%Prediction%20Help' target='_top'>unanimous </a></br>
                                         <p>
                                         <br></br>"))),
                column(4, panel_div(class_type = "primary", 
                                    panel_title = "Copyrights", 
                                    content = HTML("<p> <b> Data: </b> is available from 
                                                   <a href=\"https://data.gov/\">data.gov</a>  &  <a href=\"https://rapidapi.com/\">rapidapi.com</a>. </p> 
                                                   <p> <img height = \" 28\", src=\" http://i.creativecommons.org/p/zero/1.0/88x31.png\"> </img>
                                                                 <style=\"text-align:justify\"> 
                                                   <p> CC0 - 'No Rights Reserved'
                                                   </br>")
                )
                ),
                # Button Functionality
                bsModal("modalExample", "Video Tutorial", "tabBut", size = "large" ,
                        HTML("<p> By watching this video you can learn how to utilize this web app for bitcoin price prediction
                              </p>"),
                        iframe(width = "560", height = "315", url_link = "https://www.youtube.com/embed/0fKg7e37bQE")
                )
              )
      ),
      
      # Manual Data Entry Tab
      {
      tabItem(tabName = "manual",
              fluidRow(
                column(4,
                       sidebarLayout(
                         sidebarPanel(width = 1000, id="sidebar",
                                      HTML("<p.h> <b> <font size=\"4px\"> House Information  </font> </b> </p>"),
                                      numericInput(inputId="DJI.Low", label="No. of rooms", value = "", min = 25000, max = 50000),
                                      numericInput(inputId="DJI.Adjusted", label="lot_size", value = "", min = 25000, max = 50000),
                                      numericInput(inputId="oil_Close", label="square feet", value = "", min = -30, max = 500),
                                      numericInput(inputId="gold_Low", label="build year", value = "", min = 2, max = 100),
                                      numericInput(inputId="dollar2euro_close_ema5_diff", label="no. of bed", value = "", min = 0, max = 3000),
                                      numericInput(inputId="BTC_USD_close_rsi_diff", label="no. of bathroom", value = "", min = 10, max = 45),
                                      numericInput(inputId="gold_Low", label="good school", value = "", min = 2, max = 100),
                                      numericInput(inputId="dollar2euro_close_ema5_diff", label="garage", value = "", min = 0, max = 3000),
                                      numericInput(inputId="BTC_USD_close_rsi_diff", label="distance to the station", value = "", min = 10, max = 45),
                                      numericInput(inputId="BTC_USD_close_rsi_move", label="has basement", value = "", min = 0, max = 200)
                         ),
                         mainPanel( width = 0)
                       )
                )
      )
      )},
      
      # Tabular Data Entry Tab
      {tabItem(tabName = "table",
              fluidRow(
                column(12,
                       sidebarLayout(
                         sidebarPanel(width = 12, id="sidebar",
                                      fileInput('file1', HTML('<h3> Upload a CSV file: </h3>'),
                                                accept = c(
                                                  'text/csv',
                                                  'text/comma-separated-values',
                                                  '.csv'
                                                )
                                      ),
                                      HTML("<h4> To find a template file that contains the data required for the prediction,  
                                           click <a href=\"https://github.com/marketmove/houseapp/blob/main/template.csv\"> here. </a> 
                                           The operator need to enter data of house characteristics. If the operator does not
                                           have some of the house data leave them empty, the tool will extrapolate those dates.</h4>")
                         ),
                         mainPanel( width = 0)
                       )
                )))},
      tabItem(tabName = "codes",
              h2("Source Codes:", align = "left"),
              div(),
              div(style="clear: left;",p(class = "app","The source codes of this tool and the relevant study is provided in
                                         this address: https://github.com/marketmove/houseapp "))),
              
      tabItem(tabName = "about_us",
              div(),
              div(style="clear: left;",
                  p(style="float: left;",
                    img(src="https://github.com/marketmove/houseapp/blob/main/pic1.jpg?raw=true", 
                        height="120", width="120", border="0px", hspace="20 ")),
                  p(class = "app","Sitikantha Parida is currently an Associate Professor in the School of Business at Clark University. He received his Ph.D. in Finance
                   from London School of Economics.His research interests include empirical asset pricing, mutual funds, strategic trading, and financial regulations.")
              ),
              div(),
              div(style="clear: left;",
                  p(style="float: left;",
                    img(src="https://github.com/marketmove/houseapp/blob/main/pic2.jpeg?raw=true", 
                        height="120", width="120", border="0px", hspace="20 ")),
                  p(class = "app","Hamidreza Ahady Dolatsara is currently an Assistant Professor in the School of Business at Clark University. He received his Ph.D. in Industrial
                   & Systems Engineering at Auburn University.He is a data scientist with research interests in health care analytics, finance. Using data-driven studies, he employs and improves state-of-the-art, machine learning-based approaches to developing decision-support systems.")
              )
      )
      
      
      
      
    )
    
    # For Tab Items
  )
  # For Dashboard Body
) # For Dashboard Page

server <- function(input, output) {
  output$contents <- renderTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header = input$header,
             sep = input$sep, quote = input$quote)
  })
  
}

# Run the application
shinyApp(ui, server)
