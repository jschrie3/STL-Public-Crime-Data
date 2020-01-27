
library(shiny)

crimedata<-read.csv("Mergeddata2019.csv")

ui<-fluidPage(
    titlePanel("St.Louis Crime Data"),
    sidebarLayout(
      sidebarPanel("inputs would go here"),
      mainPanel("the results would go here")
    )
  )