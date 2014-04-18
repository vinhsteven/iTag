//
//  APPChildViewController.m
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPChildViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"

@interface APPChildViewController ()

@end

@implementation APPChildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    btnSignUp = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSignUp.frame = _bgBtnSignUp.frame;
    [btnSignUp setTitle:@"Sign up" forState:UIControlStateNormal];
    
    [btnSignUp setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [btnSignUp setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    btnSignUp.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btnSignUp addTarget:self action:@selector(signUpAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSignUp];
    
    _bgBtnSignUp.hidden = btnSignUp.hidden = YES;
    
    _bgImageView.image = [UIImage imageNamed:[_detailDict objectForKey:@"background"]];
    _txtTextView.text  = [_detailDict objectForKey:@"text"];
    
}

- (void) checkHiddenSignUpButton:(BOOL)isHidden {
    _bgBtnSignUp.hidden = btnSignUp.hidden = isHidden;
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"iTAG";
}

- (void) signUpAction {
    self.navigationItem.title = @"";
    SignUpViewController *controller;
    if ([AppDelegate getDevice] == IPHONE_5)
        controller = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    else
        controller = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController-480" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
