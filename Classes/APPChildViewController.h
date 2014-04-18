//
//  APPChildViewController.h
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPChildViewController : UIViewController {
    UIButton *btnSignUp;
}

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSDictionary *detailDict;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UITextView *txtTextView;
@property (strong, nonatomic) IBOutlet UIView *bgBtnSignUp;
@property (strong, nonatomic) IBOutlet UIView *containerView;

- (void) checkHiddenSignUpButton:(BOOL)isHidden;

@end
