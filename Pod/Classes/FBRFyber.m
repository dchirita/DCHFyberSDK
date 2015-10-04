//
//  FBRFyber.m
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import "FBRFyber.h"
#import "FBROffersRequest.h"

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
                success:(FBRSuccess)success
                failure:(FBRFailure)failure{
    NSAssert(self.apiKey, @"You have to call [FBRFyber withAPIKey:] first");
    
    FBROffersRequest *request = [FBROffersRequest requestForParams:params];
    
    [_requests addObject:request];
    
    __weak typeof(self) weakSelf = self;
    
    [request startWithSuccess:^(id result){
                        success(result);
                        [weakSelf.requests removeObject:request];
                      }
                      failure:^(NSError *error){
                          failure(error);
                          [weakSelf.requests removeObject:request];
                      }];
}

@end
