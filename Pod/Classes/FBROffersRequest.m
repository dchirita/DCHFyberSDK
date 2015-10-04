//
//  FBOffersRequest.m
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import "FBROffersRequest.h"
#import "AFNetworking.h"
#import "NSString+SHA.h"

#import "FBRFyber.h"

NSString * const kFyberBaseURL = @"http://api.fyber.com/feed/v1/";

@interface FBROffersRequest()

@property (nonatomic, strong) NSDictionary *params;

@end

@implementation FBROffersRequest

- (instancetype)initWithParams:(NSDictionary *)params{
    self = [super init];
    
    if (self){
        _params = params;
    }
    
    return self;
}

+ (instancetype)requestForParams:(NSDictionary *)params{
    return [[[self class] alloc] initWithParams:params];
}

- (void)startWithSuccess:(FBRSuccess)success
                 failure:(FBRFailure)failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *format = self.params[kFBRFyberOfferParameterFormat];
    NSString *appId = self.params[kFBRFyberOfferParameterAppId];
    NSString *uID = self.params[kFBRFyberOfferParameterUID];
    NSString *locale = self.params[kFBRFyberOfferParameterLocale];
    NSString *oSVersion = self.params[kFBRFyberOfferParameterOSVersion];
    NSString *timestamp = self.params[kFBRFyberOfferParameterTimestamp];
    NSString *hashkey = self.params[kFBRFyberOfferParameterHashkey];
    NSString *appleIdfa = self.params[kFBRFyberOfferParameterAppleIdfa];
    NSString *appleIdfaTrackingEnabled = self.params[kFBRFyberOfferParameterAppleIdfaTrackingEnabled];
    NSString *iP = self.params[kFBRFyberOfferParameterIP];
    NSString *pub0 = self.params[kFBRFyberOfferParameterPub0];
    NSString *page = self.params[kFBRFyberOfferParameterPage];
    NSString *offerTypes = self.params[kFBRFyberOfferParameterOfferTypes];
    NSString *pSTime = self.params[kFBRFyberOfferParameterPsTime];
    NSString *device = self.params[kFBRFyberOfferParameterDevice];
    
    NSAssert([format isEqualToString:@"xml"] ||
             [format isEqualToString:@"json"], @"We only support JSON or XML formars");
    NSAssert(appId, @"No appId provided");
    NSAssert(uID, @"No uID provided");
    NSAssert(locale, @"No locale provided");
    NSAssert(oSVersion, @"No oSVersion provided");
    NSAssert(timestamp, @"No timestamp provided");
    NSAssert(hashkey, @"No hashkey provided");
    NSAssert(appleIdfa, @"No appleIdfa provided");
    NSAssert(appleIdfaTrackingEnabled, @"No appleIdfaTrackingEnabled provided");
    
    NSString *urlParams = [NSString stringWithFormat:
                        @"offers.%@&"
                        @"appid=%@&"
                        @"uid=%@&"
                        @"locale=%@&"
                        @"os_version=%@&"
                        @"timestamp=%@&"
                        @"apple_idfa=%@&"
                        @"apple_idfa_tracking_enabled=%@&"
                        @"offer_types=%@",
                        format, appId, uID, locale,
                        oSVersion, timestamp,
                        appleIdfa, appleIdfaTrackingEnabled, offerTypes];
    
    NSString *hashKey = [self hashFromParams:self.params];
    
    urlParams = [NSString stringWithFormat:@"%@&hashkey=%@", urlParams, hashKey];
    
    NSString *url = [[kFyberBaseURL stringByAppendingString:urlParams] lowercaseString];
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
             success(responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             failure(error);
         }];
}

- (NSString *)hashFromParams:(NSDictionary *)params{

    NSString *hash = @"";
    
    NSArray * sortedKeys = [[params allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    NSUInteger numberOfKeys = [sortedKeys count];
    
    for (NSUInteger index = 0; index < numberOfKeys; index++){
        
        NSString *key = sortedKeys[index];
        
        NSString *pair = [NSString stringWithFormat:@"%@-%@", key, params[key]];
        
        hash = [hash stringByAppendingString:pair];
        
        if (index != numberOfKeys - 2){
            hash = [hash stringByAppendingString:@"&"];
        }
    }
    
    return [hash sha1];
}

@end
