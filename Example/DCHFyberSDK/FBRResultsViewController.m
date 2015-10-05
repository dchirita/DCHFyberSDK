//
//  FBRResultsViewController.m
//  DCHFyberSDK
//
//  Created by Daniel on 05/10/15.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import "FBRResultsViewController.h"
#import "FBROfferTableViewCell.h"

@implementation FBRResultsViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.offers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"offersCell";
    
    FBROfferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                            forIndexPath:indexPath];
    [cell populateWithOfferItem:self.offers[indexPath.row]];
    
    return cell;
}

@end
