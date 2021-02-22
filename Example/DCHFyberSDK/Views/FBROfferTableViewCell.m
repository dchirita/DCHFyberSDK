//
//  FBROfferTableViewCell.m
//  DCHFyberSDK
//
//  Created by Daniel on 05/10/15.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import "FBROfferTableViewCell.h"

#import <DCHFyberOffersSDK/FBROfferItem.h>

#import <SDWebImage/UIImageView+WebCache.h>

@interface FBROfferTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *teaserLabel;
@property (weak, nonatomic) IBOutlet UILabel *payoutLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end

@implementation FBROfferTableViewCell

- (void)populateWithOfferItem:(FBROfferItem *)item{
    self.titleLabel.text = item.title;
    self.teaserLabel.text = item.teaser;
    self.payoutLabel.text = [NSString stringWithFormat:@"Payout: %lu", (unsigned long)item.payout];
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnailUrl]];
}

@end
