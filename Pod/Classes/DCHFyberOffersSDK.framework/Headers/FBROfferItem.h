//
//  FBROfferItem.h
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBROfferItem : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *teaser;
@property (nonatomic, copy, readonly) NSString *thumbnailUrl;
@property (nonatomic, assign, readonly) NSUInteger payout;

+ (instancetype)offerWithTitle:(NSString *)title
                        teaser:(NSString *)teaser
                  thumbnailUrl:(NSString *)thumbnailUrl
                        payout:(NSUInteger)payout;
@end

NS_ASSUME_NONNULL_END
