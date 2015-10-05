//
//  FBRLinkGenerator.h
//  Pods
//
//  Created by Daniel on 06/10/15.
//
//

#import <Foundation/Foundation.h>
#import "FBROffersRequestAcceptedResponseTypes.h"

@interface FBRLinkGenerator : NSObject

+ (NSString *)fyberLinkForParams:(NSDictionary *)params
                          apiKey:(NSString *)apiKey
            acceptedResponseType:(FBROffersRequestAcceptedResponseFormat)acceptedResponseType;
@end
