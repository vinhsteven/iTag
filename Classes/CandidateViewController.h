//
//  CandidateViewController.h
//  iTag
//
//  Created by Steven on 4/16/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListJobViewController.h"

@interface CircleView : UIView {
    
}
@end

@interface CandidateViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    int viewType;
}

@property (strong, nonatomic) id m_parentController;
@property (strong, nonatomic) UILabel *lbNotification;
@property (strong, nonatomic) CircleView *cirleNotification;
@property (strong, nonatomic) IBOutlet UILabel *lbName;
@property (strong, nonatomic) IBOutlet UITextField *txtJob;
@property (strong, nonatomic) IBOutlet UITextField *txtSchool;
@property (strong, nonatomic) IBOutlet UIButton *btnApplication;
@property (strong, nonatomic) IBOutlet UIButton *btnResume;
@property (strong, nonatomic) IBOutlet UIButton *btnSearchJobs;
@property (strong, nonatomic) IBOutlet UIButton *btnSavedJobs;
@property (strong, nonatomic) IBOutlet UIImageView *profileImgView;
@property (strong, nonatomic) IBOutlet UILabel *lbDateAvailable;

- (IBAction)tapApplication:(id)sender;
- (IBAction)tapResume:(id)sender;
- (IBAction)tapSearchJobs:(id)sender;
- (IBAction)tapSavedJobs:(id)sender;

@end
