//
//  SignUpViewController.m
//  iTag
//
//  Created by Steven on 4/15/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import "SignUpViewController.h"

enum {
    kFirstNameTag = 0,
    kLastNameTag,
    kEmailTag,
    kGenderTag,
    kPasswordTag,
    kRetypePasswordTag,
    kDOBTag,
    kMobileTag,
};

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    
    self.view.backgroundColor = GREY_BACKGROUND_COLOR;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:TEXT_COLOR forKey:UITextAttributeTextColor];
    self.navigationItem.title = @"Sign up";
    
    txtFirstName = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
    txtFirstName.borderStyle = UITextBorderStyleNone;
    txtFirstName.placeholder = @"Required";
    txtFirstName.textAlignment = NSTextAlignmentLeft;
    
    txtLastName = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
    txtLastName.borderStyle = UITextBorderStyleNone;
    txtLastName.placeholder = @"Required";
    txtLastName.textAlignment = NSTextAlignmentLeft;
    
    txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
    txtEmail.borderStyle = UITextBorderStyleNone;
    txtEmail.placeholder = @"name@email.com";
    txtEmail.textAlignment = NSTextAlignmentLeft;
    
    txtGender = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
    txtGender.borderStyle = UITextBorderStyleNone;
    txtGender.placeholder = @"Required";
    txtGender.textAlignment = NSTextAlignmentLeft;
    
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
    txtPassword.borderStyle = UITextBorderStyleNone;
    txtPassword.placeholder = @"Password";
    txtPassword.textAlignment = NSTextAlignmentLeft;
    
    txtRetypePassword = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
    txtRetypePassword.borderStyle = UITextBorderStyleNone;
    txtRetypePassword.placeholder = @"Retype Password";
    txtRetypePassword.textAlignment = NSTextAlignmentLeft;
    
    txtDOB = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
    txtDOB.borderStyle = UITextBorderStyleNone;
    txtDOB.placeholder = @"Date of Birth";
    txtDOB.textAlignment = NSTextAlignmentLeft;
    
    txtMobile = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
    txtMobile.borderStyle = UITextBorderStyleNone;
    txtMobile.placeholder = @"Mobile No";
    txtMobile.textAlignment = NSTextAlignmentLeft;
    
    mainArray = [NSMutableArray arrayWithCapacity:1];
    NSString *titleStr[] = {
        @"First Name",
        @"Last Name",
        @"Email",
        @"Gender",
        @"Password",
        @"Enter Again",
        @"Date of Birth",
        @"Mobile No"
    };
    
    for (int i=0;i < sizeof(titleStr)/sizeof(titleStr[0]);i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:i],@"index",titleStr[i],@"title", nil];
        [mainArray addObject:dict];
    }
    
    self.mainTableView.backgroundColor = [UIColor clearColor];
    
    if ([AppDelegate getOSVersion] == iOS6) {
        self.mainTableView.center = CGPointMake(self.mainTableView.center.x, self.mainTableView.center.y-64);
        self.lbTermCondition.center = CGPointMake(self.lbTermCondition.center.x, self.lbTermCondition.center.y-64);
        
        UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDone.frame = CGRectMake(290, 5, 70, 21);
        [btnDone setTitle:@"Done" forState:UIControlStateNormal];
        [btnDone setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
        [btnDone addTarget:self action:@selector(confirmSignUp) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *btnBarDone = [[UIBarButtonItem alloc] initWithCustomView:btnDone];
        self.navigationItem.rightBarButtonItem = btnBarDone;
        
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBack.frame = CGRectMake(10, 5, 13, 22);
        [btnBack setImage:[UIImage imageNamed:@"icon_back_yellow"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *btnBarBack = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
        self.navigationItem.leftBarButtonItem = btnBarBack;
    }
    else {
        UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(confirmSignUp)];
        self.navigationItem.rightBarButtonItem = btnDone;
    }
}

//for iOS < 7
- (void) backView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) confirmSignUp {
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Successfully" message:@"Your account was signed up successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [dialog show];
}

#pragma mark UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    NSDictionary *dict = [mainArray objectAtIndex:indexPath.row];
    int index = [[dict objectForKey:@"index"] intValue];
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    lbTitle.font = txtFirstName.font;
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.text = [dict objectForKey:@"title"];
    [cell.contentView addSubview:lbTitle];
    
    switch (index) {
        case kFirstNameTag:
            [cell.contentView addSubview:txtFirstName];
            break;
        case kLastNameTag:
            [cell.contentView addSubview:txtLastName];
            break;
        case kEmailTag:
            [cell.contentView addSubview:txtEmail];
            break;
        case kPasswordTag:
            [cell.contentView addSubview:txtPassword];
            break;
        case kRetypePasswordTag:
            [cell.contentView addSubview:txtRetypePassword];
            break;
        case kGenderTag:
            [cell.contentView addSubview:txtGender];
            break;
        case kDOBTag:
            [cell.contentView addSubview:txtDOB];
            break;
        case kMobileTag:
            [cell.contentView addSubview:txtMobile];
            break;
        default:
            break;
    }
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UIAlertViewDelegate {
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
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
