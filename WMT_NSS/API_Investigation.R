library(jsonlite)         # Convert R objects to/from JSON
library(plyr)             # Tools for Splitting, Applying and Combining Data

#WMT API Key: [enter API key]
# For Taxonomy API, the only parameter you need to specify is "format" (either json or 
taxonomy_url <- "http://api.walmartlabs.com/v1/taxonomy?format=json&apiKey=[enter API key]"
tax_list <- jsonlite::read_json(taxonomy_url)

# Return 31 categories as of 5/22/18
length(tax_list$categories)
df = data.frame(Parent_Category = character(0))

# Create a taxonomy dataframe containing parent category id, parent category title, and total number of related categories
for (j in (1:length(tax_list$categories))){
  k1 = tax_list$categories[[j]]$id
  k2 = tax_list$categories[[j]]$name
  k3 = length(tax_list$categories[[j]]$children)
  df2 <- data.frame(Parent_Category_ID = k1,
                    Parent_Category_Title= k2,
                    Total_Related_Category = k3)
  df <- rbind(df, df2)
}
rm(df2)
head(df, 5)

df[[5,3]] #--- 50 sub-categories for books


#####################################################################
##  identifying all sub-categories of books (50 categories, 1287)  ##
#####################################################################
df_book_cats <- data.frame(cat=character(), cat_id=character(), sub_cat=character(), sub_id=character(), stringsAsFactors=FALSE)

count <- 0    # start at one and increment immediately to skip NULL values from header
for (i in (1:(df[[5,3]]))){
  count <- count + 1
  a <- tax_list$categories[[5]]$children[[count]]$name
  a1 <- tax_list$categories[[5]]$children[[count]]$id
  #  print(paste0("count ",a))
  #  df_book_cats[nrow(df_book_cats) + 1,] = c(a,a1)
  count_sub <- 0
  for (j in (1:length(tax_list$categories[[5]]$children[[count]]$children))){
    count_sub <- count_sub + 1
    b <- tax_list$categories[[5]]$children[[count]]$children[[count_sub]]$name
    b1 <- tax_list$categories[[5]]$children[[count]]$children[[count_sub]]$id
    #    print(paste0("count sub ",b))
    df_book_cats[nrow(df_book_cats) + 1,] = c(a,a1,b,b1)
  }
}

# remove any dupes 
df_book_cats <- unique(df_book_cats)

cat_list <- unique(df_book_cats$cat_id) #length 50
sub_cat_list <- unique(df_book_cats$sub_id) #length  1286 

rownames(df_book_cats) <- NULL 

saveRDS(df_book_cats, file="df_book_cats.RDS")
saveRDS(df, file="df.RDS")



#####################################################################
#####################################################################
#                           exploratory fun                         #
#####################################################################
#####################################################################
#Book Category is 3920 (pulled from taxonomy list). Finding item IDs, trying to find mapping to 978
books_url <- "http://api.walmartlabs.com/v1/paginated/items?category=3920_5867480&apiKey=[enter API key]&format=json"
book_list <- jsonlite::read_json(books_url)

#lookup item ID from book_list, try to find 978
cat_url <- "http://api.walmartlabs.com/v1/items/189609?apiKey=[enter API key]&format=json"
cat_test <- jsonlite::read_json(cat_url)

#trending items, limited to 25
trending_url <- "http://api.walmartlabs.com/v1/trends?apiKey=[enter API key]&format=json"
trending <- jsonlite::read_json(trending_url)

#Best Sellers in their respective categories (Books = 3920)
best_url <- "http://api.walmartlabs.com/v1/feeds/bestsellers?apikey=[enter API key]&amp;categoryId=3920"
best_sellers <- jsonlite::read_json(best_url)

