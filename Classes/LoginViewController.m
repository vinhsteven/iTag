//
//  LoginViewController.m
//  iTag
//
//  Created by Steven on 4/15/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "LeftSideViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"

@implementation LoginViewController
@synthesize centerViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = GREY_BACKGROUND_COLOR;
    self.navigationItem.title = @"";
    
    _txtUsername.placeholder = @"Email";
    _txtPassword.placeholder = @"Password";
    
    [_btnFBSignIn setBackgroundImage:[AppDelegate imageFromColor:[UIColor colorWithRed:(float)59/255 green:(float)89/255 blue:(float)152/255 alpha:1.0]] forState:UIControlStateNormal];
    [_btnFBSignIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _containerView.layer.cornerRadius = 5;
    _containerView.backgroundColor = [UIColor whiteColor];
    
    [_btnSignIn setBackgroundImage:[AppDelegate imageFromColor:TEXT_COLOR] forState:UIControlStateNormal];
    [_btnSignIn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
//    [_btnRegister setBackgroundImage:[AppDelegate imageFromColor:TEXT_COLOR] forState:UIControlStateNormal];

    [_btnRegister setBackgroundColor:[UIColor clearColor]];
    [_btnRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_btnForgotPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //handle tap to hide keyboard
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    
    myForgotTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    myForgotTextField.borderStyle = UITextBorderStyleRoundedRect;
    [myForgotTextField setBackgroundColor:[UIColor whiteColor]];
    
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)tapFBSignIn:(id)sender {
    LeftSideViewController *leftViewController = [[LeftSideViewController alloc] init];
    
    if ([AppDelegate getDevice] == IPHONE_5)
        centerViewController = [[CandidateViewController alloc] initWithNibName:@"CandidateViewController" bundle:nil];
    else
        centerViewController = [[CandidateViewController alloc] initWithNibName:@"CandidateViewController-480" bundle:nil];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    UINavigationController * leftNavigationController = [[UINavigationController alloc] initWithRootViewController:leftViewController];
    leftNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    [leftNavigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:leftNavigationController
                             rightDrawerViewController:nil];
    [self.drawerController setShowsShadow:NO];
    
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:160];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    [self.navigationController pushViewController:self.drawerController animated:YES];
    
    leftViewController.parent = self;
}

- (IBAction)tapSignIn:(id)sender {
    /*
    if ([_txtUsername.text isEqualToString:@""]) {
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please input your email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [dialog show];
        return;
    }
    if ([_txtPassword.text isEqualToString:@""]) {
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please input your password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [dialog show];
        return;
    }
    */

    LeftSideViewController *leftViewController = [[LeftSideViewController alloc] init];
    
    if ([AppDelegate getDevice] == IPHONE_5)
        centerViewController = [[CandidateViewController alloc] initWithNibName:@"CandidateViewController" bundle:nil];
    else
        centerViewController = [[CandidateViewController alloc] initWithNibName:@"CandidateViewController-480" bundle:nil];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    UINavigationController * leftNavigationController = [[UINavigationController alloc] initWithRootViewController:leftViewController];
    leftNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    [leftNavigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:leftNavigationController
                             rightDrawerViewController:nil];
    [self.drawerController setShowsShadow:NO];
    
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:160];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    [self.navigationController pushViewController:self.drawerController animated:YES];
    
    leftViewController.parent = self;
}

- (IBAction)tapRegister:(id)sender {
    SignUpViewController *controller;
    if ([AppDelegate getDevice] == IPHONE_5)
        controller = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    else
        controller = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController-480" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)tapForgotPassword:(id)sender {
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Forgot Password" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel",@"OK", nil];
//    [dialog addSubview:myForgotTextField];
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    [dialog show];
}

- (void) handleSingleTap:(UITapGestureRecognizer*)_gesture {
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"Your password has been sent to your email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [dialog show];
    }
}

#pragma mark UITextFieldDelegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtUsername) {
        [_txtPassword becomeFirstResponder];
        self.view.center = CGPointMake(self.view.center.x, 184);
    }
    else {
        //process login
        [self tapSignIn:nil];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.view.center = CGPointMake(self.view.center.x, 184);
}


@end
