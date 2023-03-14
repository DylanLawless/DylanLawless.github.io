#  Main ----
library(pdftools)
library(dplyr)
require("tm")
library(stringr)

setwd("../pdfs")
system("gunzip ./*pdf.gz")

# loop ----
# myFiles <- list.files("./",  pattern = ".pdf")
# my_df <- character()


# for(i in myFiles){
	# # Extract the text for all pages
	# text <- pdf_text(i)
	# text <- text %>%
	# 
	# 	# str_split(pattern = "\n") %>%
	# 	unlist() %>%
	# 	trimws() %>%  # remove excess whitespace
	# 	as.data.frame() %>%	na.omit() 
	
	# my.corpus <- Corpus(DirSource("./corpus"))
	# getTransformations
	# my.corpus <- tm_map(my.corpus, removePunctuation)
	# my.corpus <- tm_map(my.corpus, removeWords, stopwords("english"))
	# my.stops <- c("history","clio", "programming")
	# my.corpus <- tm_map(my.corpus, removeWords, my.stops)
	# 
	# my.tdm <- TermDocumentMatrix(my.corpus)
	# inspect(my.tdm)
	# my.dtm <- DocumentTermMatrix(my.corpus, control = list(weighting = weightTfIdf, stopwords = TRUE))
	# inspect(my.dtm)
	# 
	# findFreqTerms(my.tdm, 2)
	# findAssocs(my.tdm, 'genetic', 0.20)
	# 
	# my.df <- as.data.frame(inspect(my.tdm))
	# my.df.scale <- scale(my.df)
	# d <- dist(my.df.scale,method="euclidean")
	# fit <- hclust(d, method="ward")
	# plot(fit)
# 	
# 	# my_out <- LETTERS[i]           # Create some output
# 	total_price <- i %>% as.data.frame() # source file name
# 	total_price$content <- text %>% as.data.frame() # source file name
# 	my_out <- total_price
# 	my_df <- rbind(my_df, my_out)
# 	
# }
# 
# x <- text %>% as.data.frame()  %>%
# 	mutate_if(is.character, str_trim)
# 
# head(x, 1)
# my_df
# my_df$CHF <- as.numeric(my_df$CHF)


# alernative ----

files <- list.files(pattern = "pdf$")
opinions <- lapply(files, pdf_text)
# install.packages("tm")
library(tm)
corp <- Corpus(URISource(files),
					readerControl = list(reader = readPDF))

# test to remove non-english
corp <- tm_map(corp, removeWords, stopwords("english"))

# cleanse text
corp = tm_map(corp,stripWhitespace)
corp = tm_map(corp,removeWords,stopwords("en"))
corp = tm_map(corp,removePunctuation)
corp = tm_map(corp,removeNumbers)

f <- content_transformer(function(x, pattern) gsub(pattern, "", x))
corp <- tm_map(corp, f, "[!\"#$%&'*+,./)(:;<=>?@][\\^`{|}~]")
# In the character class you have to escape the \, the " and the closing bracket ].



# The Corpus function creates a corpus. The first argument to Corpus is what we want to use to create the corpus. In this case, it’s the vector of PDF files. To do this, we use the URISource function to indicate that the files vector is a URI source. URI stands for Uniform Resource Identifier. In other words, we’re telling the Corpus function that the vector of file names identifies our resources. The second argument, readerControl, tells Corpus which reader to use to read in the text from the PDF files. That would be readPDF, a tm function. The readerControl argument requires a list of control parameters, one of which is reader, so we enter list(reader = readPDF). Finally we save the result to an object called “corp”.
# 
# It turns out that the readPDF function in the tm package actually creates a function that reads in PDF files. The documentation tells us it uses the pdftools::pdf_text function as the default, which is the same function we used above. (?readPDF)
# 
# Now that we have a corpus, we can create a term-document matrix, or TDM for short. A TDM stores counts of terms for each document. The tm package provides a function to create a TDM called TermDocumentMatrix.

# requires:
# install.packages("SnowballC")
opinions.tdm <- TermDocumentMatrix(corp, 
											  control = 
											  	list(removePunctuation = TRUE,
											  		  stopwords = TRUE,
											  		  tolower = TRUE,
											  		  stemming = TRUE,
											  		  removeNumbers = TRUE,
											  		  bounds = list(global = c(1, Inf)))) 

# The first argument is our corpus. The second argument is a list of control parameters. In our example we tell the function to clean up the corpus before creating the TDM. We tell it to remove punctuation, remove stopwords (eg, the, of, in, etc.), convert text to lower case, stem the words, remove numbers, and only count words that appear in at least 3 documents. We save the result to an object called “opinions.tdm”.
# 
# To inspect the TDM and see what it looks like, we can use the inspect function. Below we look at the first 10 terms:
# 	
inspect(opinions.tdm[1:10,]) 
findFreqTerms(opinions.tdm, lowfreq = 100, highfreq = Inf)
# To see the counts of those words we could save the result and use it to subset the TDM. Notice we have to use as.matrix to see the print out of the subsetted TDM.

ft <- findFreqTerms(opinions.tdm, lowfreq = 100, highfreq = Inf)
as.matrix(opinions.tdm[ft,]) 

# To see the total counts for those words, we could save the matrix and apply the sum function across the rows:
	
ft.tdm <- as.matrix(opinions.tdm[ft,])
sort(apply(ft.tdm, 1, sum), decreasing = TRUE)

# return to my original code

my.tdm  <- opinions.tdm 


x



# my.tdm <- TermDocumentMatrix(my.corpus)
# inspect(my.tdm)

