library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Performing Phylotranscriptomics with myTAI App"),
  
  sidebarLayout(
    
    sidebarPanel( 
                
                  checkboxInput('header', 'Is a Header Included?', TRUE),
                  tags$hr(),
                  radioButtons('sep', 'Separator',
                               c(Comma=',',
                                 Semicolon=';',
                                 Tab='\t'),
                               ';'),
                  radioButtons('quote', 'Quote',
                               c(None='',
                                 'Double Quote'='"',
                                 'Single Quote'="'"),
                               '"'),
                  "Upload ExpressionSet:",
                  h3(),
                  fileInput('file1', 'Select ExpressionSet',
                            accept = '.csv'),
                  width = 4
    ),
    
    mainPanel("Overview",
              tabsetPanel(
                
                tabPanel("Main",
                         h4("Capturing Evolutionary Signals in Developmental Transcriptomes")
                         
                         
                ),
                
                tabPanel("PlotDistribution",
                         h3(),                         
                         textOutput("text1"),
                         actionButton("runButton", "Run"),
                         plotOutput("plotdist"),
                         radioButtons('formatDist', 'Document format', c('PDF', 'PNG', 'JPG'),
                                      inline = TRUE),
                         downloadButton('downloadDataDist', 'Download')
                ),
                
                tabPanel("PlotCorrelation",
                         h3(),
                         textOutput("text2"),
                         h3(),
                         radioButtons('method', 'choose correltaion method:', 
                                      c('pearson', 'kendall', 'spearman'), inline = TRUE),
                         actionButton("runButton2", "Run"),
                         h3(),
                         plotOutput("plotcorr"),
                         radioButtons('formatCorr', 'Document format', c('PDF', 'PNG', 'JPG'),
                                      inline = TRUE),
                         downloadButton('downloadDataCorr', 'Download')
                ),
                tabPanel("PlotPattern",
                         h3(),
                         column(12,
                                textOutput("header1"),
                                h3(),
                                textOutput("text3"),
                                h3(),
                                actionButton("runButton3", "Run"),
                                h3(),
                                plotOutput("plotpatternPhylo"),
                                textOutput("textTai"),
                                verbatimTextOutput("tai")),
                         
                         radioButtons('formatPattern', 'Document format', c('PDF', 'PNG', 'JPG'),
                                      inline = TRUE),
                         downloadButton('downloadDataPattern', 'Download')
                ),
                
                tabPanel("PlotRE",
                         h3(),
                         radioButtons('dataset', 'Which data set: ', 
                                      c('PhyloExpressionSet', 'DivergenceExpressionSet'),
                                      inline = TRUE),
                         actionButton("runButton5", "Run"),
                         h3(),
                         plotOutput("plotRE"),
                         radioButtons('formatRE', 'Document format', c('PDF', 'PNG', 'JPG'),
                                      inline = TRUE),
                         downloadButton('downloadDataRE', 'Download')
                ),
                
                tabPanel("PlotMeans",
                         h3(),
                         column(6,
                                textOutput("textMeansPhylo"),
                                h3(),
                                actionButton("runButton6", "Run"),
                                h3(),
                                plotOutput("plotMeansPhylo")),
                         column(6,
                                textOutput("textMeansDiv"),
                                h3(),
                                actionButton("runButton7", "Run"),
                                h3(),
                                plotOutput("plotMeansDiv")),
                         radioButtons('formatMeans', 'Document format', c('PDF', 'PNG', 'JPG'),
                                      inline = TRUE),
                         downloadButton('downloadDataMeans', 'Download')
                )
              ),
              width = 8
    )
    
  ))
)