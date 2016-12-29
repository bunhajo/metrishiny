source("C:/Users/Tornero/Documents/R/Work/metrishiny/metri_graphics.R")
func_options=c("Barras Simples", "Barras Borde")
plotfunc = function(input, output, filedata){

    output$plot =  renderPlot({
      df <-filedata()
      if (is.null(df) | input$plotear == 0) return(NULL)
      if(input$func=="Barras Borde"){
      metri_bar1(df[1:15,],x=input$from,y=input$to, suffix = ifelse(input$perc==1,"%",""),
            title = input$Title, xlab = input$xlab, ylab = input$ylab)
      }
      if(input$func=="Barras Simples"){
      metri_bar(df[1:9,],x=input$from,y=input$to,
                title = input$Title, horit = ifelse(!is.null(input$horit), input$horit, TRUE), min = ifelse(!is.null(input$min), input$min, 20), perc = input$perc,
                xlab = input$xlab, ylab = input$ylab)  
      }
  })
}



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
  output$func <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    selectInput("func", "Funciones:",func_options)
    
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
    if (input$func!="Barras Simples") return(NULL)
    numericInput("min", "Minimo", value="80")
  })
  
  output$horit <- renderUI({
    if (input$func!="Barras Simples") return(NULL)
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
  
  output$plot = plotfunc(input, output, filedata)
  })  
  
  