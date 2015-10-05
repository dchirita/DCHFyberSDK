//
//  DCHFyberSDKTests.m
//  DCHFyberSDKTests
//
//  Created by Daniel on 10/04/2015.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

// https://github.com/kiwi-bdd/Kiwi

#import "FBROfferItem.h"
#import "NSString+SHA.h"
#import "FBRLinkGenerator.h"

SPEC_BEGIN(BasicTests)

describe(@"Basic Tests for the FBRSDK", ^{
    
    context(@"FBROfferItem", ^{
        
        let(offer, ^{
            return [FBROfferItem offerWithTitle:@"First Offer"
                                         teaser:@"The teaser"
                                   thumbnailUrl:@"http://cdn3.sponsorpay.com/assets/175/win_icon_square_60.png"
                                         payout:100];
        });
        
        it(@"Should have title", ^{
            [[offer.title should] equal:@"First Offer"];
        });
        it(@"Should have teaser", ^{
            [[offer.teaser should] equal:@"The teaser"];
        });
        
        it(@"Should have thumbnailUrl", ^{
            [[offer.thumbnailUrl should] equal:@"http://cdn3.sponsorpay.com/assets/175/win_icon_square_60.png"];
        });
        
        it(@"Should have payout", ^{
            [[theValue(offer.payout) should] equal:theValue(100)];
        });
    });
    
    context(@"SHA", ^{
        
        it(@"should be exactly", ^{
            [[[@"appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&"
               @"ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&"
               @"pub0=campaign2&timestamp=1312553361&"
               @"uid=player1&e95a21621a1865bcbae3bee89c4d4f84" sha1] should] equal:@"7a2b1604c03d46eec1ecd4a686787b75dd693c4d"];
        });
    });
    
    context(@"Request", ^{
        
        it(@"should generate url", ^{
            
            NSDictionary *params = @{@"appid" : @"2070",
                                     @"apple_idfa" : @"B5944FC0-268A-4AD2-A0E2-799E75E37287",
                                     @"apple_idfa_tracking_enabled" : @"true",
                                     @"ip" : @"109.235.143.113",
                                     @"locale" : @"DE",
                                     @"offer_types" : @"112",
                                     @"os_version" : @"8.4",
                                     @"timestamp" : @"1444080064",
                                     @"uid" : @"spiderman"};
            
            [[[FBRLinkGenerator fyberLinkForParams:params
                                            apiKey:@"1c915e3b5d42d05136185030892fbb846c278927"
                              acceptedResponseType:FBROffersRequestAcceptedResponseFormatJSON] should]
             equal:@"http://api.fyber.com/feed/v1/offers.json?appid=2070&"
                   @"apple_idfa=B5944FC0-268A-4AD2-A0E2-799E75E37287&"
                   @"apple_idfa_tracking_enabled=true&ip=109.235.143.113&"
                   @"locale=DE&offer_types=112&os_version=8.4&"
                   @"timestamp=1444080064&uid=spiderman&"
                   @"hashkey=3dcc6db136d1c523e432fbd86836bb42e784cc6f"];
        });
    });
});

SPEC_END

