//
//  FBRGenericBlocks.h
//  Pods
//
//  Created by Daniel on 04/10/15.
//
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class NSError;
@class FBROfferItem;

typedef void (^FBROffersSuccess)(NSArray<FBROfferItem *> *offers);
typedef void (^FBRFailure)(NSError *error);

NS_ASSUME_NONNULL_END
