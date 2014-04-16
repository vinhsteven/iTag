//
//  DetailViewController.h
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (unsafe_unretained) id parent;
@property (assign) int viewType;
@property (strong, nonatomic) NSDictionary *detailDict;
@property (strong, nonatomic) IBOutlet UIImageView *companyLogo;
@property (strong, nonatomic) IBOutlet UILabel *lbJobTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbCompanyName;
@property (strong, nonatomic) IBOutlet UITextView *txtDescription;
@property (strong, nonatomic) IBOutlet UIButton *btnWithdrawApply;
@property (strong, nonatomic) IBOutlet UIButton *btnSaveCancel;

- (IBAction)handleSaveCancel:(UIButton*)sender;
- (IBAction)handleApplyWithdraw:(UIButton*)sender;


@end
