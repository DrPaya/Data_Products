#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny) 

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')

    })

})

##__________________## For the example slider from JHU

library(shiny)
shinyServer(function(input, output) {
  output$text <- renderText(input$slider1)
})

##___________________##  For the advanced random number figure application, 1.1
library(shiny)
shinyServer(function(input, output) {
  output$plot1 <- renderPlot({  ##here the output is going to be a plot, and we have named it plot1, renderPlot is a function.
    set.seed(2016-05-25)
    number_of_points <- input$numeric  ##grabbing a numeric value for the numeric input
    minX <- input$sliderX[1]  ## elements of the slider. Input is a list of vectors, and x-values will depend on the position of one of two x sliders.
    maxX <- input$sliderX[2]
    minY <- input$sliderY[1]
    maxY <- input$sliderY[2]
    dataX <- runif(number_of_points, minX, maxX)  ##takes in the input number of points, and range is defined by min and max of x
    dataY <- runif(number_of_points, minY, maxY)    ## same for y
    xlab <- ifelse(input$show_xlab, "X Axis", "") ##conditional statement that is based on whether the boxes were ticked in the interface.
    ylab <- ifelse(input$show_ylab, "Y Axis", "")
    main <- ifelse(input$show_title, "Title", "")
    plot(dataX, dataY, xlab = xlab, ylab = ylab, main = main,
         xlim = c(-100, 100), ylim = c(-100, 100))
  })
})

##_____________________## Example 2.1

library(shiny)
shinyServer(function(input, output) {  ##a function with an input and output
  mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)  ##spline that limits mpg data
  model1 <- lm(hp ~ mpg, data = mtcars) ## linear model for entire dataset
  model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)  ##linear model for mpg data with spline/break in it. 
  
  model1pred <- reactive({
    mpgInput <- input$sliderMPG  ##what we named the input in our slider on the ui (first argument, then title)
    predict(model1, newdata = data.frame(mpg = mpgInput))  ##uses model 1, and predicts as a new value input from the slider
  })
  
  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model2, newdata = ##uses model 2, and predicts new value but it has conditional statement to include spline.
              data.frame(mpg = mpgInput,
                         mpgsp = ifelse(mpgInput - 20 > 0,
                                        mpgInput - 20, 0)))
  })
  
  
  output$plot1 <- renderPlot({  
    mpgInput <- input$sliderMPG  ##grabbing slider mpg input
    
    plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon", 
         ylab = "Horsepower", bty = "n", pch = 16,  ##standard R plot
         xlim = c(10, 35), ylim = c(50, 350))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)  #adds the fit to each model based on which model is selected
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
      ))
      lines(10:35, model2lines, col = "blue", lwd = 2)
    }
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, ##highly detailed legend here. 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2) ##points plot on main plot, where it delivers the number from the mopdel1pred(). 
    points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()  ##parentheses needed because we are using a reactive expression. Otherwise it will retutn the function
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})

##_______________________## Example 2.2
# library(shiny)
# shinyServer(function(input, output) {
#   model <- reactive({
#     brushed_data <- brushedPoints(trees, input$brush1,
#                                   xvar = "Girth", yvar = "Volume")
#     if(nrow(brushed_data) < 2){
#       return(NULL)
#     }
#     lm(Volume ~ Girth, data = brushed_data)
#   })
#   output$slopeOut <- renderText({
#     if(is.null(model())){
#       "No Model Found"
#     } else {
#       model()[[1]][2]
#     }
#   })
#   
  
#   output$intOut <- renderText({
#     if(is.null(model())){
#       "No Model Found"
#     } else {
#       model()[[1]][1]
#     }
#   })
#   output$plot1 <- renderPlot({
#     plot(trees$Girth, trees$Volume, xlab = "Girth",
#          ylab = "Volume", main = "Tree Measurements",
#          cex = 1.5, pch = 16, bty = "n")
#     if(!is.null(model())){
#       abline(model(), col = "blue", lwd = 2)
#     }
#   })
# })