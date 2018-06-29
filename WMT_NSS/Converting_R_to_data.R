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
df_14 <- readRDS('private/health_and_business_cats.RDS2') 
df_15 <- readRDS('private/health_and_business_cats.RDS3') 

##############################################################################
#################  Cleaning data into useful format ##########################
################        for processing in Python     #########################
##############################################################################

df <- data.frame(matrix(ncol=8, nrow=0))
df_1 <- data.frame(df_1$name, df_1$categoryPath, df_1$shortDescription, df_1$longDescription, df_1$modelNumber, df_1$categoryNode, df_1$itemId, df_1$parentItemId, stringsAsFactors=FALSE)
df_2 <- data.frame(df_2$name, df_2$categoryPath, df_2$shortDescription, df_2$longDescription, df_2$modelNumber, df_2$categoryNode, df_2$itemId, df_2$parentItemId, stringsAsFactors=FALSE)
df_3 <- data.frame(df_3$name, df_3$categoryPath, df_3$shortDescription, df_3$longDescription, df_3$modelNumber, df_3$categoryNode, df_3$itemId, df_3$parentItemId, stringsAsFactors=FALSE)
df_4 <- data.frame(df_4$name, df_4$categoryPath, df_4$shortDescription, df_4$longDescription, df_4$modelNumber, df_4$categoryNode, df_4$itemId, df_4$parentItemId, stringsAsFactors=FALSE)
df_5 <- data.frame(df_5$name, df_5$categoryPath, df_5$shortDescription, df_5$longDescription, df_5$modelNumber, df_5$categoryNode, df_5$itemId, df_5$parentItemId, stringsAsFactors=FALSE)
df_6 <- data.frame(df_6$name, df_6$categoryPath, df_6$shortDescription, df_6$longDescription, df_6$modelNumber, df_6$categoryNode, df_6$itemId, df_6$parentItemId, stringsAsFactors=FALSE)
df_7 <- data.frame(df_7$name, df_7$categoryPath, df_7$shortDescription, df_7$longDescription, df_7$modelNumber, df_7$categoryNode, df_7$itemId, df_7$parentItemId, stringsAsFactors=FALSE)
df_8 <- data.frame(df_8$name, df_8$categoryPath, df_8$shortDescription, df_8$longDescription, df_8$modelNumber, df_8$categoryNode, df_8$itemId, df_8$parentItemId, stringsAsFactors=FALSE)
df_9 <- data.frame(df_9$name, df_9$categoryPath, df_9$shortDescription, df_9$longDescription, df_9$modelNumber, df_9$categoryNode, df_9$itemId, df_9$parentItemId, stringsAsFactors=FALSE)
df_10 <- data.frame(df_10$name, df_10$categoryPath, df_10$shortDescription, df_10$longDescription, df_10$modelNumber, df_10$categoryNode, df_10$itemId, df_10$parentItemId, stringsAsFactors=FALSE)
df_11 <- data.frame(df_11$name, df_11$categoryPath, df_11$shortDescription, df_11$longDescription, df_11$modelNumber, df_11$categoryNode, df_11$itemId, df_11$parentItemId, stringsAsFactors=FALSE)
df_12 <- data.frame(df_12$name, df_12$categoryPath, df_12$shortDescription, df_12$longDescription, df_12$modelNumber, df_12$categoryNode, df_12$itemId, df_12$parentItemId, stringsAsFactors=FALSE)
df_13 <- data.frame(df_13$name, df_13$categoryPath, df_13$shortDescription, df_13$longDescription, df_13$modelNumber, df_13$categoryNode, df_13$itemId, df_13$parentItemId, stringsAsFactors=FALSE)
df_14 <- data.frame(df_14$name, df_14$categoryPath, df_14$shortDescription, df_14$longDescription, df_14$modelNumber, df_14$categoryNode, df_14$itemId, df_14$parentItemId, stringsAsFactors=FALSE)
df_15 <- data.frame(df_15$name, df_15$categoryPath, df_15$shortDescription, df_15$longDescription, df_15$modelNumber, df_15$categoryNode, df_15$itemId, df_15$parentItemId, stringsAsFactors=FALSE)


colname_list <- c("name", "categoryPath", "shortDn", "longDn", "model", "catNode", "itemId","parentItemId")

