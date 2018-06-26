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
####add new df here####

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

####add new df here####
#df_12 <- data.frame(df_12$name, df_12$categoryPath, df_12$shortDescription, df_12$longDescription, df_12$modelNumber, df_12$categoryNode, df_12$itemId, df_12$parentItemId, stringsAsFactors=FALSE)

df_list <- c("df_1", "df_2", "df_3", "df_4", "df_5", "df_6", "df_7", "df_8", "df_9", "df_10", "df_11", "df_12")
colname_list <- c("name", "categoryPath", "shortDn", "longDn", "model", "catNode", "itemId","parentItemId")

# for(df_name in df_list){
#   colnames(df_name) <- colname_list
# }

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

####add new df here####

#cleanFun <- function(htmlString) {
#  return(gsub("<.*?>", "", htmlString))
#}

#tag_test <- gsub("<.*?>", "", df_1$longDn[3])

#--- formatting data so HTML tags appear ==> easier to replace
library(XML)

#################### to be deleted ####################
df_temp <- df_1[1:5,]
tag_test <- df_temp$longDn[3]
#################### to be deleted ####################

#--- function to replace text with HTML tags
html2txt <- function(str) {
  xpathApply(htmlParse(str, asText=TRUE, encoding = ),
             "//body//text()", 
             xmlValue)[[1]] 
}


#### testing for loop on 5 rows
# df_temp <- df_1[1:5,]
# 
# for (row in 1:nrow(df_temp)){
#   df_temp$longDn[row] <- html2txt(df_temp$longDn[row])
# }
# print(df_temp$longDn[3])

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

####add new df here####

####add new df here####
df <- rbind(df_1, df_2, df_3, df_4, df_5, df_6, df_7, df_8, df_9, df_10, df_11, df_12) #combining all dfs 
df <- unique(df)  #removing dupes

## removing pipes from any data to ensure pipe delimited is clean ##
df[] <- lapply(df, gsub, pattern = "|", replacement = "", fixed = TRUE)

#df$longDn = gsub("\\|", "", df$longDn)

#### write to csv ####
write.table(df_1, 'private/small_R_df.csv', sep='|')
write.table(df, 'private/R_df_to_csv.csv', sep='|')


