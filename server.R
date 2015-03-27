library(myTAI)
data(PhyloExpressionSetExample) 
data(DivergenceExpressionSetExample) 

shinyServer(function(input, output) {
  
  PhyloExpressionSet <- function(){
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
    
  }
  
  DivergenceExpressionSet <- function(){
    
    inFile <- input$file2
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
    
  }
  
  output$head <- renderTable({
    
    head(PhyloExpressionSet(), 3)
    
  })
  
  output$head2 <- renderTable({
    
    head(DivergenceExpressionSet(), 3) 
    
  })
  
  output$text1 <- renderText("Before starting any computation, 
                             sometimes it is good to visualize 
                             the Phylostratum distribution of genes 
                             stored within a given PhyloExpressionSet.")
  
  output$text2 <- renderText("Another important feature to check is whether 
                             the Phylostratum assignment and Divergence-Stratum 
                             assignment of the genes stored within the PhyloExpressionSet 
                             and DivergenceExpressionSet are correlated (linear dependent). 
                             This is important to be able to assume the linear 
                             independence of TAI and TDI measures.")
  
  output$text3 <- renderText("The PlotPattern() function first computes the TAI
                             (given a PhyloExpressionSet) to visualize the TAI  
                             profile, their standard deviation and statistical 
                             significance.")
  
  output$text4 <- renderText("The PlotPattern() function first computes the TDI 
                             (given a DivergenceExpressionSet) to visualize the 
                             TDI profile, their standard deviation and statistical 
                             significance.")
  
  output$textMeansPhylo <- renderText("Visualizing the Mean Expression Levels of 
                                      a PhyloExpressionSet")
  
  output$textMeansDiv <- renderText("Visualizing the Mean Expression Levels of 
                                    a DivergenceExpressionSet")
  
  output$textheader1 <- renderText("PhyloExpressionSet")
  output$textheader2 <- renderText("DivergenceExpressionSet")
  
  output$header1 <- renderText("PhyloExpressionSet")
  output$header2 <- renderText("DivergenceExpressionSet")
  
  output$textTai <- renderText("TAI: ")
  output$textTdi <- renderText("TDI: ")
  
  output$tai <- renderPrint({
    
    if(input$runButton3 == 0) return(NULL) 
    if(is.null(PhyloExpressionSet())) return(NULL)
    TAI(PhyloExpressionSet())
    
  })
  
  output$tdi <- renderPrint({
    
    if(input$runButton4 == 0) return(NULL) 
    if(is.null(DivergenceExpressionSet())) return(NULL)
    TDI(DivergenceExpressionSet())
    
  })
  
  inputPlotDist <- function(){
    
    if(input$runButton == 0) return(NULL) 
    validate(
      need(PhyloExpressionSet() != "", "Please select a Phylo Expression data set")
    )
    withProgress(message = 'Creating plot', value = 0.1, {
      PlotDistribution( PhyloExpressionSet = PhyloExpressionSet(), 
                        as.ratio            = TRUE, 
                        xlab                = "Phylostratum", 
                        cex                 = 0.7 )
      
      incProgress(0.5)
    })
  }
  
  output$plotdist <- renderPlot({
    print(inputPlotDist())
  })
  
  inputPlotCorr <- function(){
    
    if(input$runButton2 == 0) return(NULL)
    validate(
      need(PhyloExpressionSet() != "", "Please select a Phylo Expression data set")
    )
    validate(
      need(DivergenceExpressionSet() != "", "Please select a Divergence Expression data set")
    )
    
    withProgress(message = 'Creating plot', value = 0.1, {
      PlotCorrelation( PhyloExpressionSet    = PhyloExpressionSet(),
                       DivergenceExpressionSet = DivergenceExpressionSet(),
                       method                  = switch(input$method , "pearson" = 'pearson', 
                                                        "kendall" = 'kendall', 
                                                        "spearman" = 'spearman'), 
                       linearModel             = TRUE )
      
      incProgress(0.5)
    })
  }
  
  output$plotcorr <- renderPlot({
    print(inputPlotCorr())
  })
  
  inputPlotPatternPhylo <- function(){
    
    if(input$runButton3 == 0) return(NULL)
    validate(
      need(PhyloExpressionSet() != "", "Please select a Phylo Expression data set")
    )
    
    withProgress(message = 'Creating plot', value = 0.1, {
      PlotPattern( ExpressionSet = PhyloExpressionSet(), 
                   type          = "l", 
                   lwd           = 6, 
                   xlab          = "Ontogeny", 
                   ylab          = "TAI" )
      
      incProgress(0.5)
    })
  }
  
  inputPlotPatternDivergence <- function(){
    
    if(input$runButton4 == 0) return(NULL)
    validate(
      need(DivergenceExpressionSet() != "", "Please select a Divergence Expression data set")
    )
    
    withProgress(message = 'Creating plot', value = 0.1, {
      PlotPattern( ExpressionSet = DivergenceExpressionSet(), 
                   type          = "l", 
                   lwd           = 6, 
                   xlab          = "Ontogeny", 
                   ylab          = "TDI" )
      
      incProgress(0.5)
    })
  }
  
  output$plotpatternPhylo <- renderPlot({
    
    print(inputPlotPatternPhylo())
  })
  
  output$plotpatternDivergence <- renderPlot({
    
    print(inputPlotPatternDivergence())
  })
  
  inputPlotRE <- function(){
    
    if(input$runButton5 == 0) return(NULL) 
    validate(
      need(PhyloExpressionSet() != "", "Please select a Phylo Expression data set")
    )
    withProgress(message = 'Creating plot', value = 0.1, {
      PlotRE(switch(input$dataset, PhyloExpressionSet = PhyloExpressionSet(), 
                    DivergenceExpressionSet = DivergenceExpressionSet()),
             Groups = list(c(1:3), c(4:12)),
             legendName = "PS", 
             lty = 1, 
             lwd = 5)
      
      incProgress(0.5)
    })
  }
  
  output$plotRE <- renderPlot({
    print(inputPlotRE())
  })
  
  
  inputPlotMeansPhylo <- function(){
    
    if(input$runButton6 == 0) return(NULL) 
    validate(
      need(PhyloExpressionSet() != "", "Please select a Phylo Expression data set")
    )
    withProgress(message = 'Creating plot', value = 0.1, {
      PlotMeans( ExpressionSet = PhyloExpressionSet(), 
                 Groups        = list(group_1 = 1:3, group_2 = 4:12), 
                 legendName    = "PS",
                 xlab          = "Ontogeny", 
                 lty           = 1, 
                 cex           = 0.7, 
                 lwd           = 5 )
      
      incProgress(0.5)
    })
  }
  
  inputPlotMeansDiv <- function(){
    
    if(input$runButton7 == 0) return(NULL) 
    validate(
      need(DivergenceExpressionSet() != "", "Please select a Phylo Expression data set")
    )
    withProgress(message = 'Creating plot', value = 0.1, {
      PlotMeans( ExpressionSet = DivergenceExpressionSet(), 
                 Groups        = list(1:10), 
                 legendName    = "DS",
                 xlab          = "Ontogeny", 
                 lty           = 1, 
                 cex           = 0.7, 
                 lwd           = 5 ) 
      
      incProgress(0.5)
    })
  }
  
  output$plotMeansPhylo <- renderPlot({
    
    print(inputPlotMeansPhylo())
  })
  
  output$plotMeansDiv <- renderPlot({
    
    print(inputPlotMeansDiv())
  })
  
  # downloads  
  
  output$downloadDataDist <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$formatDist, PDF = 'pdf', PNG = 'png', JPG = 'jpg'
      ))
    },
    content = function(file) {
      if(input$formatDist == "PDF") pdf(file)
      else if(input$formatDist == "PNG")  png(file)
      else if(input$formatDist == "JPG")  jpeg(file)
      
      inputPlotDist()
      dev.off()
      
    }
  )
  
  output$downloadDataCorr <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$formatCorr, PDF = 'pdf', PNG = 'png', JPG = 'jpg'
      ))
    },
    content = function(file) {
      
      if(input$formatCorr == "PDF") pdf(file)
      else if(input$formatCorr == "PNG")  png(file)
      else if(input$formatCorr == "JPG")  jpeg(file)
      
      inputPlotCorr()
      dev.off()
    }
  )
  
  output$downloadDataPattern <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$formatPattern, PDF = 'pdf', PNG = 'png', JPG = 'jpg'
      ))
    },
    content = function(file) {
      if(input$formatPattern == "PDF") pdf(file)
      else if(input$formatPattern == "PNG")  png(file)
      else if(input$formatPattern == "JPG")  jpeg(file)
      
      inputPlotPatternPhylo()
      #      inputPlotPatternDivergence()
      dev.off()
      
    }
  )
  
  output$downloadDataRE <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$formatPattern, PDF = 'pdf', PNG = 'png', JPG = 'jpg'
      ))
    },
    content = function(file) {
      if(input$formatRE == "PDF") pdf(file)
      else if(input$formatRE == "PNG")  png(file)
      else if(input$formatRE == "JPG")  jpeg(file)
      
      inputPlotRE()
      dev.off()
      
    }
  )
  
  output$downloadDataMeans <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$formatPattern, PDF = 'pdf', PNG = 'png', JPG = 'jpg'
      ))
    },
    content = function(file) {
      if(input$formatMeans == "PDF") pdf(file)
      else if(input$formatMeans == "PNG")  png(file)
      else if(input$formatMeans == "JPG")  jpeg(file)
      
      inputPlotMeansPhylo()
      dev.off()
      
    }
  )
})