library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinythemes)
library(data.table)
library(devtools)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(scales)
#install.packages("RColorBrewer")
library(RColorBrewer)
#install.packages("maps")


shinyServer(function(input, output){
  
  data1 <- read.csv("kickstarter_2018.csv")
  pledged.tot <- data1 %>%
    group_by(main_category) %>%
    summarize(total=sum(usd_pledged_real)) %>%
    arrange(desc(total))
  pledged.tot$main_category <- factor(pledged.tot$main_category, levels=pledged.tot$main_category)
  
  #output$box<-ggplot(data1,aes(x=main_category ,group=state))+geom_bar()
  
  #examining the number of projects by main category
  
  cat.freq <- data1 %>%
    group_by(main_category) %>%
    summarize(count=n()) %>%
    arrange(desc(count))
  
  cat.freq$main_category <- factor(cat.freq$main_category, levels=cat.freq$main_category)
  
  subcat.freq <- data1 %>%
    group_by(category) %>%
    summarize(count=n()) %>%
    arrange(desc(count))
  
  subcat.freq$category <- factor(subcat.freq$category, levels=subcat.freq$category)
  
  data1%>% filter(is.na(usd_pledged_real))
  
  
  pledged.tot <- data1 %>%
    group_by(main_category) %>%
    summarize(total=sum(usd_pledged_real)) %>%
    arrange(desc(total))
  
  pledged.tot$main_category <- factor(pledged.tot$main_category, levels=pledged.tot$main_category)
  
  
  #total number of backers for each category
  
  pledged.avg <-data1 %>%
    group_by(main_category) %>%
    summarize(pledged=sum(usd_pledged_real), backers=sum(backers)) %>%
    mutate(avg=pledged/backers) %>%
    arrange(desc(avg))
  
  pledged.avg$main_category <- factor(pledged.avg$main_category, levels=pledged.avg$main_category)
  
  state.freq <-data1 %>%
    group_by(state) %>%
    summarize(count=n()) %>%
    arrange(desc(count))
  
  state.freq$state <- factor(state.freq$state, levels=state.freq$state)
  
  #project status proportion for each group
  unique(data1$state)
  
  state.grp_comp <- data1 %>%
    filter(state!="undefined",state %in% c("successful", "failed") ) %>%
    group_by( state) %>%
    mutate(grp= "complete") %>%
    summarize(count=n()) %>%
    mutate(pct=count/sum(count))
  #incompleted projects
  unique(data1$state)
  state.grp_incomp <- data1 %>%
    filter(state!="undefined",state %in% c("canceled", "suspended","live") ) %>%
    group_by( state) %>%
    mutate(grp= "incomplete") %>%
    summarize(count=n()) %>%
    mutate(pct=count/sum(count))
  
  #Projects by year
  
  year.freq <- data1 %>%
    group_by(year=format(as.Date(launched),"%")) %>%
    summarize(count=n())
  
  year.freq<-data1%>% mutate( year=format(as.Date(data1$launched,"%d-%m-%y"),"%Y"))
  data1$year_launched=format(as.Date(as.character(data1$launched),"%d-%m-%Y"),"%Y")
  year.freq <- data1 %>% group_by(year_launched) %>%
    summarize(count=n())
  year.freq
  #project based on the technology
  state.freqt <-data1 %>%
    group_by(state) %>% filter (main_category=="Technology")%>%
    summarize(count=n()) %>%
    arrange(desc(count))
  
  state.freqt$state <- factor(state.freqt$state, levels=state.freqt$state)
  
  ######incomplete
  #project status proportion for each group
  unique(data1$state)
  state.grp_compt <- data1 %>%
    filter(state!="undefined",state %in% c("successful", "failed") ) %>%
    group_by( state) %>% filter (main_category=="Technology")%>%
    mutate(grp= "complete") %>%
    summarize(count=n()) %>%
    mutate(pct=count/sum(count))
  #incompleted projects
  unique(data1$state)
  state.grp_incompt <- data1 %>%
    filter(state!="undefined",state %in% c("canceled", "suspended","live") ) %>%
    group_by( state) %>% filter (main_category=="Technology")%>%
    mutate(grp= "incomplete") %>%
    summarize(count=n()) %>%
    mutate(pct=count/sum(count))
  
  ####output for the graph UI interferance
  output$bar_graph1<-renderPlot({
    ggplot(cat.freq, aes(main_category, count, fill=count)) + geom_bar(stat="identity") + 
      ggtitle("Projects by Category") + xlab("Project Category") + ylab("Frequency") + 
      geom_text(aes(label=count), vjust=-0.5) + 
      scale_fill_gradient(low="cyan", high="navyblue") }    ,height = 400,
    width = 600)
  
  output$bar_graph2<-renderPlot({
    ggplot(head(subcat.freq, 10), aes(category, count, fill=count)) + geom_bar(stat="identity") + 
      ggtitle("Projects by Subcategory") + xlab("Project Subcategory") + ylab("Frequency") + 
      geom_text(aes(label=count), vjust=-0.5) + 
      scale_fill_gradient(low="yellow", high="red")
  },height = 400,
  width = 600)
  
  output$bar_graph3<-renderPlot({
    ggplot(pledged.tot, aes(main_category, total/1000000, fill=total)) + geom_bar(stat="identity") + 
      ggtitle("Total Amount Pledged by Category") + xlab("Project Category") + 
      ylab("Amount Pledged (USD millions)") + 
      geom_text(aes(label=paste0("$", round(total/1000000,1))), vjust=-0.5)  + 
      scale_fill_gradient(low="yellow", high="red")
  },height = 400,
  width = 600)
  
  output$bar_graph4<-renderPlot({
    ggplot(pledged.avg, aes(main_category, avg, fill=avg)) + geom_bar(stat="identity") + 
      ggtitle("Average Amount Pledged per Backer") + xlab("Project Category") + 
      ylab("Amount Pledged (USD)") + 
      geom_text(aes(label=paste0("$", round(avg,2))), vjust=-0.5)  + 
      scale_fill_gradient(low="blue", high="green")
  },height = 400,
  width = 600)
  
  #amount pledged vs project category
  output$bar_graph5<-renderPlot({
    ggplot(data1, aes(main_category, usd_pledged_real, fill=main_category)) + geom_boxplot() + 
      ggtitle("Amount Pledged vs. Project Category") + xlab("Project Category") + 
      ylab("Amount Pledged (USD)") + coord_cartesian(ylim=c(
        0,20000))
  },height = 400,
  width = 600)
  
  
  output$bar_graph6<-renderPlot({
    ggplot(state.freq, aes(state, count, fill=count)) + geom_bar(stat="identity") + 
      ggtitle("Projects by Status") + xlab("Project Status") + ylab("Frequency") + 
      geom_text(aes(label=count), vjust=-0.5) +   
      scale_fill_gradient(low="blue", high="green")
  },height = 400,
  width = 600)
  
  
  output$bar_graph7<-renderPlot({
  ggplot(state.grp_comp, aes(state, pct, fill=state)) + geom_bar(stat="identity") + 
  ggtitle("Completed projects ") + xlab("Project Completion") + ylab("Percentage") + 
    scale_y_continuous(labels=scales::percent) + 
    geom_text(aes(label=paste0(round(pct*100,1),"%")), position=position_stack(vjust=0.5), 
              colour="white", size=5) 
   },height = 400,
   width = 600)
  
  

  
  
  output$bar_graph8<-renderPlot({
    ggplot(state.grp_incomp, aes(state, pct, fill=state)) + geom_bar(stat="identity") + 
      ggtitle("Incompleted projects ") + xlab("Project Completion") + ylab("Percentage") + 
      scale_y_continuous(labels=scales::percent) + 
      geom_text(aes(label=paste0(round(pct*100,1),"%")), position=position_stack(vjust=0.5), 
                colour="white", size=5)  
  },height = 400,
  width = 600)
  
  
  output$bar_graph9<-renderPlot({
    ggplot(year.freq,aes(x=year_launched,y=count,fill=count))+geom_bar(stat="identity")+
      ggtitle("Number of Projects by Launch Year") + xlab("Year") + ylab("Frequency") 
  },height = 400,
  width = 600)
  
   output$bar_graph10<-renderPlot({
  ggplot(state.freqt, aes(state, count, fill=count)) + geom_bar(stat="identity") + 
    ggtitle("Projects-Technology by Status") + xlab("Project_technology Status") + ylab("Frequency") + 
    geom_text(aes(label=count), vjust=-0.5) +   
    scale_fill_gradient(low="blue", high="green")
},height = 400,
width = 600)

   output$bar_graph11<-renderPlot({
     ggplot(state.grp_compt, aes(state, pct, fill=state)) + geom_bar(stat="identity") + 
       ggtitle("Completed projects ") + xlab("Project Completion") + ylab("Percentage") + 
       scale_y_continuous(labels=scales::percent) + 
       geom_text(aes(label=paste0(round(pct*100,1),"%")), position=position_stack(vjust=0.5), 
                 colour="white", size=5) 
   },height = 400,
   width = 600)
   
   
   
   
   
   output$bar_graph12<-renderPlot({
     ggplot(state.grp_incompt, aes(state, pct, fill=state)) + geom_bar(stat="identity") + 
       ggtitle("Incompleted projects ") + xlab("Project Completion") + ylab("Percentage") + 
       scale_y_continuous(labels=scales::percent) + 
       geom_text(aes(label=paste0(round(pct*100,1),"%")), position=position_stack(vjust=0.5), 
                 colour="white", size=5)  
   },height = 400,
   width = 600)
   
   })