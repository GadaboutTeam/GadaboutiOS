//
//  FBLoginViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <pop/POP.h>
#import "FBLoginViewController.h"
#import "PushStoryBoardSegue.h"
#import <TwitterKit/TwitterKit.h>

@interface FBLoginViewController ()

@end

@implementation FBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        // play with Digits session
    }];
    authenticateButton.center = self.view.center;
    [self.view addSubview:authenticateButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {

}

- (IBAction)loginWithFacebook:(id)sender {
//    if (FBSession.activeSession.state == FBSessionStateOpen || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
//        NSLog(@"User already logged in.");
//    } else {
//        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
//            NSLog(@"User successfully logged in.");
//
//            [self performSegueWithIdentifier:@"PushToLocation" sender:self];
//        }];
//    }
//    [FBGraphController updateUserInfo];
//    
//    // Send notification that user is logged in, and dismisses it.
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessful" object:self];
//    
//    // Dismiss login screen
//    [self dismissViewControllerAnimated:YES completion:nil];
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
