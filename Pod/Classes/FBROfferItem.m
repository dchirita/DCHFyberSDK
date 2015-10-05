//
//  FBROfferItem.m
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import "FBROfferItem.h"

@implementation FBROfferItem

- (instancetype)initWithOfferWithTitle:(NSString *)title
                        teaser:(NSString *)teaser
                  thumbnailUrl:(NSString *)thumbnailUrl
                        payout:(NSUInteger)payout{
    self = [super init];
    
    if (self){
        _title = [title copy];
        _teaser = [teaser copy];
        _thumbnailUrl = [thumbnailUrl copy];
        _payout = payout;
    }
    
    return self;
}

+ (instancetype)offerWithTitle:(NSString *)title
                        teaser:(NSString *)teaser
                  thumbnailUrl:(NSString *)thumbnailUrl
                        payout:(NSUInteger)payout{
    return [[[self class] alloc] initWithOfferWithTitle:title
                                                 teaser:teaser
                                           thumbnailUrl:thumbnailUrl
                                                 payout:payout];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"----------OFFER----------\n"
                                      @"Title:%@\n"
                                      @"Teaser:%@\n"
                                      @"ThumbnailUrl:%@\n"
                                      @"Payout:%lu\n"
                                      @"--------------------------\n",
                                      self.title, self.teaser, self.thumbnailUrl, (unsigned long)self.payout];
}

@end
