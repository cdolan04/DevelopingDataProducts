# server.R

shinyServer(function(input, output) {
        
        temp <- tempfile()
        download.file("http://www.retrosheet.org/gamelogs/gl2015.zip",temp)
        data <- read.table(unz(temp, "GL2015.TXT"), sep = ",")
        unlink(temp)
        
        data <- subset(data, data[,4] == "SLN" | data[,7] == "SLN")
        data <- data[,c(1,4,7,10,11,22,23,50,51)] 
        data$BattingAvgAway <- data[,7]/data[,6]
        data$BattingAvgHome <- data[,9]/data[,8]
        
        data <- data[,-c(6:9)]
        names(data) <- c("Date", "AwayTeam", "HomeTeam", "AwayScore", "HomeScore","BatAvgAway", "BatAvgHome")        
        
        cardsaway <- subset(data, data$AwayTeam == "SLN")
        cardshome <- subset(data, data$HomeTeam == "SLN")
        
        homeavg <- round(mean(cardshome$BatAvgHome), digits = 3)
        awayavg <- round(mean(cardsaway$BatAvgAway), digits = 3)
        
        ## Step needed to remove factor levels of teams they did not play
        as.vector(cardshome$AwayTeam) -> cardshome$AwayTeam
        as.factor(cardshome$AwayTeam) -> cardshome$AwayTeam
        as.vector(cardsaway$HomeTeam) -> cardsaway$HomeTeam
        as.factor(cardsaway$HomeTeam) -> cardsaway$HomeTeam
        
        output$text1 <- renderText({ 
                if (input$radio == "Home Games"){
                        output$text2 <- renderText({
                                paste("The team batting average for the Cardinals was: ", homeavg)
                        })
                        output$plot1 <- renderPlot({
                                plot(y = cardshome$BatAvgHome, x = cardshome$AwayTeam, las=2, xlab = "Team", 
                                     ylab = "Average", main = "Home Batting Avg", col = "red")
                        })
                        }
                else if (input$radio == "Away Games"){
                        output$text2 <- renderText({
                                paste("The team batting average for the Cardinals was: ", awayavg)
                        })
                        output$plot1 <- renderPlot({
                                plot(y = cardsaway$BatAvgAway, x = as.factor(cardsaway$HomeTeam), las=2, xlab = "Team", 
                                     ylab = "Average", main = "Away Batting Avg", col = "red")
                        })
                        }
                paste(input$radio)
        })
        
        
        
})