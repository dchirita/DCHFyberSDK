//
//  FBRFyber.m
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//

#import "FBRFyber.h"

@interface FBRFyber()

@property (nonatomic, copy) NSString *apiKey;

@end

@implementation FBRFyber

static FBRFyber *sharedInstance = nil;

- (instancetype)initWithToken:(NSString *)apiKey{
    
    self = [super init];
    
    if (self){
        _apiKey = [apiKey copy];
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

@end
