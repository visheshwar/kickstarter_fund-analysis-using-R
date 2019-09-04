shinyUI(
  dashboardPage(
    skin = "blue",
    dashboardHeader(title = "Kickstarter Projects"),
    dashboardSidebar(
      menuItem("Most Popular Projects", tabName = "pop_projects", icon = icon("bar-chart-o", "fa-3x")),
      menuItem("Projects being funded", tabName = "funded_project", icon = icon("bar-chart-o", "fa-3x")),
      menuItem("Project Status", tabName = "project_status", icon = icon("bar-chart-o", "fa-3x")),
      menuItem("Technology pro. Status", tabName = "project_status_technology", icon = icon("bar-chart-o", "fa-3x")),
      menuItem("Project By Year", tabName = "project_year", icon = icon("bar-chart-o", "fa-3x")),
      menuItem("About Project ", tabName = "details", icon = icon("file-code-o", "fa-3x")),
      menuItem("About Us", tabName = "about", icon = icon("users", "fa-3x"))
    ),
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "pop_projects", 
                fluidRow( 
                  box(h3("Popular Projects by Category")
                      ,h5("This plot is between the main category vs count
                          Here this graph shows the no of project which is been taken by the kicksarter
                          from the graph its clear that maximum project is for 
                          film and video = aprox 17%
                          music = 14%
                          others project share arount 59% 
                          ")
                      ),
                  box(plotOutput("bar_graph1")),
                  box(h3("Popular Projects by Sub Category"),
                      h5("This plot is between the sub-category
                         This graph give insight of the work going under the project 
                         i.e product design share around 6% followed by Product documentation and others 
                         basically this shows the stats of distribution of project working")),
                  box(plotOutput("bar_graph2"))
                  
                ))
        ,
                
          tabItem(tabName = "funded_project", 
                        fluidRow( 
                          box(h3("Popular Projects funded by Category")        ,
                              h4(" This plot shows the stats of funding based on the category in USD 
                                 from the graph it is clear that maximum amount is spend on Design of the project ")
                              ),
                          box(plotOutput("bar_graph3")),
                          box(h3("Popular Projects funded per Backer"),
                              h4("This shows the stats of the funding project category by the different backers.
                              It give the insight of maximum funding done over the category by the suporter. 
                                 ")),
                          box(plotOutput("bar_graph4")),
                          box(h3("Amount pledged vs Project Category"),
                              h4("This is the distribution of amounts pledged for individual projects using box plots. 
                               It shows that a lot of projects that received little to no funding as well as huge outliers, which will cause the box plots to appear squished near the bottom.
                                 ")
                              ),
                          box(plotOutput("bar_graph5"))
                           )
        ),
        tabItem(tabName = "project_status", 
                fluidRow( 
                  box(h3("Projects   vs Status "),
                      h4("This graph shows the status of the project which represent  successfullness as well as the other status too during the tenure
                         from the graph it is clear there were maximum successful project.
                         ")
                      ),
                  box(plotOutput("bar_graph6")),
                  box(h3("Completed Projects"),
                      h4("This give the insight of the total project completed during the tenure ")),
                  box(plotOutput("bar_graph7")),
                  box(h3("InCompleted Projects"),
                      h4("It show the percentage of the incomplete project which were rejected or suspended based on their working status.
                         as the compony on deals on making creative projects ")),
                  box(plotOutput("bar_graph8"))
                  
                )
        ),
        tabItem(tabName = "project_status_technology", 
                fluidRow( 
                  box(h3("Projects_technology vs Status "),
                      h4("This graph shows the status of the project which represent  successfullness as well as the other status too during the tenure
                         from the graph it is clear there were maximum successful project.
                         ")
                  ),
                  box(plotOutput("bar_graph10")),
                  box(h3("Completed Projects"),
                      h4("This give the insight of the total project completed during the tenure ")),
                  box(plotOutput("bar_graph11")),
                  box(h3("InCompleted Projects"),
                      h4("It show the percentage of the incomplete project which were rejected or suspended based on their working status.
                         as the compony on deals on making creative projects ")),
                  box(plotOutput("bar_graph12"))
                  
                )
        ),
        tabItem(tabName = "project_year", 
                fluidRow( 
                  box(h3("Projects  by Launch Year"),
                      h4("This shows the stat of how the project were launched over the year giving the insight how the company progress over a given span of time.")
                      ),
                  box(plotOutput("bar_graph9"))
                  
                )
        ),
        tabItem(tabName = "details", 
                fluidRow( 
                  h2("Kickstarter Project"),
                      h4("Understanding Kickstarter:
Kickstarter Is an American public-benefit corporation based in Brooklyn, New York, that maintains a global crowdfunding platform focused on creativity . Kickstarter has reportedly received more than $1.9 billion in pledges from 9.4 million backers to fund 257,000 creative projects, such as films, music, stage shows, comics, journalism, video games, technology and food-related projects.
People who back Kickstarter projects are offered tangible rewards or experiences in exchange for their pledges. This model traces its roots to subscription model of arts patronage, where artists would go directly to their audiences to fund their work.")
                      )
                  
                
        ),
        tabItem(tabName = "about", 
                fluidRow( 
                  box(
                      h4("Visheshwar ")
                      )
                  
                )
        )
        
      )
      
    )
  )
)
