//
//  FBRFyber.h
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import <Foundation/Foundation.h>
#import "FBRGenericBlocks.h"

FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterFormat; //Mandatory
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterAppId; //Mandatory
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterUID; //Mandatory
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterLocale; //Mandatory
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterOSVersion; //Mandatory
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterTimestamp; //Mandatory
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterHashkey; //Mandatory
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterAppleIdfa; //Mandatory
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterAppleIdfaTrackingEnabled; //Mandatory
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterIP;
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterPub0;
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterPage;
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterOfferTypes;
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterPsTime;
FOUNDATION_EXPORT NSString *kFBRFyberOfferParameterDevice;

@interface FBRFyber : NSObject

/**
 @abstract
 Initializes and returns a singleton instance of the API.
 
 @discussion
 *Call this prior to any other requests
 *Consider calling it in <b>application:didFinishLaunchingWithOptions:</b> like :
 
 <pre>
 - (BOOL)application:(UIApplication *)application 
 didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
 
    [FBRFyber withToken:@"API_KEY"];
 
    return YES;
 
 }
 </pre>
 */
+ (instancetype)withAPIKey:(NSString *)apiToken;

+ (instancetype)sharedInstance;

- (void)offersForParams:(NSDictionary *)params
                success:(FBRSuccess)success
                failure:(FBRFailure)failure;

@end
