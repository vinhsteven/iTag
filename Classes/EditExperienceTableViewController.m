//
//  EditExperienceTableViewController.m
//  iTag
//
//  Created by Steven on 4/17/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import "EditExperienceTableViewController.h"

@interface EditExperienceTableViewController ()

@end

@implementation EditExperienceTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:TEXT_COLOR forKey:UITextAttributeTextColor];
    
    self.navigationItem.title = @"Resume";
    
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    
    // Change the frame size to suit yours //
    
    [navBorder setBackgroundColor:LINE_COLOR];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
    

    //add title header view
    headerTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 22)];
    
    btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(250, 5, 75, 21);
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    btnDone.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(confirmAddExp) forControlEvents:UIControlEventTouchUpInside];
    
    btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(0, 5, 75, 21);
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(cancelAddMore) forControlEvents:UIControlEventTouchUpInside];
    
    btnCancel.hidden = btnDone.hidden = YES;
    
    [headerTitleView addSubview:btnDone];
    [headerTitleView addSubview:btnCancel];
    
    isModeAddMore = NO;
    
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.tableView.frame.size.width, 22)];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont boldSystemFontOfSize:18]];
    label.textAlignment = NSTextAlignmentCenter;
    
    NSString *string = @"";
    
    /* Section header is in 0th index... */
    [headerTitleView addSubview:label];
    [headerTitleView setBackgroundColor:BLACK_BACKGROUND_COLOR]; //your background color...
    label.textColor = TEXT_COLOR;
    
    if (_expType == 0) {
        string = @"Work Experience";
    }
    else {
        string = @"Education";
    }
    
    [label setText:string];
    
    if (_mainArray == nil)
        _mainArray = [NSMutableArray arrayWithCapacity:1];
    //create dictionary to store textfield
    txtYear = [[UITextField alloc] initWithFrame:CGRectMake(50, 5, 80, 21)];
    txtYear.borderStyle = UITextBorderStyleNone;
    txtYear.textColor = [UIColor whiteColor];
    txtYear.font = [UIFont systemFontOfSize:14];
    
    txtDescription = [[UITextField alloc] initWithFrame:CGRectMake(130, 5, 190, 21)];
    txtDescription.borderStyle = UITextBorderStyleNone;
    txtDescription.textColor = [UIColor whiteColor];
    txtDescription.font = [UIFont systemFontOfSize:14];
    
    UIColor *color = [UIColor lightTextColor];
    txtYear.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Year" attributes:@{NSForegroundColorAttributeName: color}];
    txtDescription.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Title & Company" attributes:@{NSForegroundColorAttributeName: color}];
    
    addMoreDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:txtYear,@"txtYear",txtDescription,@"txtDescription",@1,@"rowTextField", nil];
    
    //add row add more
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@1,@"rowAddMore", nil];
    [_mainArray addObject:tmpDict];
    
    //add button left
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = CGRectMake(0, 0, 22, 9);
    [btnLeft setImage:[UIImage imageNamed:@"icon_menu.png"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(leftButtonPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    self.tableView.backgroundColor = BLACK_BACKGROUND_COLOR;
    self.tableView.separatorColor  = [UIColor clearColor];
}

- (void) leftButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void) cancelAddMore {
    [_mainArray removeObject:addMoreDict];
    isModeAddMore = NO;
    [self.tableView reloadData];
}

- (void) confirmAddExp {
    if ([txtYear.text isEqualToString:@""]) {
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please input Year." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [dialog show];
        return;
    }
    if ([txtDescription.text isEqualToString:@""]) {
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please input Title & Company." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [dialog show];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:txtYear.text,@"year",txtDescription.text,@"description", nil];
    [_mainArray insertObject:dict atIndex:[_mainArray count]-2];
    
    //reset text field
    txtYear.text = txtDescription.text = @"";
    [self.tableView reloadData];
}

#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (isModeAddMore) {
        btnCancel.hidden = btnDone.hidden = NO;
    }
    else {
        btnCancel.hidden = btnDone.hidden = YES;
    }
    return headerTitleView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    // Configure the cell...
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    NSDictionary *dict = [_mainArray objectAtIndex:indexPath.row];
    
    if ([[dict objectForKey:@"rowAddMore"] intValue]) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_add.png"]];
        imgView.frame = CGRectMake(20, 5, 22, 22);
        [cell.contentView addSubview:imgView];
        
        UILabel *lbAddMore = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 21)];
        lbAddMore.backgroundColor = [UIColor clearColor];
        lbAddMore.text = @"add more";
        lbAddMore.textColor = TEXT_COLOR;
        lbAddMore.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:lbAddMore];
    }
    else if ([[dict objectForKey:@"rowTextField"] intValue]) {
        UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDelete.frame = CGRectMake(20, 5, 22, 22);
        [btnDelete setImage:[UIImage imageNamed:@"icon_sub.png"] forState:UIControlStateNormal];
        [btnDelete addTarget:self action:@selector(deleteRow:) forControlEvents:UIControlEventTouchUpInside];
        btnDelete.tag = indexPath.row + 50;
        [cell.contentView addSubview:btnDelete];
        
        UITextField *tmptxtYear = [dict objectForKey:@"txtYear"];
        UITextField *tmptxtDesc = [dict objectForKey:@"txtDescription"];
        [cell.contentView addSubview:tmptxtYear];
        [cell.contentView addSubview:tmptxtDesc];
    }
    else {
        UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDelete.frame = CGRectMake(20, 5, 22, 22);
        [btnDelete setImage:[UIImage imageNamed:@"icon_sub.png"] forState:UIControlStateNormal];
        [btnDelete addTarget:self action:@selector(deleteRow:) forControlEvents:UIControlEventTouchUpInside];
        btnDelete.tag = indexPath.row + 50;
        [cell.contentView addSubview:btnDelete];
        
        UILabel *lbYear = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 80, 21)];
        lbYear.backgroundColor = [UIColor clearColor];
        lbYear.text = [dict objectForKey:@"year"];
        lbYear.textColor = [UIColor whiteColor];
        lbYear.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:lbYear];
        [lbYear sizeToFit];
        
        UILabel *lbDescription = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 190, 40)];
        lbDescription.numberOfLines = 2;
        lbDescription.backgroundColor = [UIColor clearColor];
        lbDescription.text = [dict objectForKey:@"description"];
        lbDescription.textColor = [UIColor whiteColor];
        lbDescription.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:lbDescription];
        [lbDescription sizeToFit];
    }
    
    cell.backgroundColor = BLACK_BACKGROUND_COLOR;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = [_mainArray objectAtIndex:indexPath.row];
    
    if ([[dict objectForKey:@"rowAddMore"] intValue] && !isModeAddMore) {
        txtYear.text = txtDescription.text = @"";
        btnCancel.hidden = btnDone.hidden = NO;
        [_mainArray insertObject:addMoreDict atIndex:[_mainArray count]-1];
        [self.tableView reloadData];
        [txtYear becomeFirstResponder];
        isModeAddMore = YES;
    }
}

- (void) deleteRow:(UIButton*)sender {
    int index = sender.tag - 50;
    NSDictionary *dict = [_mainArray objectAtIndex:index];
    if ([[dict objectForKey:@"rowTextField"] intValue]) {
        [_mainArray removeObject:addMoreDict];
        isModeAddMore = NO;
        [self.tableView reloadData];
    }
    else {
        [_mainArray removeObjectAtIndex:index];
        [self.tableView reloadData];
    }
}

@end
