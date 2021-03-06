library(jsonlite)         # Convert R objects to/from JSON
library(plyr)             # Tools for Splitting, Applying and Combining Data

df_book_cats <- readRDS('df_book_cats.RDS')
sub_cat_list <- unique(df_book_cats$sub_id)

##############################################################################
################  API and data exploration complete. #########################
################   Pulling catalog data for project. #########################
##############################################################################

####                   API requires query text.                  ####
# Creating 26 unique accumulators to loop through each sub category #
#    this allows for more titles to populate each major category    #
accumulator = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", 
                "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z")

#### creating large blank df ####
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
for(cat in sub_cat_list[235:250]){
  for (j in (1:length(accumulator))){
    Sys.sleep(0.5)
    url <- paste('http://api.walmartlabs.com/v1/search?query=', accumulator[j], 
                 '&format=json&categoryId=', cat, '&apiKey=[enter API key]&numItems=25', sep = "")
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
}  # Language/art 599:624 , humor 235:250


#  which(sub_cat_list=="3920_1952589_3409657")

full_search <- unique(full_search) #removing duplicates (likely from restarting failed API)
saveRDS(full_search, file="private/07-01_language_art_humor.RDS")
