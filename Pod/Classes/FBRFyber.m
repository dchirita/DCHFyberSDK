//
//  FBRFyber.m
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import "FBRFyber.h"
#import "FBROffersRequest.h"
#import "FBROffersFactory.h"
#import <AdSupport/ASIdentifierManager.h>

NSString const *kFBRFyberOfferParameterFormat = @"format";
NSString const *kFBRFyberOfferParameterAppId = @"appid";
NSString const *kFBRFyberOfferParameterUID = @"uid";
NSString const *kFBRFyberOfferParameterLocale = @"locale";
NSString const *kFBRFyberOfferParameterOSVersion = @"os_version";
NSString const *kFBRFyberOfferParameterTimestamp = @"timestamp";
NSString const *kFBRFyberOfferParameterHashkey = @"hashkey";
NSString const *kFBRFyberOfferParameterAppleIdfa = @"apple_idfa";
NSString const *kFBRFyberOfferParameterAppleIdfaTrackingEnabled = @"apple_idfa_tracking_enabled";
NSString const *kFBRFyberOfferParameterIP = @"ip";
NSString const *kFBRFyberOfferParameterPub0 = @"pub0";
NSString const *kFBRFyberOfferParameterPage = @"page";
NSString const *kFBRFyberOfferParameterOfferTypes = @"offer_types";
NSString const *kFBRFyberOfferParameterPsTime = @"ps_time";
NSString const *kFBRFyberOfferParameterDevice = @"device";

#if defined(DEBUG)
    NSString * const kDebugIP = @"109.235.143.113";
    NSString * const kDebugLocale = @"DE";

    #define DEBUG_USING_CUSTOM_IP
    #define DEBUG_USING_CUSTOM_LOCALE
#endif

@interface FBRFyber()

@property (nonatomic, copy) NSString *apiKey;

@property (nonatomic, strong) NSMutableSet* requests;

@end

@implementation FBRFyber

static FBRFyber *sharedInstance = nil;

- (instancetype)initWithToken:(NSString *)apiKey{
    
    self = [super init];
    
    if (self){
        _apiKey = [apiKey copy];
        _requests = [NSMutableSet set];
    }
    
    return self;
}

+ (instancetype)withAPIKey:(NSString *)apiKey{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithToken:apiKey];
    });
    return sharedInstance;
}

+ (instancetype)sharedInstance{
    
    NSAssert(sharedInstance.apiKey, @"You have to call [FBRFyber withAPIKey:] first");
    
    return sharedInstance;
}

- (void)offersForParams:(NSDictionary *)params
   acceptedResponseType:(FBROffersRequestAcceptedResponseFormat)acceptedResponseType
                success:(FBRSuccess)success
                failure:(FBRFailure)failure{
    NSAssert(self.apiKey, @"You have to call [FBRFyber withAPIKey:] first");
    
    NSDictionary *requestParams = [self addInstalationParamsToUserParams:params];
    
    FBROffersRequest *request = [FBROffersRequest requestForParams:requestParams
                                                            apiKey:self.apiKey
                                              acceptedResponseType:acceptedResponseType];
    
    [_requests addObject:request];
    
    __weak typeof(self) weakSelf = self;
    
    [request startWithSuccess:^(id result){
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
            NSDictionary *offersAsDictionary = result;
            
            NSArray *offers = [FBROffersFactory offersFromDictionary:offersAsDictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                //dispatch result
                success(offers);
                
                //remove the request since it's completed now
                [weakSelf.requests removeObject:request];
            });
        });
        
    }failure:^(NSError *error){
        failure(error);
        [weakSelf.requests removeObject:request];
    }];
}

- (NSDictionary *)addInstalationParamsToUserParams:(NSDictionary *)params{
    
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    NSString *deviceVersion = [[UIDevice currentDevice] systemVersion];
    NSString *currentTS = [NSString stringWithFormat:@"%lu", (unsigned long)[[NSDate date] timeIntervalSince1970]];
    
    requestParams[kFBRFyberOfferParameterOSVersion] = deviceVersion;
    requestParams[kFBRFyberOfferParameterTimestamp] = currentTS;
    
#ifdef DEBUG_USING_CUSTOM_IP
    requestParams[kFBRFyberOfferParameterIP] = kDebugIP;
#endif
    
#ifdef DEBUG_USING_CUSTOM_LOCALE
    requestParams[kFBRFyberOfferParameterLocale] = kDebugLocale;
#endif
    
    ASIdentifierManager *asiManager = [ASIdentifierManager sharedManager];
    
    BOOL isAdvertisingTrackingEnabled = [asiManager isAdvertisingTrackingEnabled];
    
    NSString *appleIDFA = @"";
    
    if (isAdvertisingTrackingEnabled){
        appleIDFA = [[asiManager advertisingIdentifier] UUIDString];
    }
    
    requestParams[kFBRFyberOfferParameterAppleIdfa] = appleIDFA;
    requestParams[kFBRFyberOfferParameterAppleIdfaTrackingEnabled] = isAdvertisingTrackingEnabled ? @"true":
    @"false";
    [requestParams addEntriesFromDictionary:params];
    
    return requestParams;
}

@end
