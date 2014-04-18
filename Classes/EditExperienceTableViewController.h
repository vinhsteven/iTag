//
//  EditExperienceTableViewController.h
//  iTag
//
//  Created by Steven on 4/17/14.
//  Copyright (c) 2014 NhuanQuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditExperienceTableViewController : UITableViewController {
    UIButton *btnCancel;
    UIButton *btnDone;
    int isModeAddMore;
    UIView *headerTitleView;
    UITextField *txtYear;
    UITextField *txtDescription;
    NSMutableDictionary *addMoreDict;
}

@property (assign) int expType;
@property (strong, nonatomic) NSMutableArray *mainArray;

@end
