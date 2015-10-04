//
//  FBOffersRequest.h
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import <Foundation/Foundation.h>
#import "FBRGenericBlocks.h"
#import "FBROffersRequestAcceptedResponseTypes.h"

@interface FBROffersRequest : NSObject

+ (instancetype)requestForParams:(NSDictionary *)params
                          apiKey:(NSString *)apiKey
            acceptedResponseType:(FBROffersRequestAcceptedResponseFormat)acceptedResponseType;

- (void)startWithSuccess:(FBRSuccess)success
                 failure:(FBRFailure)failure;

@end
