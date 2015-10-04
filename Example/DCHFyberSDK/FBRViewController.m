//
//  FBRViewController.m
//  DCHFyberSDK
//
//  Created by Daniel on 10/04/2015.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import "FBRViewController.h"
#import "FBRFyber.h"

NSString * const kFyberAPIKey = @"1c915e3b5d42d05136185030892fbb846c278927";

@interface FBRViewController ()

@property (weak, nonatomic) IBOutlet UITextField *uidTextField;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *appIdTextField;

@end

@implementation FBRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.uidTextField.text = @"spiderman";
    self.apiKeyTextField.text = kFyberAPIKey;
    self.appIdTextField.text = @"2070";
}


- (IBAction)retrieveOffers:(id)sender
{
    //normally this should be in the app delegate
    //it's here to have the option to test by changing it on the fly via the 'apiKeyTextField' value
    [FBRFyber withAPIKey:self.apiKeyTextField.text];
    
    NSDictionary *params = @{kFBRFyberOfferParameterAppId : self.appIdTextField.text,
                             kFBRFyberOfferParameterUID : self.uidTextField.text,
                             kFBRFyberOfferParameterOfferTypes : @"112"};
    
    [[FBRFyber sharedInstance] offersForParams:params
                          acceptedResponseType:FBROffersRequestAcceptedResponseFormatJSON
                                       success:^(id result){
                                           NSLog(@"%@", result);
                                       }
                                       failure:^(NSError *error){
                                           NSLog(@"%@", [error localizedDescription]);
                                       }];
}

@end
