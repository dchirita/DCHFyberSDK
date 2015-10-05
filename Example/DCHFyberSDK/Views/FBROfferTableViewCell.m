//
//  FBROfferTableViewCell.m
//  DCHFyberSDK
//
//  Created by Daniel on 05/10/15.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import "FBROfferTableViewCell.h"
#import "FBROfferItem.h"

@interface FBROfferTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *teaserLabel;
@property (weak, nonatomic) IBOutlet UILabel *payoutLabel;
@end

@implementation FBROfferTableViewCell

- (void)populateWithOfferItem:(FBROfferItem *)item{
    self.titleLabel.text = item.title;
    self.teaserLabel.text = item.teaser;
    self.payoutLabel.text = [NSString stringWithFormat:@"Payout: %lu", (unsigned long)item.payout];
}

@end
