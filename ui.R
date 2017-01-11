source("C:/Users/juan_/Downloads/Scripts/Utilities/graphics/R/metri_graphics.R")


shinyUI(fluidPage(
  headerPanel("Metrigraphics"),
  sidebarPanel(
    #Selector for file upload
    fileInput('datafile', 'Choose CSV file',
              accept=c('text/csv', 'text/comma-separated-values','text/plain', ".csv", ".txt")),
    #These column selectors are dynamically created when the file is loaded
    uiOutput("func"),
    #Bars
    uiOutput("fromCol"),
    uiOutput("toCol"),
    #Tails
    uiOutput("subdata"),
    #Bubble Chart
    uiOutput("Ejex"),
    uiOutput("Ejey"),
    uiOutput("Radio"),
    uiOutput("Texto"),
    #Path Graph
    uiOutput("Path"),
    #Treemap
    uiOutput("size"),
    uiOutput("group"),
    #Bullet Graph
    uiOutput("tit"),
    uiOutput("value"),
    uiOutput("marker"),
    uiOutput("opt_range"),
    uiOutput("range"),
    uiOutput("n_range"),
    #Common Variables
    uiOutput("Title"),
    uiOutput("moreoptions"),
    conditionalPanel(
      condition="input.moreoptions==true",
      #Bars
      uiOutput("min"),
      uiOutput("horit"),
      uiOutput("perc"),
      uiOutput("prop"),
      #Common Variables
      uiOutput("xlab"),
      uiOutput("ylab"),
      #Treemap
      uiOutput("size.labels")
    ),  
  
    actionButton("plotear", "Plot")
    
  ),
  mainPanel(
    #img(src = "C:/Users/juan_/Downloads/Scripts/Shiny/project metrigraphics/metrishiny/www/logo.png", height = 50, width = 100),
    headerPanel("Archivo"),
    tableOutput("filetable"),
    headerPanel("Plot"),
    plotOutput("plot", width = "980px", height = "980px")
    #plotOutput("metribar1", width = "540px", height = "380px")
    
  )
))