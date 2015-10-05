//
//  FBRViewController.m
//  DCHFyberSDK
//
//  Created by Daniel on 10/04/2015.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import "FBRViewController.h"
#import "FBRFyber.h"
#import "FBRResultsViewController.h"

NSString * const kFyberAPIKey = @"1c915e3b5d42d05136185030892fbb846c278927";

@interface FBRViewController ()

@property (weak, nonatomic) IBOutlet UITextField *uidTextField;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *appIdTextField;

@property (nonatomic, strong) NSArray *offers;

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
    //reset if pressed multiple times
    self.offers = nil;
    
    //normally this should be in the app delegate
    //it's here to have the option to test by changing it on the fly via the 'apiKeyTextField' value
    //ONLY AND ONLY at FIRST retrieval
    [FBRFyber withAPIKey:self.apiKeyTextField.text];
    
    NSDictionary *params = @{kFBRFyberOfferParameterAppId : self.appIdTextField.text,
                             kFBRFyberOfferParameterUID : self.uidTextField.text,
                             kFBRFyberOfferParameterOfferTypes : @"112"};
    
    [[FBRFyber sharedInstance] offersForParams:params
                          acceptedResponseType:FBROffersRequestAcceptedResponseFormatJSON
                                       success:^(NSArray *offers){
                                           if (0 != [offers count]){
                                               [self showOffersScreenWithOffers:offers];
                                           }
                                           else{
                                               [self showNoOffersAvailable];
                                           }
                                       }
                                       failure:^(NSError *error){
                                           NSLog(@"%@", [error localizedDescription]);
                                       }];
}

#pragma mark - Private Methods

- (void)showNoOffersAvailable{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No offers"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

- (void)showOffersScreenWithOffers:(NSArray *)offers{
    
    self.offers = offers;
    
    [self performSegueWithIdentifier:@"showResultsScreen"
                              sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender{
    FBRResultsViewController* fbrResults = segue.destinationViewController;
    fbrResults.offers = self.offers;
}

@end
