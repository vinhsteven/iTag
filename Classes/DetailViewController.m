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
    
    if ([AppDelegate getOSVersion] == iOS6) {
        self.companyLogo.center = CGPointMake(self.companyLogo.center.x, self.companyLogo.center.y-64);
        self.lbCompanyName.center = CGPointMake(self.lbCompanyName.center.x, self.lbCompanyName.center.y-64);
        self.lbJobTitle.center = CGPointMake(self.lbJobTitle.center.x, self.lbJobTitle.center.y-64);
        self.txtDescription.center = CGPointMake(self.txtDescription.center.x, self.txtDescription.center.y-64);
        self.btnSaveCancel.center = CGPointMake(self.btnSaveCancel.center.x, self.btnSaveCancel.center.y-64);
        self.btnWithdrawApply.center = CGPointMake(self.btnWithdrawApply.center.x, self.btnWithdrawApply.center.y-64);
        
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBack setImage:[UIImage imageNamed:@"icon_back_yellow.png"] forState:UIControlStateNormal];
        btnBack.frame = CGRectMake(5, 5, 13, 22);
        [btnBack addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *btnBarBackItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
        self.navigationItem.leftBarButtonItem = btnBarBackItem;
    }
}

//for iOS < 7
- (void) backView {
    [self.navigationController popViewControllerAnimated:YES];
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
