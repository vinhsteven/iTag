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
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:TEXT_COLOR forKey:UITextAttributeTextColor];
    
    self.navigationItem.title = @"iTAG";
    
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    
    // Change the frame size to suit yours //
    
    [navBorder setBackgroundColor:[UIColor lightGrayColor]];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
    
    _profileImgView.layer.cornerRadius = 50;
    _profileImgView.layer.borderWidth = 1;
    
    _cirleNotification = [[CircleView alloc] initWithFrame:CGRectMake(110, 25, 25, 25)];
    _lbNotification = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    _lbNotification.font = [UIFont systemFontOfSize:13];
    _lbNotification.textAlignment = NSTextAlignmentCenter;
    _lbNotification.textColor = [UIColor whiteColor];
    _lbNotification.backgroundColor = [UIColor clearColor];
    _lbNotification.text = [NSString stringWithFormat:@"0"];
    [_cirleNotification addSubview:_lbNotification];
    
    [_btnApplication addSubview:_cirleNotification];
    
    [_btnApplication setBackgroundColor:GREY_BACKGROUND_COLOR];
    _btnApplication.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnApplication.layer.borderWidth = 0.5;
    
    [_btnResume setBackgroundColor:GREY_BACKGROUND_COLOR];
    _btnResume.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnResume.layer.borderWidth = 0.5;
    
    [_btnSavedJobs setBackgroundColor:GREY_BACKGROUND_COLOR];
    _btnSavedJobs.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnSavedJobs.layer.borderWidth = 0.5;
    
    [_btnSearchJobs setBackgroundColor:GREY_BACKGROUND_COLOR];
    _btnSearchJobs.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnSearchJobs.layer.borderWidth = 0.5;
    
    _txtJob.enabled = _txtSchool.enabled = NO;

    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = CGRectMake(0, 0, 22, 9);
    [btnLeft setImage:[UIImage imageNamed:@"icon_menu.png"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(leftButtonPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    //add table view to display job
    mainArray = [NSMutableArray arrayWithCapacity:1];
    
    NSString *jobTitle[] = {
        @"Restaurant Manager",
        @"Outlet Manager",
        @"Waiter/Waitress"
    };
    
    NSString *company[] = {
        @"Sakae Sushi",
        @"SaladStop!",
        @"SaladStop!"
    };
    
    NSString *companyLogo[] = {
        @"tmp_company_1.png",
        @"tmp_company_2.png",
        @"tmp_company_2.png"
    };
    
    NSString *description[] = {
        @"Sakae Sushi, the largest chain of sushi production in Sigapore. Founded in 2000",
        @"Welcome to SaladStop",
        @"Welcome to SaladStop",
    };
    
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
    
    for (int i=0;i < sizeof(jobTitle)/sizeof(jobTitle[0]);i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:jobTitle[i],@"jobTitle",company[i],@"companyName",description[i],@"description",companyLogo[i],@"logo", nil];
        [mainArray addObject:dict];
    }
    
    self.mainTableView.backgroundColor = GREY_BACKGROUND_COLOR;
    self.mainTableView.rowHeight = 90;
    self.mainTableView.separatorColor = [UIColor lightGrayColor];
}

- (void) viewWillAppear:(BOOL)animated {
    if (_mainTableView.hidden == NO) {
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
    }
}
- (void) leftButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)tapApplication:(id)sender {
    viewType = kApplication;
    _mainTableView.hidden = NO;
    self.navigationItem.title = @"Application";
}

- (IBAction)tapResume:(id)sender {
    
}

- (IBAction)tapSearchJobs:(id)sender {
    viewType = kSearchJobs;
    _mainTableView.hidden = NO;
    self.navigationItem.title = @"Search Jobs";
}

- (IBAction)tapSavedJobs:(id)sender {
    viewType = kSavedJobs;
    _mainTableView.hidden = NO;
    
    self.navigationItem.title = @"Saved Jobs";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    // Configure the cell...
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    NSDictionary *dict = [mainArray objectAtIndex:indexPath.row];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[dict objectForKey:@"logo"]]];
    img.frame = CGRectMake(20, 10, 70, 70);
    [cell.contentView addSubview:img];
    
    UILabel *lbJobTitle = [[UILabel alloc] initWithFrame:CGRectMake(110, 30, 150, 21)];
    lbJobTitle.backgroundColor = [UIColor clearColor];
    lbJobTitle.textColor = TEXT_COLOR;
    lbJobTitle.text = [dict objectForKey:@"jobTitle"];
    lbJobTitle.font = [UIFont systemFontOfSize:13];
    [cell.contentView addSubview:lbJobTitle];
    
    UILabel *lbCompany = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 150, 21)];
    lbCompany.backgroundColor = [UIColor clearColor];
    lbCompany.textColor = TEXT_COLOR;
    lbCompany.text = [dict objectForKey:@"company"];
    lbCompany.font = [UIFont systemFontOfSize:13];
    [cell.contentView addSubview:lbCompany];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = GREY_BACKGROUND_COLOR;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.navigationItem.title = @"";
    
    NSDictionary *dict = [mainArray objectAtIndex:indexPath.row];
    
    DetailViewController *controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    controller.parent = self;
    controller.detailDict = dict;
    controller.viewType = viewType;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
