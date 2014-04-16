//
//  ResumeViewController.h
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResumeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *workExperienceArray;
    NSMutableArray *educationArray;
}

@property (strong, nonatomic) IBOutlet UIButton *btnCancelProfile;
@property (strong, nonatomic) IBOutlet UIButton *btnEditDoneProfile;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingTableView *mainTableView;

@end
