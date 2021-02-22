//
//  MainFlowHandler.m
//  DCHFyberOffersSDKDemo
//
//  Created by Daniel on 20/02/2021.
//

#import "MainFlowHandler.h"

#import "FBRViewController.h"

#import "FBRResultsViewController.h"

#import "UIViewController+Creation.h"

#import <DCHFyberOffersSDK/DCHFyberOffersSDK.h>

@interface MainFlowHandler() <UIApplicationDelegate, FBRViewControllerDelegate>

@property (nonatomic, strong) FBRViewController *viewController;

@end

@implementation MainFlowHandler
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    application.delegate = self;
    
    FBRViewController *rootViewController = [FBRViewController createInstance];
    rootViewController.delegate = self;
    
    [self setRootViewController:rootViewController];
    
    self.viewController = rootViewController;
    
    return YES;
}

- (void)setRootViewController:(UIViewController *)viewController {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    window.rootViewController = viewController;
    
    [window makeKeyAndVisible];
    
    self.window = window;
}

#pragma mark - FBRViewControllerDelegate

- (void)didPressFetchWithApiKey:(NSString *)apiKey
                          appId:(NSString *)appId
                         userId:(NSString *)userId {
    
    [FBRFyber withAPIKey:apiKey];
    
    FBRParams *params = [[FBRParams alloc] initWithAppId:appId
                                                  userId:userId
                                               offerType:OfferTypeFree];
    
    [[FBRFyber sharedInstance] offersForParams:params
                                       success:^(NSArray<FBROfferItem *> *offers){
        
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

#pragma mark - Private

- (void)showOffersScreenWithOffers:(NSArray<FBROfferItem *> *)offers {
    
    FBRResultsViewController* fbrResults = [FBRResultsViewController createInstance];
    
    fbrResults.offers = offers;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:fbrResults];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                            target:self
                                                                            action:@selector(didPressCloseOffersScreen)];
    fbrResults.navigationItem.rightBarButtonItem = cancel;
    
    [self.viewController presentViewController:navController
                                      animated:YES
                                    completion:nil];
}

- (void)showNoOffersAvailable {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No offers"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alert addAction:action];
    
    [self.viewController presentViewController:alert
                                      animated:YES
                                    completion:nil];
}

- (void)didPressCloseOffersScreen {
    [self.viewController dismissViewControllerAnimated:YES
                                            completion:nil];
}

+ (instancetype)shared {
    static MainFlowHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