colnames(df) <- colname_list
colnames(df_1) <- colname_list
colnames(df_2) <- colname_list
colnames(df_3) <- colname_list
colnames(df_4) <- colname_list
colnames(df_5) <- colname_list
colnames(df_6) <- colname_list
colnames(df_7) <- colname_list
colnames(df_8) <- colname_list
colnames(df_9) <- colname_list
colnames(df_10) <- colname_list
colnames(df_11) <- colname_list 
colnames(df_12) <- colname_list 
colnames(df_13) <- colname_list 
colnames(df_14) <- colname_list 
colnames(df_15) <- colname_list 


#--- formatting data so HTML tags appear ==> easier to replace
library(XML)

#--- function to replace text with HTML tags
html2txt <- function(str) {
  xpathApply(htmlParse(str, asText=TRUE, encoding = ),
             "//body//text()", 
             xmlValue)[[1]] 
  }

#### processing each df individually ####
for (row in 1:nrow(df_1)){
  df_1$shortDn[row] <- html2txt(df_1$shortDn[row])
  df_1$longDn[row] <- html2txt(df_1$longDn[row])
}

for (row in 1:nrow(df_2)){
  df_2$shortDn[row] <- html2txt(df_2$shortDn[row])
  df_2$longDn[row] <- html2txt(df_2$longDn[row])
}

for (row in 1:nrow(df_3)){
  df_3$shortDn[row] <- html2txt(df_3$shortDn[row])
  df_3$longDn[row] <- html2txt(df_3$longDn[row])
}

for (row in 1:nrow(df_4)){
  df_4$shortDn[row] <- html2txt(df_4$shortDn[row])
  df_4$longDn[row] <- html2txt(df_4$longDn[row])
}

for (row in 1:nrow(df_5)){
  df_5$shortDn[row] <- html2txt(df_5$shortDn[row])
  df_5$longDn[row] <- html2txt(df_5$longDn[row])
}

for (row in 1:nrow(df_6)){
  df_6$shortDn[row] <- html2txt(df_6$shortDn[row])
  df_6$longDn[row] <- html2txt(df_6$longDn[row])
}

for (row in 1:nrow(df_7)){
  df_7$shortDn[row] <- html2txt(df_7$shortDn[row])
  df_7$longDn[row] <- html2txt(df_7$longDn[row])
}

for (row in 1:nrow(df_8)){
  df_8$shortDn[row] <- html2txt(df_8$shortDn[row])
  df_8$longDn[row] <- html2txt(df_8$longDn[row])
}

for (row in 1:nrow(df_9)){
  df_9$shortDn[row] <- html2txt(df_9$shortDn[row])
  df_9$longDn[row] <- html2txt(df_9$longDn[row])
}

for (row in 1:nrow(df_10)){
  df_10$shortDn[row] <- html2txt(df_10$shortDn[row])
  df_10$longDn[row] <- html2txt(df_10$longDn[row])
}

for (row in 1:nrow(df_11)){
  df_11$shortDn[row] <- html2txt(df_11$shortDn[row])
  df_11$longDn[row] <- html2txt(df_11$longDn[row])
} 

for (row in 1:nrow(df_12)){
  df_12$shortDn[row] <- html2txt(df_12$shortDn[row])
  df_12$longDn[row] <- html2txt(df_12$longDn[row])
} 

for (row in 1:nrow(df_13)){
  df_13$shortDn[row] <- html2txt(df_13$shortDn[row])
  df_13$longDn[row] <- html2txt(df_13$longDn[row])
}

for (row in 1:nrow(df_14)){
  df_14$shortDn[row] <- html2txt(df_14$shortDn[row])
  df_14$longDn[row] <- html2txt(df_14$longDn[row])
}

for (row in 1:nrow(df_15)){
  df_15$shortDn[row] <- html2txt(df_15$shortDn[row])
  df_15$longDn[row] <- html2txt(df_15$longDn[row])
}

df <- rbind(df_1, df_2, df_3, df_4, df_5, df_6, df_7, df_8, df_9, df_10, df_11, df_12, df_13, df_14, df_15) #combining all dfs 
df <- unique(df)  #removing dupes

## removing pipes from any data to ensure pipe delimited is clean ##
df[] <- lapply(df, gsub, pattern = "|", replacement = "", fixed = TRUE)

#### write to csv ####
write.table(df_1, 'private/small_R_df.csv', sep='|')
write.table(df, 'private/R_df_to_csv.csv', sep='|')


