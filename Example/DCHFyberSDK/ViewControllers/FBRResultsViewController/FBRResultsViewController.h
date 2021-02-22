//
//  FBRResultsViewController.h
//  DCHFyberSDK
//
//  Created by Daniel on 05/10/15.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBROfferItem;

@interface FBRResultsViewController : UIViewController

@property (nonatomic, strong) NSArray<FBROfferItem *> *offers;

@end
