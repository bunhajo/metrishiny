source("C:/Users/juan_/Downloads/Scripts/Utilities/graphics/R/metri_graphics.R")
func_options=c("Barras Simples", "Barras Borde", "time series", "metri area", "Donut", "metri matrix", "Bubble Chart", "path graph", "Treemap", "Tails", "Bullet Graph")
plotfunc = function(input, output, filedata){
    
  #### AnADIR BULLET GRAPHIC
    output$plot =  renderPlot({
      df <-filedata()
      if (is.null(df) | input$plotear == 0) return(NULL)
      if(input$func=="Bullet Graph")({
        metri_bullet(data=df)
                     #marker = input$marker, value=input$value, title = input$tit, range = ifelse(input$opt_range==T, input$range, NULL), n_range = ifelse(input$opt_range==F, input$n_range, NULL))
      })
      if(input$func=="Tails")({
       p=tails(data=df, sub_data = df %>%  filter(countries %in% input$subdata), x = input$from, y = input$to, 
               categories = input$texto,xlab = input$xlab, ylab = input$ylab, title = input$Title)
       print(p)
       #input$subdata
      })
      if(input$func=="Treemap")({
        metri_treemap(df, group=colnames(df)[1:input$group], size=input$size, size.labels = input$size.labels)
      })
      if(input$func=="path graph"){
        p=plot(path_graph(df, variable=input$Path, sep = ",", numpas = 2))
        print(p)
      }
      if(input$func=="Bubble Chart"){
        df=na.omit(df)
        p=dinamic_bubble_chart(df, x=input$ejex, y=input$ejey, rad=input$radio, categories=input$texto, 
                               prop=ifelse(!is.null(input$prop), input$prop, 0.001), ts=FALSE,
                               xlab = input$xlab, ylab = input$ylab, title = input$Title)
        print(p)
        }
      if(input$func=="metri matrix"){
        rownames(df)=df[,1]
        df=df[,-1]
        metri_matrix(df, title = input$Title)  
      }
      if(input$func=="Donut"){
        Donut(prop=df[, input$to],text=df[,input$from],title = input$Title)  
      }
      if(input$func=="metri area"){
        metri_area(df[1:9,],x=input$from,y=input$to,
                 title = input$Title, xlab = input$xlab, ylab = input$ylab, maxy = 0 )  
      }
      if(input$func=="time series"){
        metri_ts(df[1:9,],x=input$from,y=input$to,
                 title = input$Title, xlab = input$xlab, ylab = input$ylab, maxy = 0)  
      }
      if(input$func=="Barras Borde"){
      metri_bar1(df[1:15,],x=input$from,y=input$to, suffix = ifelse(input$perc==1,"%",""),
            title = input$Title, xlab = input$xlab, ylab = input$ylab)
      }
      if(input$func=="Barras Simples"){
      metri_bar(df[1:9,],x=input$from,y=input$to,
                title = input$Title, horit = ifelse(!is.null(input$horit), input$horit, TRUE), min = ifelse(!is.null(input$min), input$min, 20), perc = ifelse(!is.null(input$perc), input$perc, TRUE),
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
  
  
  
  
  output$func <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    selectInput("func", "Funciones:",func_options)
    
  }) 
  
  
  # The following set of functions populate the column selectors
  
  #### Bars ####
  output$toCol <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    if (input$func %in% c("metri matrix", "Bubble Chart", "path graph", "Treemap", "Bullet Graph")) return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("to", "Valores:",items)
    
  })
  
  
  output$fromCol <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    if (input$func %in% c("metri matrix", "Bubble Chart", "path graph", "Treemap", "Bullet Graph")) return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("from", "Categorias:",items)
    
  })
  
  output$min <- renderUI({
    if (input$func!="Barras Simples") return(NULL)
    numericInput("min", "Minimo", value="80")
  })
  
  output$perc <- renderUI({
    df <-filedata()
    if (input$func %in% c("Barras Simples", "Barras Borde")==F) return(NULL)
    checkboxInput ("perc", "Porcentage", TRUE)
  })
  
  output$horit <- renderUI({
    if (input$func!="Barras Simples") return(NULL)
    checkboxInput ("horit", "Horizontal", TRUE)
  })
  
  #### Bullet Graph ####
  output$tit <- renderUI({
    df <-filedata()
    if (input$func != "Bullet Graph") return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("tit", "Titles:",items)
  })
  
  output$value <- renderUI({
    df <-filedata()
    if (input$func != "Bullet Graph") return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("value", "Value:",items)
  })
  
  output$marker <- renderUI({
    df <-filedata()
    if (input$func != "Bullet Graph") return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("marker", "Marker:",items)
  })
  
  
  output$opt_range <- renderUI({
    df <-filedata()
    if (input$func != "Bullet Graph") return(NULL)
    checkboxInput ("opt_range", "Rango Columna", TRUE)
  })

  output$range <- renderUI({
    df <-filedata()
    if (input$func != "Bullet Graph" | input$opt_range==F) return(NULL)

    items=names(df)
    names(items)=items
    selectInput("range", "Rango:",items)
  })

  output$n_range <- renderUI({
    df <-filedata()
    if (input$func != "Bullet Graph" | input$opt_range==T) return(NULL)

    numericInput("n_range", "Rangos:", value="2", step = "1", max = "4", min = "0")
  })

  #### Tails ####

  output$subdata <- renderUI({
    df <-filedata()
    A=unique(df[,2])
    if (is.null(df)) return(NULL)
    if (input$func != "Tails") return(NULL)
    
    items=A
    selectInput("subdata", "A destacar:",items)
    
  })
  
  
  ################
  
  #### Treemap ####
  output$group = renderUI({
    df = filedata()
    if (is.null(df)) return(NULL)
    if (input$func != "Treemap") return(NULL)
    
    numericInput("group", "Numero Agrupaciones:", value="2", step="1")
    
    
  })
  
  output$size.labels = renderUI({
    df = filedata()
    if (is.null(df)) return(NULL)
    if (input$func != "Treemap") return(NULL)
    
    numericInput("size.labels", "Etiquetas:", value="20", step="1")
    
    
  })
  
  output$size <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    if (input$func != "Treemap") return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("size", "Factor:",items)
    
  })
  
  #### Path Graph ####
  output$Path = renderUI({
  df <-filedata()
  if (is.null(df)) return(NULL)
  if (input$func != "path graph") return(NULL)
  
  items=names(df)
  names(items)=items
  selectInput("Path", "Rutas:",items)
  })
  
  #### Bubble Chart ####
  output$Ejex <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    if (input$func!="Bubble Chart") return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("ejex", "Eje X:",items)
    
  })
  
  output$Ejey <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    if (input$func!="Bubble Chart") return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("ejey", "Eje Y:",items)
    
  })
  
  output$Radio <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    if (input$func!="Bubble Chart") return(NULL)
    items=names(df)
    names(items)=items
    selectInput("radio", "Radio:",items)
    
  })
  
  output$Texto <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    if (input$func %in% c("Bubble Chart", "Tails")==F) return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("texto", "Texto:",items)
    
  })
  
  output$prop <- renderUI({
    if (input$func!="Bubble Chart") return(NULL)
    numericInput("prop", "Proporcion", value="0.001", step="0.001")
  })
  
  
  ##### Common variables #####
  output$Title <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    if (input$func=="Bullet Graph") return(NULL)
    
    textInput("Title", "Titulo", value="")
  })
  
  output$moreoptions <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    if (input$func=="metri matrix") return(NULL)
    
    checkboxInput("moreoptions", "Mas opciones?", FALSE)
  })
  
  
  
  output$xlab <- renderUI({
    if (input$func %in% c("Treemap", "path graph")==T) return(NULL)
    textInput("xlab", "Eje X", value="")
  })
  
  output$ylab <- renderUI({
    if (input$func %in% c("Treemap", "path graph")==T) return(NULL)
    textInput("ylab", "Eje y", value="")
  })
  
  
  #### OUTPUT TABLE ####
  output$filetable <- renderTable({
    head(filedata())
  })
  
  #### OUTPUT PLOT ####
  output$plot = plotfunc(input, output, filedata)
  })  
  
  