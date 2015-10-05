//
//  FBRLinkGenerator.m
//  Pods
//
//  Created by Daniel on 06/10/15.
//
//

#import "FBRLinkGenerator.h"
#import "NSString+SHA.h"

static NSString * const kFyberBaseURL = @"http://api.fyber.com/feed/v1/";

@implementation FBRLinkGenerator

+ (NSString *)fyberLinkForParams:(NSDictionary *)params
                          apiKey:(NSString *)apiKey
            acceptedResponseType:(FBROffersRequestAcceptedResponseFormat)acceptedResponseType{
    
    NSString *format = FBROffersRequestAcceptedResponseFormatJSON == acceptedResponseType ? @"json" : @"xml";
    
    NSString *urlParams = [NSString stringWithFormat:@"offers.%@?", format];
    
    NSMutableDictionary *paramsCopy = [[NSMutableDictionary alloc] initWithDictionary:params];
    
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
    
    NSString *hashKey = [self hashFromParams:paramsCopy
                                      apiKey:apiKey];
    
    urlParams = [NSString stringWithFormat:@"%@&hashkey=%@", urlParams, hashKey];
    
    NSString *url = [kFyberBaseURL stringByAppendingString:urlParams];
    
    return url;
}

+ (NSString *)hashFromParams:(NSDictionary *)params
                      apiKey:(NSString *)apiKey{
    
    NSString *hash = @"";
    
    NSArray * sortedKeys = [[params allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    for (NSString *key in sortedKeys){
        
        NSString *pair = [NSString stringWithFormat:@"%@=%@", key, params[key]];
        
        hash = [hash stringByAppendingString:pair];
        
        hash = [hash stringByAppendingString:@"&"];
    }
    
    hash = [hash stringByAppendingString:apiKey];
    
    return [hash sha1];
}

@end
