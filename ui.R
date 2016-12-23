library(metrigraphics)

shinyUI(pageWithSidebar(
  headerPanel("Metrigraphics"),
  sidebarPanel(
    #Selector for file upload
    fileInput('datafile', 'Choose CSV file',
              accept=c('text/csv', 'text/comma-separated-values','text/plain', ".csv", ".txt")),
    #These column selectors are dynamically created when the file is loaded
    uiOutput("fromCol"),
    uiOutput("toCol"),
    uiOutput("Title"),
    uiOutput("moreoptions"),
    conditionalPanel(
      condition="input.moreoptions==true",
      uiOutput("min"),
      uiOutput("horit"),
      uiOutput("perc"),
      uiOutput("xlab"),
      uiOutput("ylab")
    ),  
  
    actionButton("plotear", "Plot")
    
  ),
  mainPanel(
    #img(src = "C:/Users/juan_/Downloads/Scripts/Shiny/project metrigraphics/metrishiny/www/logo.png", height = 50, width = 100),
    headerPanel("Archivo"),
    tableOutput("filetable"),
    headerPanel("Plot"),
    plotOutput("newplot", width = "720px", height = "720px")
  )
))