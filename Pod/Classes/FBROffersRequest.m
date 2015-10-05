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

static NSString * const kSignatureHTTPHeaderField = @"X-Sponsorpay-Response-Signature";
static NSString * const kFyberBaseURL = @"http://api.fyber.com/feed/v1/";

@interface FBROffersRequest()

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, assign) FBROffersRequestAcceptedResponseFormat acceptedResponseType;

@end

@implementation FBROffersRequest

- (instancetype)initWithParams:(NSDictionary *)params
                        apiKey:(NSString *)apiKey
          acceptedResponseType:(FBROffersRequestAcceptedResponseFormat)acceptedResponseType{
    self = [super init];
    
    if (self){
        _params = [params mutableCopy];
        _apiKey = [apiKey copy];
        _acceptedResponseType = acceptedResponseType;
    }
    
    return self;
}

+ (instancetype)requestForParams:(NSDictionary *)params
                          apiKey:(NSString *)apiKey
            acceptedResponseType:(FBROffersRequestAcceptedResponseFormat)acceptedResponseType{
    return [[[self class] alloc] initWithParams:params
                                     apiKey:apiKey
                       acceptedResponseType:acceptedResponseType];
}

- (void)startWithSuccess:(FBRSuccess)success
                 failure:(FBRFailure)failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *format = FBROffersRequestAcceptedResponseFormatJSON == self.acceptedResponseType ? @"json" : @"xml";
    
#if defined(DEBUG)
    NSString *appId = self.params[kFBRFyberOfferParameterAppId];
    NSString *uID = self.params[kFBRFyberOfferParameterUID];
    NSString *locale = self.params[kFBRFyberOfferParameterLocale];
    NSString *oSVersion = self.params[kFBRFyberOfferParameterOSVersion];
    NSString *timestamp = self.params[kFBRFyberOfferParameterTimestamp];
    NSString *appleIdfa = self.params[kFBRFyberOfferParameterAppleIdfa];
    NSString *appleIdfaTrackingEnabled = self.params[kFBRFyberOfferParameterAppleIdfaTrackingEnabled];
    
    NSAssert(FBROffersRequestAcceptedResponseFormatXML == self.acceptedResponseType ||
             FBROffersRequestAcceptedResponseFormatJSON == self.acceptedResponseType,
             @"We only support JSON or XML formars");
    NSAssert(appId, @"No appId provided");
    NSAssert(uID, @"No uID provided");
    NSAssert(locale, @"No locale provided");
    NSAssert(oSVersion, @"No oSVersion provided");
    NSAssert(timestamp, @"No timestamp provided");
    NSAssert(appleIdfa, @"No appleIdfa provided");
    NSAssert(appleIdfaTrackingEnabled, @"No appleIdfaTrackingEnabled provided");
#endif
    
    NSString *urlParams = [NSString stringWithFormat:@"offers.%@?", format];
    
    NSMutableDictionary *paramsCopy = [[NSMutableDictionary alloc] initWithDictionary:self.params];
    
    [paramsCopy removeObjectForKey:kFBRFyberOfferParameterFormat];
    
    NSUInteger paramsCount = [paramsCopy count];
    
    NSArray *paramsKeys = [[paramsCopy allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    for (NSInteger index = 0; index < paramsCount; index++){
        NSString *paramKey = paramsKeys[index];
        
        NSString *thePairToAdd = [NSString stringWithFormat:@"%@=%@", paramKey, paramsCopy[paramKey]];
        
        urlParams = [urlParams stringByAppendingString:thePairToAdd];
        
        if (index != paramsCount - 1){
            urlParams = [urlParams stringByAppendingString:@"&"];
        }
    }
    
    NSString *hashKey = [self hashFromParams:paramsCopy];
    
    urlParams = [NSString stringWithFormat:@"%@&hashkey=%@", urlParams, hashKey];
    
    NSString *url = [kFyberBaseURL stringByAppendingString:urlParams];
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             __unused BOOL signatureMatches = [self checkSignatureForResponseHeaders:[operation.response allHeaderFields]
                                                                             content:operation.responseString];
             
             success(responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(error);
         }];
}

- (NSString *)hashFromParams:(NSDictionary *)params{

    NSString *hash = @"";
    
    NSArray * sortedKeys = [[params allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    for (NSString *key in sortedKeys){
        
        NSString *pair = [NSString stringWithFormat:@"%@=%@", key, params[key]];
        
        hash = [hash stringByAppendingString:pair];
        
        hash = [hash stringByAppendingString:@"&"];
    }

    hash = [hash stringByAppendingString:self.apiKey];

    return [hash sha1];
}

- (BOOL)checkSignatureForResponseHeaders:(NSDictionary *)responseHeaders
                                 content:(NSString *)responseString{
    
    NSString *responseSignature = responseHeaders[kSignatureHTTPHeaderField];
    
    NSString *contentoHash = [responseString stringByAppendingString:self.apiKey];
    
    NSString *responseHash = [contentoHash sha1];
    
    BOOL signatureMatches = [responseSignature isEqualToString:responseHash];
    
    NSAssert(signatureMatches, @"Response signature mismatch");
    
    return signatureMatches;
}

@end
