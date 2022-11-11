#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# ?builder will open the help panel and provides the wrap around HTML tags. 
#

library(shiny) 

# Define UI for application that draws a histogram
shinyUI(fluidPage(     ##shinyUI is what controls the interface.fluid page is the page type (default function). 

    # Application title
    titlePanel("Old Faithful Geyser Data"), 

    # Sidebar with a slider input for number of bins
    sidebarLayout(   ##the type of layout for whats going to occur in the sidebar.
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
###_____________________## Each of these shinyUI functions will overwrite the preceeding one
library(shiny)
shinyUI(fluidPage(
  titlePanel("Data science FTW!"),
  sidebarLayout(
    sidebarPanel(
      h3("Sidebar Text")
    ),
    mainPanel(
      h3("Main Panel Text")
    )
  )
))


##______________________##
library(shiny)
shinyUI(fluidPage(
  titlePanel("HTML Tags"),
  sidebarLayout(
    sidebarPanel(
      h1("H1 Text"),
      h3("H3 Text"),
      em("Emphasized Text")
    ),
    mainPanel(
      h3("Main Panel Text"),
      code("Some Code!")
    )
  )
))

##_____________________##
library(shiny)
shinyUI(fluidPage(
  titlePanel("Slider App"),
  sidebarLayout(
    sidebarPanel(
      h1("Move the Slider!"),
      sliderInput("slider1", "Slide Me!", 0, 100, 0)
    ),
    mainPanel(
      h3("Slider Value:"),
      textOutput("text")
    )
  )
))

##_________________________## Example 1.1
library(shiny)
shinyUI(fluidPage(
  titlePanel("Plot Random Numbers"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numeric", "How Many Random Numbers Should be Plotted?", ##labels the input as numeric, then the title
                   value = 1000, min = 1, max = 1000, step = 1),  ##self explanatory.
      sliderInput("sliderX", "Pick Minimum and Maximum X Values",  ##sets up a slide for the X axis on your plot
                  -100, 100, value = c(-50, 50)),  ##first set of values are min and max, value are the starting points
      sliderInput("sliderY", "Pick Minimum and Maximum Y Values",
                  -100, 100, value = c(-50, 50)),
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE), ##checkbox that gives you options on the app, and the first element is a specific ufunction
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
      checkboxInput("show_title", "Show/Hide Title")
    ),
    mainPanel(
      h3("Graph of Random Points"),
      plotOutput("plot1")
    )
  )
))

##______________________## Example 2.1
library(shiny)
shinyUI(fluidPage(  ##library shiny statement
  titlePanel("Predict Horsepower from MPG"),
  sidebarLayout(  ##sidebar panel contins the input
    sidebarPanel(
      sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20),  ##slider argument, then title
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE), ##two inputs- show model 1 and 2
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
          submitButton("Submit") #to create a submit button in the even that app making much larger calculations. 
    ),
    mainPanel( ##main panel contains the outputs
      plotOutput("plot1"),  ##the outputs, where plot1 will need to be in Server.R
      h3("Predicted Horsepower from Model 1:"),
      textOutput("pred1"),  ##another output
      h3("Predicted Horsepower from Model 2:"),
      textOutput("pred2")  ##last output
    )
  )
))

##______________________## Example 2.2   ctrl + shift + c
# library(shiny)
# shinyUI(fluidPage(
# titlePanel("Visualize Many Models"),
# sidebarLayout(
#  sidebarPanel(
#  h3("Slope"),
#  textOutput("slopeOut"),
# h3("Intercept"),
# textOutput("intOut")
# ),
# mainPanel(
#  plotOutput("plot1", brush = brushOpts(
#    id = "brush1"
# ))
# )
# )
# ))