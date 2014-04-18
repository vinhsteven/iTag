//
//  ResumeViewController.h
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResumeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate> {
    NSMutableArray *workExperienceArray;
    NSMutableArray *educationArray;
}

@property (strong, nonatomic) IBOutlet UIButton *btnCancelProfile;
@property (strong, nonatomic) IBOutlet UIButton *btnEditDoneProfile;
@property (strong, nonatomic) IBOutlet UIButton *btnEditImageProfile;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingTableView *mainTableView;
@property (strong, nonatomic) IBOutlet UITextField *txtJobTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtSchool;
@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *lbName;

- (IBAction)tapCancelProfile:(id)sender;
- (IBAction)tapEditProfile:(id)sender;
- (IBAction)tapEditImageProfile:(id)sender;

@end
