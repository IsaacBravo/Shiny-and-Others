library(shiny)
library(tm)
library(wordcloud)

ui <-fluidPage(
  titlePanel("Word Cloud"),
  sidebarLayout(
    sidebarPanel(
      fileInput("wc",
                "Upload a text file for wordcloud",
				multiple = F,
				accept = "text/plain"),
			sliderInput("wordfreq", "Select the min frequency of words",
			            1,10,1),
			sliderInput("maxword", "Select the max number of words",
			            1,500,100),
			checkboxInput("random","Random Order?"),
			radioButtons("color","Select the wordcloud color theme",
			             c("Acent","Dark"),
			             selected = "Accent"),
			actionButton("update", "Create a Word Cloud")
	),
	mainPanel(
		plotOutput("wcplot","800px", "400px")
		)
	)
)

					

server <- function(input, output, session){

	wc_data <- reactive ({
		
	input$update
	
	isolate({

		withProgress({
			setProgress(message = "Processing corpus...")
			wc_file <- input$wc
			if(!is.null(wc_file)){
			wc_text <- readLines(wc_file$datapath)
			}
			else
			{
			wc_text <- "this is an example"
			}
	
	wc_corpus <- Corpus(VectorSource(wc_text))
	wc_corpus_clean <- tm_map(wc_corpus, tolower)
	wc_corpus_clean <- tm_map(wc_corpus_clean, removeNumbers)
	wc_corpus_clean <- tm_map(wc_corpus_clean, removeWords, stopwords())
	wc_corpus_clean <- tm_map(wc_corpus_clean, stripWhitespace)
	wc_corpus_clean <- tm_map(wc_corpus_clean, stemDocument)

			})
		})
	})

	wordlcoud_rep <- repeatable(wordcloud)

	output$wcplot <- renderPlot({
		withProgress({
		setProgress(message = "Creating wordcloud...")
	wc_corpus <- wc_data()
	
	wc_color = brewer.pal(8,"Set2")
	
	if(input$color =="Accent"){
	  wc_color = brewer.pal(8,"Set2")
	} else {
	  wc_color = brewer.pal(8,"Dark2")
	}
	
	wordcloud(wc_corpus, scale = c(10,2), min.freq = input$wordfreq,
	          max.words = input$maxword,
	          colors = wc_color, 
	          random.order = input$random,
            rot.per=0.3)
		})
		})
	
}

shinyApp(ui = ui, server = server)





