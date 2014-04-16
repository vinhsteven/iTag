//
//  LoginViewController.h
//  iTag
//
//  Created by Steven on 4/15/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "CandidateViewController.h"

@interface LoginViewController : UIViewController <UIAlertViewDelegate> {
    UITextField *myForgotTextField;
}

@property (nonatomic,strong) MMDrawerController * drawerController;
@property (strong,nonatomic) CandidateViewController *centerViewController;
@property (strong,nonatomic) IBOutlet UIButton *btnFBSignIn;
@property (strong,nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong,nonatomic) IBOutlet UIView *containerView;
@property (strong,nonatomic) IBOutlet UIButton *btnRegister;
@property (strong,nonatomic) IBOutlet UIButton *btnForgotPassword;
@property (strong,nonatomic) IBOutlet UITextField *txtUsername;
@property (strong,nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)tapFBSignIn:(id)sender;
- (IBAction)tapSignIn:(id)sender;
- (IBAction)tapRegister:(id)sender;
- (IBAction)tapForgotPassword:(id)sender;

@end
