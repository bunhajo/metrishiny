source("C:/Users/juan_/Downloads/Scripts/Utilities/graphics/R/metri_graphics.R")


shinyUI(fluidPage(
  headerPanel("Metrigraphics"),
  sidebarPanel(
    #Selector for file upload
    fileInput('datafile', 'Choose CSV file',
              accept=c('text/csv', 'text/comma-separated-values','text/plain', ".csv", ".txt")),
    #These column selectors are dynamically created when the file is loaded
    uiOutput("func"),
    uiOutput("fromCol"),
    uiOutput("toCol"),
    uiOutput("subdata"),
    uiOutput("Ejex"),
    uiOutput("Ejey"),
    uiOutput("Radio"),
    uiOutput("Texto"),
    uiOutput("Path"),
    uiOutput("size"),
    uiOutput("group"),
    uiOutput("Title"),
    uiOutput("moreoptions"),
    conditionalPanel(
      condition="input.moreoptions==true",
      uiOutput("min"),
      uiOutput("horit"),
      uiOutput("perc"),
      uiOutput("xlab"),
      uiOutput("ylab"),
      uiOutput("prop")
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