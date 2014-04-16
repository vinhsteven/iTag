//
//  ListJobViewController.m
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import "ListJobViewController.h"

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
    
    self.view.backgroundColor = GREY_BACKGROUND_COLOR;
    
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
    
    [navBorder setBackgroundColor:[UIColor lightGrayColor]];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 90;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
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
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
