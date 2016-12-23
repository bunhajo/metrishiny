library(metrigraphics)


shinyServer(function(input, output) {
  
  #This function is repsonsible for loading in the selected file
  filedata <- reactive({
    infile <- input$datafile
    if (is.null(infile)) {
      # User has not uploaded a file yet
      return(NULL)
    }
    read.csv(infile$datapath)
  })
  
 
  #The following set of functions populate the column selectors
  output$toCol <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("to", "Valores:",items)
    
  })
  
  
  output$fromCol <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    items=names(df)
    names(items)=items
    selectInput("from", "Categorias:",items)
    
  })
  
  output$Title <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    textInput("Title", "Titulo", value="")
  })
  
  output$xlab <- renderUI({
    textInput("xlab", "Eje X", value="")
  })
  
  output$ylab <- renderUI({
    textInput("ylab", "Eje y", value="")
  })
  
  output$min <- renderUI({
    numericInput("min", "Minimo", value="80")
  })
  
  output$horit <- renderUI({
    checkboxInput ("horit", "Horizontal", TRUE)
  })
  
  output$perc <- renderUI({
    df <-filedata()
    checkboxInput ("perc", "Porcentage", TRUE)
  })
  
  output$filetable <- renderTable({
    head(filedata())
  })
  
  output$moreoptions <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    
    checkboxInput("moreoptions", "Mas opciones?", FALSE)
  })
  
  output$newplot = renderPlot({
    df <-filedata()
    if (is.null(df) | input$plotear == 0) return(NULL)
    metrigraphics::metri_bar(df[1:15,],x=input$from,y=input$to,
                             title = input$Title, horit = input$horit, min = input$min, perc = input$perc,
                             xlab = input$xlab, ylab = input$ylab)  
  })
})