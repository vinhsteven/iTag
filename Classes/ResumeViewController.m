//
//  ResumeViewController.m
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import "ResumeViewController.h"

@interface ResumeViewController ()

@end

@implementation ResumeViewController

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
    
    //init work experience array
    NSString *workExpYear[] = {
        @"2006-2014",
        @"2004-2006"
    };
    
    NSString *workExpDesciption[] = {
        @"Account Executive at OCBC Singapore",
        @"Junior Executive at DBS Singapore"
    };
    
    for (int i=0;i < sizeof(workExpYear)/sizeof(workExpYear[0]);i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:workExpYear[i],@"workExpYear",workExpDesciption[i],@"workExpDescription", nil];
        [workExperienceArray addObject:dict];
    }
    
    //init education experience array
    NSString *eduYear[] = {
        @"2002-2005",
    };
    
    NSString *eduDesciption[] = {
        @"Singapore Management University",
    };
    
    for (int i=0;i < sizeof(workExpYear)/sizeof(workExpYear[0]);i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:eduYear[i],@"eduYear",eduDesciption[i],@"eduDesciption", nil];
        [educationArray addObject:dict];
    }
    
    self.mainTableView.backgroundColor = GREY_BACKGROUND_COLOR;
    self.mainTableView.separatorColor  = [UIColor clearColor];
}

#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];

    NSString *string = @"";
    
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor clearColor]]; //your background color...
    label.textColor = TEXT_COLOR;
    
    if (section == 0)
        string = @"Work Experience";
    else
        string = @"Education";
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
        return [workExperienceArray count];
    else
        return [educationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    // Configure the cell...
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    NSDictionary *dict;
    if (indexPath.section == 0) {
        dict = [workExperienceArray objectAtIndex:indexPath.row];
    }
    else {
        dict = [educationArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

@end
