library(dplyr)
library(stringr)
library(tidyr)

df <- 
	read.table(file="./vep_consequence_table.tsv", 
				  header = TRUE, 
				  sep = "\t", 
				  stringsAsFactors = FALSE)

df <- df %>% select("IMPACT", "Display.term", "SO.description", "SO.accession")

# reactable ----
library(reactable)
options(reactable.theme = reactableTheme(
	borderColor = "#dfe2e5",
	stripedColor = "#E5E5E5",
	highlightColor = "#fcf0e6",
	cellPadding = "8px 12px",
	style = list(fontFamily = "-apple-system, Arial, BlinkMacSystemFont, Segoe UI, Helvetica,  sans-serif",
					 fontSize = "1.0rem"),
	searchInputStyle = list(width = "50%")
))



df_t <- 
	reactable( df,
				  compact = TRUE,
				  searchable = TRUE,
				  resizable = TRUE, 
				  # wrap = FALSE,
				  #elementId = "download-table",
				  defaultPageSize = 50,
				  filterable = TRUE,
				  showSortable = TRUE,
				  showPageSizeOptions = TRUE,
				  striped = TRUE,
				  highlight = TRUE,
				  defaultColDef = colDef(minWidth = 200),
				  columns = list(
				  	"SO.description" = colDef(minWidth = 350), 

				  	 "SO.accession" = colDef(cell = function(value, index) {
				  	 	url <- sprintf("http://www.sequenceontology.org/miso/current_svn/term/%s", df[index, "SO.accession"], value)
				  	 	htmltools::tags$a(href = url, target = "_blank", as.character(value))
				  	 }),

				  	"IMPACT" = colDef( minWidth = 150,
				  							 style = function(value) {
				  							 	if (value == "HIGH") {color <- "#339900" # green
				  							 	} else if (value == "MODERATE") {color <- "#fa7e1e" # orange
				  							 	} else if (value == "LOW") {color <- "#d62976" # pink
				  							 	} else if (value == "MODIFIER") {color <- "#962fbf" # yellow
				  							 	} else if (value == "XL") {color <- "#fa7e1e" # orange
				  							 	} else if (value == "XLR") {color <- "#fa7e1e" # orange
				  							 	} else if (value == "NA") {color <- "#339900" # green
				  							 	} else { color <- "black"}
				  							 	list(color = color) })
				  	)
				  )

df_t
