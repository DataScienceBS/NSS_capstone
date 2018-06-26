library(jsonlite)         # Convert R objects to/from JSON
library(plyr)             # Tools for Splitting, Applying and Combining Data

df_book_cats <- readRDS('df_book_cats.RDS')
sub_cat_list <- unique(df_book_cats$sub_id)

##############################################################################
################  API and data exploration complete. #########################
################   Pulling catalog data for project. #########################
##############################################################################
library(jsonlite)         # Convert R objects to/from JSON
library(plyr)             # Tools for Splitting, Applying and Combining Data

accumulator = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", 
                "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z")

#creating large df
full_search = data.frame(itemId = character(0), 
                         name= character(0), 
                         msrp = character(0),
                         salePrice = character(0),
                         upc = character(0),
                         categoryPath = character(0),
                         shortDescription = character(0),
                         longDescription= character(0), 
                         brandName= character(0), 
                         thumbnailImage = character(0),
                         mediumImage = character(0),
                         largeImage = character(0),
                         productTrackingUrl = character(0),
                         ninetySevenCentShipping = character(0),
                         standardShipRate= character(0), 
                         size= character(0), 
                         color = character(0),
                         marketplace = character(0),
                         shipToStore = character(0),
                         freeShipToStore = character(0),
                         modelNumber = character(0),
                         productUrl= character(0), 
                         customerRating= character(0), 
                         numReviews = character(0),
                         variants = character(0),
                         customerRatingImage = character(0),
                         categoryNode = character(0),
                         bundle = character(0),
                         clearance= character(0), 
                         preOrder= character(0), 
                         stock = character(0),
                         attributes = character(0),
                         addToCartUrl = character(0),
                         affiliateAddToCartUrl = character(0),
                         freeShippingOver50Dollars = character(0),
                         maxItemsInOrder = character(0),
                         giftOptions = character(0),
                         imageEntities = character(0),
                         offerType = character(0),
                         isTwoDayShippingEligible = character(0), 
                         availableOnline= character(0),
                         parentItemId = character(0),
                         sellerInfo = character(0),
                         seeDetailsInCart = character(0)
)

count <- 0
for(cat in sub_cat_list[1278:1286]){
  for (j in (1:length(accumulator))){
    url <- paste('http://api.walmartlabs.com/v1/search?query=', accumulator[j], 
                 '&format=json&categoryId=', cat, '&apiKey=a8yt7dtv7vjgtq8waassmhra&numItems=25', sep = "")
    for (m in url){
      query_list = jsonlite::read_json(m)
      iterator = plyr::rbind.fill(lapply(query_list$items, function(y){as.data.frame(t(y),stringsAsFactors=FALSE)}))
      full_search = plyr::rbind.fill(full_search, iterator)
      Sys.sleep(1.0)
      count <- count+1
      print(count)
      print(cat)
    }
  }
}  # restart at 3920_1068785_6743200 (1211) 

##########################
##########################
#  API processing notes  #
##########################
##########################
# failed: http://api.walmartlabs.com/v1/search?query=a&format=json&categoryId=3920_582053_582578&apiKey=a8yt7dtv7vjgtq8waassmhra&numItems=25
# failed: http://api.walmartlabs.com/v1/search?query=l&format=json&categoryId=3920_582053_5316522&apiKey=a8yt7dtv7vjgtq8waassmhra&numItems=25
# failed: http://api.walmartlabs.com/v1/search?query=g&format=json&categoryId=3920_582053_585924&apiKey=a8yt7dtv7vjgtq8waassmhra&numItems=25
# invalid category IDs: 3920_582374_8324310, 3920_582507_6060018, 3920_582507_4284269
#  which(sub_cat_list=="3920_1068785_3135019")

full_search <- unique(full_search)
typeof(full_search)

saveRDS(full_search, file="private/full_search_6_25.RDS")

#lapply(full_search, function(x) write.table( data.frame(x), 'full_search_6_16.csv'  , append= T, sep=',' ))
#lapply(df_614, function(x) write.table( data.frame(x), 'test_6_14.csv'  , append= T, sep=',' ))

#df <- data.frame(df_614)
#write.table(as.data.frame(df_614),file="df_test.csv", quote=F,sep=",",row.names=T)
#library(data.table)
#df <- do.call(rbind, df_614)
#df <- setDF(df_614)
#library(qdap)
##df <- list_df2df(df_614)