my.dtm <- DocumentTermMatrix(corp, 
						 control = 
						 	list(weighting = weightTfIdf,
						 		  removePunctuation = TRUE,
						 		  stopwords = TRUE,
						 		  tolower = TRUE,
						 		  stemming = TRUE,
						 		  removeNumbers = TRUE,
						 		  bounds = list(global = c(1, Inf)))) 
inspect(my.dtm)











library(lubridate)
library(tidyr)
library(ggplot2)

# Document analysis ----

# my original code:
# my.corpus <- Corpus(DirSource("../src/corpus"))
# getTransformations
# my.corpus <- tm_map(my.corpus, removePunctuation)
# my.corpus <- tm_map(my.corpus, removeWords, stopwords("english"))
# my.stops <- c("history","clio", "programming")
# my.corpus <- tm_map(my.corpus, removeWords, my.stops)

# NOTES START
# my.list <- unlist(read.table("PATH TO STOPWORD FILE", stringsAsFactors=FALSE))
# my.stops <- c(my.list)
# my.corpus <- tm_map(my.corpus, removeWords, my.stops)

# Our results will be more useful if we can lemmatize our corpus. Instead of counting “run” and “runs”, for instance, as 2 separate words, we want to count them as the same word. To lemmatize the corpus means to change all variants of words into the same stem word.
# To do this, we need another package to help with the lemmatizing. But we can use tm_map in way we’ve already done.
# install("Snowball")
# require("Snowball")
# my.corpus <- tm_map(my.corpus, stemDocument)

# NOTES END
# my.tdm <- TermDocumentMatrix(my.corpus)

inspect(my.dtm)

library(MASS)
head(my.dtm)


# wdbc.pr <- prcomp(my.dtm, center = TRUE, scale = TRUE)
wdbc.pr <- prcomp(my.dtm, center = TRUE)
summary(wdbc.pr)

screeplot(wdbc.pr, type = "l", npcs = 20, main = "Screeplot of the first 10 PCs")
abline(h = 1, col="red", lty=5)
legend("topright", legend=c("Eigenvalue = 1"),
		 col=c("red"), lty=5, cex=0.6)
cumpro <- cumsum(wdbc.pr$sdev^2 / sum(wdbc.pr$sdev^2))
plot(cumpro[0:15], xlab = "PC #", ylab = "Amount of explained variance", main = "Cumulative variance plot")
abline(v = 6, col="blue", lty=5)
abline(h = 0.88759, col="blue", lty=5)
legend("topleft", legend=c("Cut-off @ PC6"),
		 col=c("blue"), lty=5, cex=0.6)

plot(wdbc.pr$x[,1],wdbc.pr$x[,2], xlab="PC1 (44.3%)", ylab = "PC2 (19%)", main = "PC1 / PC2 - plot")

library("factoextra")
fviz_pca_ind(wdbc.pr)
temp <- head(wdbc.pr) 

# viz <- fviz_pca_ind(wdbc.pr, geom.ind = "point", pointshape = 21, 
# 				 pointsize = 2, 
# 				 fill.ind = rownames(wdbc.pr$x), 
# 				 col.ind = "black", 
# 				 addEllipses = TRUE,
# 				 label = "var",
# 				 col.var = "black",
# 				 repel = TRUE,
# 				 legend.title = "Diagnosis") +
# 	ggtitle("2D PCA-plot from 30 feature dataset") +
# 	theme(plot.title = element_text(hjust = 0.5))

# alternative
pca_res <- prcomp(my.dtm, center = TRUE, scale = TRUE)
pca_res <- prcomp(my.dtm, center = TRUE)
var_explained <- pca_res$sdev^2/sum(pca_res$sdev^2)

library(dplyr)
pca_res_x <- pca_res$x %>% as.data.frame()
pca_res_x$Var <- ( row.names(pca_res_x))

library(ggplot2)
p2AL <- pca_res_x %>% 
	ggplot(aes(x=PC1,y=PC2, label=Var)) +
	geom_label(aes(fill = Var), colour = "white", size = 2, alpha=0.7, 
				  position=position_jitter(width=0.03,height=0.03)
	)+
	labs(x=paste0("PC1: ",round(var_explained[1]*100,1),"%"),
		  y=paste0("PC2: ",round(var_explained[2]*100,1),"%"))

p2A <- pca_res_x %>% 
	ggplot(aes(x=PC1,y=PC2, label=Var)) +
	geom_point(aes(color = Var, alpha=0.7) ) +
	labs(x=paste0("PC1: ",round(var_explained[1]*100,1),"%"),
		  y=paste0("PC2: ",round(var_explained[2]*100,1),"%"))


library(factoextra)
p2B <- fviz_pca_ind(pca_res, col.ind = "cos2", # Color by the quality of representation
						  gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
						  max.overlaps = 15,
						  repel = TRUE     # Avoid text overlapping
) 

p2C <- fviz_eig(pca_res)
# get_eig(pca_res) 


library(cowplot)
mid_row <- plot_grid(p2B, p2C, labels = c('B'), ncol = 2)
bottom_row <- plot_grid(p2AL, p2A, labels = c('C'), ncol = 2)
plot <- plot_grid(mid_row, bottom_row, labels = c('', '', ''), ncol = 1)

ggdraw(add_sub(vjust = 0.5, plot,
					"(A) Genotype matrix.\n(B) PCA variance explained per Individual [typical]\n(C) PCA variance explained per Position [rotated matrix].\nPCAs (left) are manually derived from pca_res$sdev^2/sum(pca_res$sdev^2).\nPCAs (center) are made by fviz_pca_ind. (jitter added)"))
#15x10

# To split ID name _ filename
