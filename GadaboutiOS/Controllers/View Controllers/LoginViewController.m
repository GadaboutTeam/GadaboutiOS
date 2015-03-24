//
//  FBLoginViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <pop/POP.h>
#import "LoginViewController.h"
#import "PushStoryBoardSegue.h"
#import <TwitterKit/TwitterKit.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {

}

- (IBAction)loginWasPressed:(id)sender {
    DGTAppearance *appearance = [[DGTAppearance alloc] init];
    
    appearance.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    appearance.accentColor = [UIColor colorWithRed:0.99 green:0.33 blue:0.33 alpha:1];
   
    Digits *digits = [Digits sharedInstance];
    [digits authenticateWithDigitsAppearance:appearance
                              viewController:nil
                                       title:nil
                                  completion:^(DGTSession *session, NSError *error) {
                                        if (session) {
                                            NSLog(@"Logged in!");
                                        } else {
                                            NSLog(@"Something went weird!");
                                        }
                                  }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIViewControllerTransitioningDelegate methods

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//
//
//
//}

@end
