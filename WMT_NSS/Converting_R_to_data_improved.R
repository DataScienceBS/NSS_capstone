library(jsonlite)         # Convert R objects to/from JSON
library(plyr)             # Tools for Splitting, Applying and Combining Data

df_1 <- readRDS('private/full_search_6_14.RDS')
df_2 <- readRDS('private/full_search_6_16.RDS')
df_3 <- readRDS('private/full_search_6_18.RDS')
df_4 <- readRDS('private/full_search_6_19.RDS')
df_5 <- readRDS('private/full_search_6_19b.RDS')
df_6 <- readRDS('private/full_search_6_20.RDS')
df_7 <- readRDS('private/full_search_6_21.RDS')
df_8 <- readRDS('private/full_search_6_21c.RDS')
df_9 <- readRDS('private/full_search_6_22.RDS')
df_10 <- readRDS('private/full_search_6_23.RDS')
df_11 <- readRDS('private/full_search_6_23b.RDS') 
df_12 <- readRDS('private/full_search_6_25.RDS') 
df_13 <- readRDS('private/health_and_business_cats.RDS') 
df_14 <- readRDS('private/health_and_business_cats2.RDS') 
df_15 <- readRDS('private/health_and_business_cats3.RDS') 
df_16 <- readRDS('private/06-28_history.RDS') 
df_17 <- readRDS('private/06-30_biographies_computers.RDS') 
df_18 <- readRDS('private/06-30_computers.RDS') 
df_19 <- readRDS('private/07-01_law.RDS')
df_20 <- readRDS('private/07-01_language_art_humor.RDS')

#combining all dfs 
df <- rbind(df_1, df_2, df_3, df_4, df_5, df_6, df_7, df_8, df_9, df_10, 
            df_11, df_12, df_13, df_14, df_15, df_16, df_17, df_18, df_19, df_20) 

df <- data.frame(df$name, df$categoryPath, df$shortDescription, df$longDescription, df$modelNumber, df$categoryNode, df$itemId, df$parentItemId, stringsAsFactors=FALSE)
df <- unique(df)

colname_list <- c("name", "categoryPath", "shortDn", "longDn", "model", "catNode", "itemId","parentItemId")
colnames(df) <- colname_list

##############################################################################
#################  Cleaning data into useful format ##########################
################        for processing in Python     #########################
##############################################################################


#--- formatting data so HTML tags appear ==> easier to replace
library(XML)

#--- function to replace text with HTML tags
html2txt <- function(str) {
  xpathApply(htmlParse(str, asText=TRUE, encoding = ),
             "//body//text()", 
             xmlValue)[[1]] 
  }

#### processing each df individually ####
for (row in 1:nrow(df)){
  #df$shortDn[row] <- html2txt(df$shortDn[row]) #not using short description yet
  df$longDn[row] <- html2txt(df$longDn[row])
}


## removing pipes from any data to ensure pipe delimited is clean ##
df[] <- lapply(df, gsub, pattern = "|", replacement = "", fixed = TRUE)

#### write to csv ####
write.table(df, 'private/big_df_v2.csv', sep='|')
