//
//  FBROffersFactory.m
//  Pods
//
//  Created by Daniel on 05/10/15.
//
//

#import "FBROffersFactory.h"
#import "FBROfferItem.h"

static NSString * const kOffersKey = @"offers";

static NSString * const kOfferTitleKey = @"title";
static NSString * const kOfferTeaserKey = @"teaser";
static NSString * const kOfferThumbnailKey = @"thumbnail";
static NSString * const kOfferThumbnailHighResolutionKey = @"hires";
static NSString * const kOfferPayoutKey = @"payout";

@implementation FBROffersFactory

+ (NSArray *)offersFromDictionary:(NSDictionary *)dictionary{
    
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *offers = dictionary[kOffersKey];
    
    for (NSDictionary *offerAsDictionary in offers){

        NSString *title = offerAsDictionary[kOfferTitleKey];
        NSString *teaser = offerAsDictionary[kOfferTeaserKey];
        NSString *thumbnailUrl = offerAsDictionary[kOfferThumbnailKey][kOfferThumbnailHighResolutionKey];
        NSUInteger payout = [offerAsDictionary[kOfferPayoutKey] integerValue];
        
        FBROfferItem *item = [FBROfferItem offerWithTitle:title
                                                   teaser:teaser
                                             thumbnailUrl:thumbnailUrl
                                                   payout:payout];
        
        [result addObject:item];
    }
    
    return result;
}

@end
