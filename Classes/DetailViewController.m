//
//  DetailViewController.m
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize parent;
@synthesize detailDict;
@synthesize viewType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = GREY_BACKGROUND_COLOR;
    
    switch (viewType) {
        case kApplication:
            self.navigationItem.title = @"Application";
            _btnSaveCancel.hidden = YES;
            [_btnWithdrawApply setTitle:@"WITHDRAW" forState:UIControlStateNormal];
            break;
        case kSearchJobs:
            self.navigationItem.title = @"Search Jobs";

            break;
        case kSavedJobs:
            self.navigationItem.title = @"Saved Jobs";

            break;
        default:
            break;
    }
    
    _companyLogo.image = [UIImage imageNamed:[detailDict objectForKey:@"logo"]];
    
    _lbJobTitle.text = [detailDict objectForKey:@"jobTitle"];
    _lbJobTitle.textColor = TEXT_COLOR;
    
    _lbCompanyName.text = [detailDict objectForKey:@"companyName"];
    _lbCompanyName.textColor = [UIColor whiteColor];
    
    _txtDescription.text = [detailDict objectForKey:@"description"];
    _txtDescription.editable = NO;
}

- (IBAction)handleSaveCancel:(UIButton*)sender {
    if ([_btnSaveCancel.titleLabel.text isEqualToString:@"SAVE"])
        [_btnSaveCancel setTitle:@"CANCEL" forState:UIControlStateNormal];
    else
        [_btnSaveCancel setTitle:@"SAVE" forState:UIControlStateNormal];
}
- (IBAction)handleApplyWithdraw:(UIButton*)sender {
    if (viewType == kApplication)
        [self.navigationController popViewControllerAnimated:YES];
    else {
        if ([_btnWithdrawApply.titleLabel.text isEqualToString:@"WITHDRAW"])
            [_btnWithdrawApply setTitle:@"APPLY" forState:UIControlStateNormal];
        else
            [_btnWithdrawApply setTitle:@"WITHDRAW" forState:UIControlStateNormal];
    }
}

@end
