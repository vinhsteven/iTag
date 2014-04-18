//
//  ListJobViewController.m
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import "ListJobViewController.h"
#import "DetailViewController.h"

@interface ListJobViewController ()

@end

@implementation ListJobViewController
@synthesize viewType;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BLACK_BACKGROUND_COLOR;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:TEXT_COLOR forKey:UITextAttributeTextColor];
    
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
    
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    
    // Change the frame size to suit yours //
    
    [navBorder setBackgroundColor:LINE_COLOR];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 90;
    self.tableView.separatorColor = LINE_COLOR;
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = CGRectMake(0, 0, 22, 9);
    [btnLeft setImage:[UIImage imageNamed:@"icon_menu.png"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(leftButtonPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem = btnItem;
}

- (void) leftButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void) viewWillAppear:(BOOL)animated {
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
    lbJobTitle.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:lbJobTitle];
    
    UILabel *lbCompany = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 150, 21)];
    lbCompany.backgroundColor = [UIColor clearColor];
    lbCompany.textColor = [UIColor whiteColor];
    lbCompany.text = [dict objectForKey:@"companyName"];
    lbCompany.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:lbCompany];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.navigationItem.title = @"";
    
    NSDictionary *dict = [mainArray objectAtIndex:indexPath.row];
    
    DetailViewController *controller;
    if ([AppDelegate getDevice] == IPHONE_5)
        controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    else
        controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController-480" bundle:nil];
    controller.parent = self;
    controller.detailDict = dict;
    controller.viewType = viewType;
    [self.navigationController pushViewController:controller animated:YES];
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // To "clear" the footer view
    return [UIView new];
}


@end
