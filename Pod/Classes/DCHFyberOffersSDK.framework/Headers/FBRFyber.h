//
//  FBRFyber.h
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import <Foundation/Foundation.h>

#import <DCHFyberOffersSDK/FBRGenericBlocks.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Class that holds the configurations for the Fyber SDK.
 * Provides convenience methods to configure and start the SDK.
 *
 * Calling the withAPIKey method on will start the FairBid SDK.
 *
 * After starting the SDK, all parameters used to configure the FairBid SDK will remain immutable.
 */

@class FBRParams;

@interface FBRFyber : NSObject

+ (instancetype)withAPIKey:(NSString *)apiToken;

+ (instancetype)sharedInstance;

- (void)offersForParams:(FBRParams *)params
                success:(FBROffersSuccess)success
                failure:(FBRFailure)failure;

@end

NS_ASSUME_NONNULL_END
