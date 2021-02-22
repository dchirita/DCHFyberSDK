//
//  UIViewController+Creation.m
//  DCHFyberOffersSDKDemo
//
//  Created by Daniel on 20/02/2021.
//

#import "UIViewController+Creation.h"

@implementation UIViewController (Creation)

+ (instancetype)createInstance {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main"
                                                 bundle:nil];
    
    NSString *className = NSStringFromClass([self class]);
    
    return [sb instantiateViewControllerWithIdentifier:className];
}

@end
