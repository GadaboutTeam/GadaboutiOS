//
//  FBLoginViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

// Frameworks
#import <pop/POP.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

// App Imports
#import "LoginViewController.h"
#import "PushStoryBoardSegue.h"
#import "User.h"
#import "UserManager.h"
#import "NetworkingManager.h"

@interface LoginViewController ()

// Realm
@property RLMRealm *defaultRealm;

// facebook
@property (nonatomic, strong) FBSDKAccessToken *accessToken;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissView) name:                FBSDKAccessTokenDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (IBAction)loginWasPressed:(id)sender {
    [[UserManager sharedUserController] login];
}

- (void)dismissView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate methods

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//
//
//
//}

@end
