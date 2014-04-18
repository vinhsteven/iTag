//
//  ResumeViewController.m
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import "ResumeViewController.h"
#import "EditExperienceTableViewController.h"

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
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:TEXT_COLOR forKey:UITextAttributeTextColor];
    
    self.navigationItem.title = @"Resume";
    
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    
    // Change the frame size to suit yours //
    
    [navBorder setBackgroundColor:[UIColor lightGrayColor]];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
    
    
    workExperienceArray = [NSMutableArray arrayWithCapacity:1];
    educationArray = [NSMutableArray arrayWithCapacity:1];
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
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:workExpYear[i],@"year",workExpDesciption[i],@"description", nil];
        [workExperienceArray addObject:dict];
    }
    
    //init education experience array
    NSString *eduYear[] = {
        @"2002-2005",
    };
    
    NSString *eduDesciption[] = {
        @"Singapore Management University",
    };
    
    for (int i=0;i < sizeof(eduYear)/sizeof(eduYear[0]);i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:eduYear[i],@"year",eduDesciption[i],@"description", nil];
        [educationArray addObject:dict];
    }
    
    self.mainTableView.backgroundColor = GREY_BACKGROUND_COLOR;
    self.mainTableView.separatorColor  = [UIColor clearColor];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = CGRectMake(0, 0, 22, 9);
    [btnLeft setImage:[UIImage imageNamed:@"icon_menu.png"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(leftButtonPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    _btnCancelProfile.hidden = YES;
    [_btnEditDoneProfile setTitle:@"Edit" forState:UIControlStateNormal];
    
    _txtJobTitle.enabled = _txtSchool.enabled = NO;
    
    _profileImg.layer.cornerRadius = 35;
    _profileImg.layer.borderColor = [UIColor blackColor].CGColor;
    _profileImg.layer.borderWidth = 0.5;
    
    _btnEditImageProfile.hidden = YES;
}

- (void) leftButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)tapCancelProfile:(id)sender {
    _btnCancelProfile.hidden = _btnEditImageProfile.hidden = YES;
    [_btnEditDoneProfile setTitle:@"Edit" forState:UIControlStateNormal];
    
    _txtJobTitle.enabled = _txtSchool.enabled = NO;
}

- (IBAction)tapEditProfile:(id)sender {
    if ([_btnEditDoneProfile.titleLabel.text isEqualToString:@"Edit"]) {
        [_btnEditDoneProfile setTitle:@"Done" forState:UIControlStateNormal];
        _btnCancelProfile.hidden = _btnEditImageProfile.hidden = NO;
        
        _txtJobTitle.enabled = _txtSchool.enabled = YES;
    }
    else {
        [_btnEditDoneProfile setTitle:@"Edit" forState:UIControlStateNormal];
        _btnCancelProfile.hidden = _btnEditImageProfile.hidden = YES;
        
        _txtJobTitle.enabled = _txtSchool.enabled = NO;
    }
}

- (void) handleEditWorkExp {
    EditExperienceTableViewController *controller = [[EditExperienceTableViewController alloc] init];
    controller.expType = 0;
    controller.mainArray = [workExperienceArray mutableCopy];
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    naviController.navigationBar.barStyle = UIBarStyleBlack;
    [self.mm_drawerController
     setCenterViewController:naviController
     withCloseAnimation:YES
     completion:nil];
}

- (void) handleEditEduExp {
    EditExperienceTableViewController *controller = [[EditExperienceTableViewController alloc] init];
    controller.expType = 1;
    controller.mainArray = [educationArray mutableCopy];
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    naviController.navigationBar.barStyle = UIBarStyleBlack;
    [self.mm_drawerController
     setCenterViewController:naviController
     withCloseAnimation:YES
     completion:nil];
}

- (IBAction)tapEditImageProfile:(id)sender {
//    NSString *actionSheetTitle = NSLocalizedString(@"profile_upload_avatar_title", nil); //Action Sheet Title
//    NSString *destructiveTitle = @"Cancel"; //Action Sheet Button Titles
    NSString *other1 = @"Take Photo";
    NSString *other2 = @"Choose Existing";
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Delete"
                                  otherButtonTitles:other1, other2, nil];
    [actionSheet showInView:self.view];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if  (buttonIndex == 0) {
        NSLog(@"AA");
    }
    else if(buttonIndex == 1)
    {
        NSLog(@"Take a Photo");

        if([UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
    else if (buttonIndex == 2)
    {
        NSLog(@"Choose from Library");
        if([UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
    CGSize size = CGSizeMake(500, 500);
    UIImage *croppedImage = [AppDelegate imageByScalingAndCroppingForSize:size source:image];
//    NSData *cropimageData = UIImageJPEGRepresentation(croppedImage, 0.5);
    
    _profileImg.image = croppedImage;
    
    _profileImg.layer.cornerRadius = 50;
    _profileImg.layer.masksToBounds = YES;
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 22)];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont boldSystemFontOfSize:14]];

    NSString *string = @"";
    
    /* Section header is in 0th index... */
    [view addSubview:label];
    [view setBackgroundColor:GREY_BACKGROUND_COLOR]; //your background color...
    label.textColor = TEXT_COLOR;
    
    //add button Edit
    UIButton *btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEdit.frame = CGRectMake(250, 5, 100, 21);
    [btnEdit setTitle:@"Edit" forState:UIControlStateNormal];
    btnEdit.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:btnEdit];
    
    if (section == 0) {
        string = @"Work Experience";
        [btnEdit addTarget:self action:@selector(handleEditWorkExp) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        string = @"Education";
        [btnEdit addTarget:self action:@selector(handleEditEduExp) forControlEvents:UIControlEventTouchUpInside];
    }
    [label setText:string];
    
    //create line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineView];
    
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
    
    UILabel *lbYear = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 21)];
    lbYear.backgroundColor = [UIColor clearColor];
    lbYear.text = [dict objectForKey:@"year"];
    lbYear.textColor = [UIColor whiteColor];
    lbYear.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:lbYear];
    [lbYear sizeToFit];
    
    UILabel *lbDescription = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 40)];
    lbDescription.numberOfLines = 2;
    lbDescription.backgroundColor = [UIColor clearColor];
    lbDescription.text = [dict objectForKey:@"description"];
    lbDescription.textColor = [UIColor whiteColor];
    lbDescription.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:lbDescription];
    [lbDescription sizeToFit];
    
    cell.backgroundColor = GREY_BACKGROUND_COLOR;
    cell.userInteractionEnabled = NO;
    
    return cell;
}

@end
