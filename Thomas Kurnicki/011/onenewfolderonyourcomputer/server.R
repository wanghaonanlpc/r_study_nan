

library(shiny)
library(plotly)
library(rpart)
library(rpart.plot)
library(rhandsontable)
library(MASS)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  library(readxl)
  mydf <- read_excel("../../Basic data/german credit card.xls")

  # mydf$purpose <- as.numeric(gusb("x","",mydf$purpose))
  
  mydf$good_bad <- gsub("good",1,mydf$purpose)
  mydf$good_bad <- gsub("bad",0,mydf$purpose)
  mydf$good_bad <- as.numeric(mydf$good_bad)
  mydf <<- mydf
  
  output$p <- renderPlotly({
    z <- plot_ly(mydf, x=~age, y=~amount)%>%
      layout(dragmode = "select")
    z
  })
  
  output$hot <- renderPlot({
  
    my_tree <- rpart(ulcer ~ time+status+sex+age+year+thickness,
                     data = Melanoma, method = "class", cp = input$cp)
    rpart.plot(my_tree, type = 1, extra = 1)
    
  })
  ###########################################
  ###########################################
  ##########################################
  # correlation <- round(cor(mydf), 3)
  # 
  # output$heat <- renderPlotly({
  #   plot_ly(xxxxxxxxxxxx) %>%
  #     add_heatmap(
  #      xxxxxxxxx,
  #      xxxxxxxxxx,
  #      xxxxxxxxx
  #     )
  # })
  # 
  # output$scatterplot <- renderPlotly({
  #   # if there is no click data, render nothing!
  #   clickData <- event_data("xxxxxxxxxx", source = "xxxxxxxxx")
  #   if (is.null(clickData)) return(NULL)
  #   
  #   # Obtain the clicked x/y variables and fit linear model
  #   vars <- c(clickData[["x"]], clickData[["y"]])
  #   d <- setNames(mydf[vars], c("x", "y"))
  #   yhat <- fitted(lm(y ~ x, data = d))
  #   
  # 
  #   xxxxxxxxxxxxxxx
  #   xxxxxxxxxxxxxx
  #   xxxxxxxxxxxxxxx
  #   xxxxxxxxxxxxxx
  #   
  # })
  # 
  
})
