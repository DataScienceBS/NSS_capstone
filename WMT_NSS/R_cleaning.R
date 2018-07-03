library(tidytext) #text mining, unnesting
library(topicmodels) #the LDA algorithm
library(tidyr) #gather()
library(dplyr) #awesome tools
library(ggplot2) #visualization
library(kableExtra) #create attractive tables
library(knitr) #simple table generator
library(ggrepel) #text and label geoms for ggplot2
library(gridExtra)
library(formattable) #color tile and color bar in `kables`
library(tm) #text mining
library(circlize) #already loaded, but just being comprehensive
library(plotly) #interactive ggplot graphs

df_backup <- read.csv("private/R_data_for_LDA.csv", sep='|', stringsAsFactors = FALSE)

df <- df_backup %>% 
  select(name, sub_cat, longDn, shortDn)

#viewing text of the long description
str(df[5, ]$longDn, nchar.max = 300)

fix.contractions <- function(doc) {
  # "won't" is a special case as it does not expand to "wo not"
  doc <- gsub("won't", "will not", doc)
  doc <- gsub("can't", "can not", doc)
  doc <- gsub(" n t", " not", doc)
  doc <- gsub(" ll", " will", doc)
  doc <- gsub(" re", " are", doc)
  doc <- gsub(" ve", " have", doc)
  doc <- gsub(" m", " am", doc)
  doc <- gsub(" d", " would", doc)
  doc <- gsub("\\s+", " ", doc)
  # 's could be 'is' or could be possessive: it has no expansion
  doc <- gsub("'s", "", doc)
  return(doc)
}

df$longDn <- sapply(df$longDn, fix.contractions)
df$shortDn <- sapply(df$shortDn, fix.contractions)
df$name <- sapply(df$name, fix.contractions)

# function to remove special characters
removeSpecialChars <- function(x) gsub("[^a-zA-Z0-9 ]", " ", x)

df$longDn <- sapply(df$longDn, removeSpecialChars)
df$shortDn <- sapply(df$shortDn, removeSpecialChars)
df$name <- sapply(df$name, removeSpecialChars)

df$longDn <- sapply(df$longDn, tolower)
df$shortDn <- sapply(df$shortDn, tolower)
df$name <- sapply(df$name, tolower)

#viewing text of the long description, POST cleanup
str(df[5, ]$longDn, nchar.max = 300)

#### manual stop words ####
undesirable_words <- c('book', 'version', 'edition')
  
df_filtered <- df %>%
  unnest_tokens(word, longDn) %>%
  anti_join(stop_words) %>%       #remove stop words
  distinct() %>%                  #unique only
  filter(!word %in% undesirable_words) %>%  #remove manual stop words
  filter(nchar(word) > 3)


corp <- Corpus(VectorSource(df_filtered))
corp <- tm_map(corp, tolower)
corp <- tm_map(corp, removePunctuation)
corp <- tm_map(corp, removeWords, stopwords("english"))
dtm <- DocumentTermMatrix(corp)
freq <- colSums(as.matrix(dtm))
ordered_freq <- order(freq)
top_20 <- freq[tail(ordered_freq, n=20)]


#### start exploration ####
# sources_tidy_balanced %>%
#   group_by(sub_cat) %>%
#   mutate(word_count = n()) %>%
#   select(sub_cat, word_count) %>% #only need these fields
#   distinct() %>%
#   ungroup() %>%
#   #assign color bar for word_count that varies according to size
#   #create static color for source and genre
#   mutate(word_count = color_bar("lightpink")(word_count),
#          sub_cat = color_tile("lightgreen","lightgreen")(sub_cat)) %>%
#   my_kable_styling("Category Stats")



#define colors to use throughout
my_colors <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#D55E00", "#D65E00")

#customize ggplot2's default theme settings
theme_lyrics <- function(aticks = element_blank(),
                         pgminor = element_blank(),
                         lt = element_blank(),
                         lp = "none")
{
  theme(plot.title = element_text(hjust = 0.5), #center the title
        axis.ticks = aticks, #set axis ticks to on or off
        panel.grid.minor = pgminor, #turn on or off the minor grid lines
        legend.title = lt, #turn on or off the legend title
        legend.position = lp) #turn on or off the legend
}

#customize the text tables for consistency using HTML formatting
my_kable_styling <- function(dat, caption) {
  kable(dat, "html", escape = FALSE, caption = caption) %>%
    kable_styling(bootstrap_options = c("striped", "condensed", "bordered"),
                  full_width = FALSE)
}

#### defining the word chart ####
word_chart <- function(data, input, title) {
  data %>%
    #set y = 1 to just plot one variable and use word as the label
    ggplot(aes(as.factor(row), 1, label = input, fill = factor(topic) )) +
    #you want the words, not the points
    geom_point(color = "transparent") +
    #make sure the labels don't overlap
    geom_label_repel(nudge_x = .2,  
                     direction = "y",
                     box.padding = 0.1,
                     segment.color = "transparent",
                     size = 3) +
    facet_grid(~topic) +
    theme_lyrics() +
    theme(axis.text.y = element_blank(), axis.text.x = element_blank(),
          #axis.title.x = element_text(size = 9),
          panel.grid = element_blank(), panel.background = element_blank(),
          panel.border = element_rect("lightgray", fill = NA),
          strip.text.x = element_text(size = 9)) +
    labs(x = NULL, y = NULL, title = title) +
    #xlab(NULL) + ylab(NULL) +
    #ggtitle(title) +
    coord_flip()
}

