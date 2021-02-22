//
//  FBRViewController.h
//  DCHFyberSDK
//
//  Created by Daniel on 10/04/2015.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

@import UIKit;

@protocol FBRViewControllerDelegate;

@interface FBRViewController : UIViewController

@property (nonatomic, weak) id<FBRViewControllerDelegate> delegate;

@end

@protocol FBRViewControllerDelegate

- (void)didPressFetchWithApiKey:(NSString *)apiKey
                          appId:(NSString *)appId
                         userId:(NSString *)userId;

@end
