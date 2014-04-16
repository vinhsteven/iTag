//
//  AppDelegate.h
//  iTag
//
//  Created by Steven on 4/15/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    LoginViewController *loginVC;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

+(int)getDevice;
+ (UIImage *) imageFromColor:(UIColor *)color;

@end
