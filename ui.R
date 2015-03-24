library(shiny)

shinyUI(fluidPage(
  
  titlePanel("MyTAI App"),
  
  sidebarLayout(
    sidebarPanel( "Upload your data files!:",
                  h3(),
                  fileInput('file1', 'Choose PhyloExpressionSet file to upload',
                            accept = '.csv'),
                  fileInput('file2', 'Choose DivergenceExpressionSet file to upload',
                            accept = '.csv'),
                  tags$hr(),
                  checkboxInput('header', 'Header', TRUE),
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
                  width = 3
    ),
    
    mainPanel("Getting Started",
              tabsetPanel(
                
                tabPanel("data",
                         h3(),
                         textOutput("textheader1"),
                         tableOutput("head"),
                         h3(),
                         textOutput("textheader2"),
                         tableOutput("head2")
                ),
                
                tabPanel("Plot distribution",
                         h3(),                         
                         textOutput("text1"),
                         actionButton("runButton", "Run"),
                         plotOutput("plotdist"),
                         radioButtons('formatDist', 'Document format', c('PDF', 'PNG', 'JPG'),
                                      inline = TRUE),
                         downloadButton('downloadDataDist', 'Download')
                ),
                
                tabPanel("Plot correlation",
                         h3(),
                         textOutput("text2"),
                         actionButton("runButton2", "Run"),
                         h3(),
                         plotOutput("plotcorr"),
                         radioButtons('formatCorr', 'Document format', c('PDF', 'PNG', 'JPG'),
                                      inline = TRUE),
                         downloadButton('downloadDataCorr', 'Download')
                ),
                tabPanel("Plot pattern",
                         h3(),
                         column(6,
                                textOutput("header1"),
                                h3(),
                                textOutput("text3"),
                                h3(),
                                actionButton("runButton3", "Run"),
                                h3(),
                                plotOutput("plotpatternPhylo"),
                                textOutput("textTai"),
                                verbatimTextOutput("tai")),
                         column(6,
                                textOutput("header2"),
                                h3(),
                                textOutput("text4"),
                                h3(),
                                actionButton("runButton4", "Run"),
                                h3(),
                                plotOutput("plotpatternDivergence"),
                                textOutput("textTdi"),
                                verbatimTextOutput("tdi")),
                         radioButtons('formatPattern', 'Document format', c('PDF', 'PNG', 'JPG'),
                                      inline = TRUE),
                         downloadButton('downloadDataPattern', 'Download')
                ),
                
                tabPanel("Plot relative expression levels",
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
                
                tabPanel("Mean Expression Levels",
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
              width = 9
    )
    
  ))
)