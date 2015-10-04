//
//  FBOffersRequest.h
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import <Foundation/Foundation.h>
#import "FBRGenericBlocks.h"

@interface FBROffersRequest : NSObject

+ (instancetype)requestForParams:(NSDictionary *)params;

- (void)startWithSuccess:(FBRSuccess)success
                 failure:(FBRFailure)failure;

@end
