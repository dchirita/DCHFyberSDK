//
//  FBRViewController.m
//  DCHFyberSDK
//
//  Created by Daniel on 10/04/2015.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import "FBRViewController.h"
#import "FBRFyber.h"

#import <AdSupport/ASIdentifierManager.h>

@interface FBRViewController ()

@end

@implementation FBRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *deviceVersion = [[UIDevice currentDevice] systemVersion];
    NSString *currentTS = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    
    ASIdentifierManager *asiManager = [ASIdentifierManager sharedManager];
    
    BOOL isAdvertisingTrackingEnabled = [asiManager isAdvertisingTrackingEnabled];
    
    NSString *appleIDFA = @"";
    
    if (isAdvertisingTrackingEnabled){
        appleIDFA = [[asiManager advertisingIdentifier] UUIDString];
    }
 
    NSDictionary *params = @{kFBRFyberOfferParameterFormat : @"json",
                             kFBRFyberOfferParameterAppId : @"2070",
                             kFBRFyberOfferParameterUID : @"spiderman",
                             kFBRFyberOfferParameterLocale : @"DE",
                             kFBRFyberOfferParameterOSVersion : deviceVersion,
                             kFBRFyberOfferParameterTimestamp : currentTS,
                             kFBRFyberOfferParameterAppleIdfa : appleIDFA,
                             kFBRFyberOfferParameterAppleIdfaTrackingEnabled : isAdvertisingTrackingEnabled ? @"true" : false,
                             kFBRFyberOfferParameterOfferTypes : @"112",
                             kFBRFyberOfferParameterIP : @"109.235.143.113"};
    
    [[FBRFyber sharedInstance] offersForParams:params
                                       success:^(id result){
                                           NSLog(@"%@", result);
                                       }
                                       failure:^(NSError *error){
                                           NSLog(@"%@", [error localizedDescription]);
                                       }];
}

@end
