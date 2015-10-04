//
//  FBRFyber.m
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import "FBRFyber.h"

@interface FBRFyber()

@property (nonatomic, copy) NSString *apiToken;

@end

@implementation FBRFyber

static FBRFyber *sharedInstance = nil;

- (instancetype)initWithToken:(NSString *)apiToken{
    
    self = [super init];
    
    if (self){
        _apiToken = [apiToken copy];
    }
    
    return self;
}

+ (instancetype)withToken:(NSString *)apiToken{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithToken:apiToken];
    });
    return sharedInstance;
}

@end
