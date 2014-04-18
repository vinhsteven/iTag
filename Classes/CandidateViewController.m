//
//  CandidateViewController.m
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import "CandidateViewController.h"
#import "ListJobViewController.h"
#import "DetailViewController.h"
#import "ResumeViewController.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setOpaque:NO];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextSetAlpha(context, 1.0);
    CGContextFillEllipseInRect(context, CGRectMake(0,0,self.frame.size.width,self.frame.size.height));
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextStrokeEllipseInRect(context, CGRectMake(1, 1, self.frame.size.width - 2, self.frame.size.height - 2));
}

@end

@interface CandidateViewController ()

@end

@implementation CandidateViewController
@synthesize m_parentController;

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
    
    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.barTintColor = BLACK_BACKGROUND_COLOR;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:TEXT_COLOR forKey:UITextAttributeTextColor];
    
    self.navigationItem.title = @"iTAG";
    
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    
    // Change the frame size to suit yours //
    
    [navBorder setBackgroundColor:LINE_COLOR];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
    
    _profileImgView.layer.cornerRadius = 50;
    
    _cirleNotification = [[CircleView alloc] initWithFrame:CGRectMake(110, 25, 25, 25)];
    _lbNotification = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    _lbNotification.font = [UIFont systemFontOfSize:13];
    _lbNotification.textAlignment = NSTextAlignmentCenter;
    _lbNotification.textColor = [UIColor whiteColor];
    _lbNotification.backgroundColor = [UIColor clearColor];
    _lbNotification.text = [NSString stringWithFormat:@"0"];
    [_cirleNotification addSubview:_lbNotification];
    
    [_btnApplication addSubview:_cirleNotification];
    
    [_btnApplication setBackgroundColor:BUTTON_BACKGROUND_COLOR];
    _btnApplication.layer.borderColor = LINE_COLOR.CGColor;
    _btnApplication.layer.borderWidth = 1;
    
    [_btnResume setBackgroundColor:BUTTON_BACKGROUND_COLOR];
    _btnResume.layer.borderColor = LINE_COLOR.CGColor;
    _btnResume.layer.borderWidth = 1;
    
    [_btnSavedJobs setBackgroundColor:BUTTON_BACKGROUND_COLOR];
    _btnSavedJobs.layer.borderColor = LINE_COLOR.CGColor;
    _btnSavedJobs.layer.borderWidth = 1;
    
    [_btnSearchJobs setBackgroundColor:BUTTON_BACKGROUND_COLOR];
    _btnSearchJobs.layer.borderColor = LINE_COLOR.CGColor;
    _btnSearchJobs.layer.borderWidth = 1;
    
    _txtJob.enabled = _txtSchool.enabled = NO;

    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = CGRectMake(0, 0, 22, 9);
    [btnLeft setImage:[UIImage imageNamed:@"icon_menu.png"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(leftButtonPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem = btnItem;

    switch (viewType) {
        case kApplication:
            self.navigationItem.title = @"Application";
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
    
    if ([AppDelegate getOSVersion] == iOS6) {
        self.profileImgView.center = CGPointMake(self.profileImgView.center.x, self.profileImgView.center.y-64);
        self.btnApplication.center = CGPointMake(self.btnApplication.center.x, self.btnApplication.center.y-64);
        self.btnResume.center = CGPointMake(self.btnResume.center.x, self.btnResume.center.y-64);
        self.btnSavedJobs.center = CGPointMake(self.btnSavedJobs.center.x, self.btnSavedJobs.center.y-64);
        self.btnSearchJobs.center = CGPointMake(self.btnSearchJobs.center.x, self.btnSearchJobs.center.y-64);
        self.lbDateAvailable.center = CGPointMake(self.lbDateAvailable.center.x, self.lbDateAvailable.center.y-64);
        self.lbName.center = CGPointMake(self.lbName.center.x, self.lbName.center.y-64);
        self.txtJob.center = CGPointMake(self.txtJob.center.x, self.txtJob.center.y-64);
        self.txtSchool.center = CGPointMake(self.txtSchool.center.x, self.txtSchool.center.y-64);
    }
    
    self.view.backgroundColor = BLACK_BACKGROUND_COLOR;
    self.lbName.textColor = TEXT_COLOR;
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"iTAG";
}

- (void) leftButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)tapApplication:(id)sender {
    viewType = kApplication;
    
    ListJobViewController *controller = [[ListJobViewController alloc] init];
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    naviController.navigationBar.barStyle = UIBarStyleBlack;
    [self.mm_drawerController
     setCenterViewController:naviController
     withCloseAnimation:YES
     completion:nil];
}

- (IBAction)tapResume:(id)sender {
    ResumeViewController *controller;
    if ([AppDelegate getDevice] == IPHONE_5)
        controller = [[ResumeViewController alloc] initWithNibName:@"ResumeViewController" bundle:nil];
    else
        controller = [[ResumeViewController alloc] initWithNibName:@"ResumeViewController-480" bundle:nil];
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    naviController.navigationBar.barStyle = UIBarStyleBlack;
    [self.mm_drawerController
     setCenterViewController:naviController
     withCloseAnimation:NO
     completion:nil];
}

- (IBAction)tapSearchJobs:(id)sender {
    viewType = kSearchJobs;
   
    ListJobViewController *controller = [[ListJobViewController alloc] init];
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    naviController.navigationBar.barStyle = UIBarStyleBlack;
    [self.mm_drawerController
     setCenterViewController:naviController
     withCloseAnimation:YES
     completion:nil];
}

- (IBAction)tapSavedJobs:(id)sender {
    viewType = kSavedJobs;
    
    ListJobViewController *controller = [[ListJobViewController alloc] init];
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    naviController.navigationBar.barStyle = UIBarStyleBlack;
    [self.mm_drawerController
     setCenterViewController:naviController
     withCloseAnimation:YES
     completion:nil];
}

@end
