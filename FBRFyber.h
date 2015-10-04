//
//  FBRFyber.h
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import <Foundation/Foundation.h>

@interface FBRFyber : NSObject

/**
 @abstract
 Initializes and returns a singleton instance of the API.
 
 @discussion
 *Call this prior to any other requests
 *Consider calling it in <b>application:didFinishLaunchingWithOptions:</b>
 */
+ (instancetype)withToken:(NSString *)apiToken;

@end
