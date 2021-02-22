//
//  FBRParams.h
//  DCHFyberOffersSDK
//
//  Created by Daniel on 20/02/2021.
//

#import <Foundation/Foundation.h>

#import <DCHFyberOffersSDK/OfferType.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBRParams : NSObject

- (instancetype)initWithAppId:(NSString *)appId
                       userId:(NSString *)userId
                    offerType:(OfferType)offerType;

@property (nonatomic, copy, readonly) NSString *appId;
@property (nonatomic, copy, readonly) NSString *userId;
@property (nonatomic, assign, readonly) OfferType offerType;

@end

NS_ASSUME_NONNULL_END
