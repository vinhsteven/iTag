//
//  SignUpViewController.h
//  iTag
//
//  Created by Steven on 4/15/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UIAlertViewDelegate,UITableViewDataSource> {
    NSMutableArray *mainArray;
    UITextField *txtFirstName;
    UITextField *txtLastName;
    UITextField *txtEmail;
    UITextField *txtGender;
    UITextField *txtPassword;
    UITextField *txtRetypePassword;
    UITextField *txtDOB;
    UITextField *txtMobile;
}

@property (strong,nonatomic) IBOutlet TPKeyboardAvoidingTableView *mainTableView;

@end
