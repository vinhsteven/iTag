//
//  APPViewController.m
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPViewController.h"
#import "APPChildViewController.h"

@interface APPViewController ()

@end

@implementation APPViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:TEXT_COLOR forKey:UITextAttributeTextColor];
    
    self.navigationItem.title = @"iTAG";
    
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    
    // Change the frame size to suit yours //
    
    [navBorder setBackgroundColor:[UIColor lightGrayColor]];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
    
    mainArray = [NSMutableArray arrayWithCapacity:1];
    
    NSString *text[] = {
        @"- Safe environment low health risks and crime rate \n\n - Interact with people multi-nationals and multi-cultural backgrounds",
        @"- Workforce that embaraces diversity, offering an international working environment and experience \n\n - Self-enhancement improve English Language proficiency, EQ, and managerial skills",
        @"- Abundance of opportunites growth potential and career development in one of Asia's most advanced economies"
    };
    
    NSString *bgImg[] = {
        @"screen_1.jpg",
        @"screen_2.jpg",
        @"screen_3.jpg"
    };
    
    for (int i=0;i < sizeof(text)/sizeof(bgImg[0]);i++){
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:text[i],@"text",bgImg[i],@"background",[NSNumber numberWithInt:i],@"index",nil];
        [mainArray addObject:dict];
    }
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    
//    [[self.pageController view] setFrame:[[self view] bounds]];
    
    if ([AppDelegate getOSVersion] == iOS6) {
        [[self.pageController view] setFrame:CGRectMake(0, 0, 320, 550)];
        
        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tmpBtn.frame = CGRectMake(280, 5, 70, 21);
        [tmpBtn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
        [tmpBtn setTitle:@"Skip" forState:UIControlStateNormal];
        [tmpBtn addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
        
        btnSkip = [[UIBarButtonItem alloc] initWithCustomView:tmpBtn];
    }
    else {
        [[self.pageController view] setFrame:CGRectMake(0, 0, 320,490)];
        
        self.pageController.view.center = CGPointMake(self.pageController.view.center.x, self.pageController.view.center.y+64);
        
        //add button skip
        btnSkip = [[UIBarButtonItem alloc] initWithTitle:@"Skip" style:UIBarButtonItemStylePlain target:self action:@selector(skipAction)];
    }
    
    APPChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (APPChildViewController *)viewControllerAtIndex:(NSUInteger)index {
        
    APPChildViewController *childViewController;
    if ([AppDelegate getDevice] == IPHONE_5)
        childViewController = [[APPChildViewController alloc] initWithNibName:@"APPChildViewController" bundle:nil];
    else
        childViewController = [[APPChildViewController alloc] initWithNibName:@"AppChildViewController-480" bundle:nil];
    childViewController.index = index;
    childViewController.detailDict = [mainArray objectAtIndex:index];
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    self.navigationItem.rightBarButtonItem = nil;
    [(APPChildViewController *)viewController checkHiddenSignUpButton:YES];
    
    NSUInteger index = [(APPChildViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(APPChildViewController *)viewController index];
    
    index++;
    
    if (index == [mainArray count]) {
        self.navigationItem.rightBarButtonItem = btnSkip;
        [(APPChildViewController *)viewController checkHiddenSignUpButton:NO];
        return nil;
    }
    else {
        self.navigationItem.rightBarButtonItem = nil;
        [(APPChildViewController *)viewController checkHiddenSignUpButton:YES];
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [mainArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (void) skipAction {
    LoginViewController *loginVC;
    if ([AppDelegate getDevice] == IPHONE_5)
        loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    else
        loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController-480" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    navigationController.view.frame = loginVC.view.frame;
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    loginVC.view.bounds = loginVC.view.frame;
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = navigationController;
}

@end
