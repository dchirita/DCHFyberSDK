//
//  FBRViewController.m
//  DCHFyberSDK
//
//  Created by Daniel on 10/04/2015.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import "FBRViewController.h"
#import "FBRResultsViewController.h"

NSString * const kFyberAPIKey = @"1c915e3b5d42d05136185030892fbb846c278927";

@interface FBRViewController ()

@property (weak, nonatomic) IBOutlet UITextField *uidTextField;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *appIdTextField;

@property (nonatomic, strong) NSArray<FBROfferItem *> *offers;

@end

@implementation FBRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.uidTextField.text = @"superman";
    self.apiKeyTextField.text = kFyberAPIKey;
    self.appIdTextField.text = @"2070";
}

- (IBAction)retrieveOffers:(id)sender {
    
    //reset if pressed multiple times
    self.offers = nil;
    
    [self.delegate didPressFetchWithApiKey:self.apiKeyTextField.text
                                     appId:self.appIdTextField.text
                                    userId:self.uidTextField.text];
}

@end
